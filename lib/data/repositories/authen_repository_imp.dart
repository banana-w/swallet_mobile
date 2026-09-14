import 'dart:convert';
import 'package:swallet_mobile/data/datasource/api_exceptions.dart';
import 'package:swallet_mobile/data/models/authen_model.dart';
import 'package:swallet_mobile/domain/entities/account_role.dart';
import 'package:swallet_mobile/data/models/student_features/create_model/create_authen_model.dart';
import 'package:swallet_mobile/data/interface_repositories/authentication_repository.dart';
import 'package:swallet_mobile/data/repositories/lecture_features/lecture_repository_imp.dart';

import '../../presentation/config/constants.dart';
import '../datasource/authen_local_datasource.dart';
import 'package:http/http.dart' as http;
import 'package:swallet_mobile/data/datasource/api_client.dart';

class AuthenticationRepositoryImp implements AuthenticationRepository {
  /// Cho phep test tiem client gia; app dung client dung chung.
  AuthenticationRepositoryImp({ApiClient? api}) : _api = api ?? ApiClient.public;

  final ApiClient _api;

  String endPoint = '${baseURL}Auth';
  late AuthenModel authenModel;
  @override
  Future<AuthenModel?> loginWithAccount(
    String userName,
    String password,
  ) async {
    try {
      final Map<String, String> headers = {'Content-Type': 'application/json'};

      Map<String, String> body = {'userName': userName, 'password': password};

      http.Response response = await _api.post(
        Uri.parse('$endPoint/login'),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        authenModel = AuthenModel.fromJson(result);
        final role = authenModel.accountRole;

        // Admin/Brand không có giao diện mobile. Trước đây mọi role không phải
        // Sinh viên/Giáo viên đều rơi vào nhánh else và được cấp quyền Cửa
        // hàng — đó là lỗ hổng phân quyền, nay chặn ngay tại đây.
        if (!role.isSupportedOnMobile) {
          throw UnsupportedRoleException(authenModel.role);
        }

        if (role == AccountRole.lecturer) {
          final lecture = await LectureRepositoryImp().fetchLectureById(
            accountId: authenModel.accountId,
          );
          if (lecture != null) {
            await AuthenLocalDataSource.saveBalance(lecture.balance.toInt());
          }
        }

        await AuthenLocalDataSource.saveAuthen(jsonEncode(authenModel));
        await AuthenLocalDataSource.saveToken(authenModel.jwt);
        await AuthenLocalDataSource.saveAccountId(authenModel.accountId);
        if (role != AccountRole.store) {
          await AuthenLocalDataSource.saveIsVerified(authenModel.isVerified);
        }
        return authenModel;
      }
      return null;
    } on AppException {
      rethrow; // đã có thông điệp cho người dùng, không bọc thêm
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // @override
  // Future<AuthenModel?> loginWithGmail(String idToken) async {
  //   try {
  //     Map<String, String> body = {'idToken': idToken};
  //     http.Request req = http.Request(
  //       'Post',
  //       Uri.parse('$endPoint/login/google'),
  //     )..followRedirects = false;
  //     req.headers['Content-Type'] = 'application/json';
  //     req.body = jsonEncode(body);
  //     final streamedResponse = await _api.send(req);
  //     final response = await http.Response.fromStream(streamedResponse);

  //     if (response.statusCode == 303) {
  //       final result = jsonDecode(utf8.decode(response.bodyBytes));
  //       UserModel userModel = UserModel.fromJson(result);
  //       this.authenModel = AuthenModel(
  //         jwt: '',
  //         userModel: userModel,
  //         role: 'Student',
  //       );
  //       String authenString = jsonEncode(this.authenModel);
  //       AuthenLocalDataSource.saveAuthen(authenString);
  //       return this.authenModel;
  //     } else if (response.statusCode == 200) {
  //       final result = jsonDecode(utf8.decode(response.bodyBytes));
  //       this.authenModel = AuthenModel.fromJson(result);
  //       String authenString = jsonEncode(AuthenModel.fromJson(result));
  //       AuthenLocalDataSource.saveAuthen(authenString);
  //       AuthenLocalDataSource.saveToken(authenModel.jwt);
  //       AuthenLocalDataSource.saveStudentId(authenModel.userModel.userId);
  //       return this.authenModel;
  //     }
  //     return null;
  //   } catch (e) {
  //     print(e);
  //     throw Exception(e.toString());
  //   }
  // }

  @override
  Future<bool> registerAccount(CreateAuthenModel createAuthenModel) async {
    try {
      // Form đăng ký trải qua 8 bước; thiếu bước nào thì trường tương ứng còn
      // null. Kiểm tra một lần ở đây để báo lỗi rõ ràng, thay vì để dấu `!`
      // ném TypeError giữa lúc dựng request.
      final fields = <String, String?>{
        'UserName': createAuthenModel.userName,
        'Password': createAuthenModel.password,
        'CampusId': createAuthenModel.campusId,
        'FullName': createAuthenModel.fullName,
        'Code': createAuthenModel.code,
        'Gender': createAuthenModel.gender?.toString(),
        'InviteCode': createAuthenModel.inviteCode,
        'Email': createAuthenModel.email,
        'DateOfBirth': createAuthenModel.dateofBirth,
        'Phone': createAuthenModel.phoneNumber,
      };
      final missing = fields.entries
          .where((entry) => (entry.value ?? '').isEmpty)
          .map((entry) => entry.key)
          .toList();
      if (missing.isNotEmpty) {
        throw IncompleteRegistrationException(missing);
      }
      final studentFrontCard = createAuthenModel.studentFrontCard;
      if (studentFrontCard == null || studentFrontCard.isEmpty) {
        throw IncompleteRegistrationException(const ['StudentCardFront']);
      }

      final Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
      };
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${baseURL}Account/studentRegister'),
      );

      //thêm file cho request
      request.files.add(
        await http.MultipartFile.fromPath(
          'StudentCardFront',
          studentFrontCard,
        ),
      );

      //thêm headers
      request.headers.addAll(headers);

      //thêm field cho request
      request.fields.addAll({
        for (final entry in fields.entries) entry.key: entry.value!,
        'Address': 'default',
        'Description': 'default',
        'State': 'true',
      });

      //gửi request
      var response = await _api.send(request);

      if (response.statusCode == 200) {
        print(response);
        return true;
      } else {
        return false;
      }
    } on AppException {
      rethrow;
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  // @override
  // Future<bool> verifyAccount(VerifyAuthenModel verifyAuthenModel) async {
  //   try {
  //     final authenModel = await AuthenLocalDataSource.getAuthen();
  //     final accountId = authenModel!.accountId;
  //     final Map<String, String> headers = {
  //       'Content-Type': 'multipart/form-data',
  //       'Accept': 'application/json',
  //     };
  //     var request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse('$endPoint/register/google'),
  //     );

  //     //thêm file cho request
  //     request.files.add(
  //       await http.MultipartFile.fromPath(
  //         'StudentCardFront',
  //         verifyAuthenModel.studentFrontCard!,
  //       ),
  //     );
  //     request.files.add(
  //       await http.MultipartFile.fromPath(
  //         'StudentCardBack',
  //         verifyAuthenModel.studentBackCard!,
  //       ),
  //     );

  //     //thêm headers
  //     request.headers.addAll(headers);

  //     //thêm field cho request
  //     request.fields.addAll({
  //       'CampusId': verifyAuthenModel.campusId!,
  //       'FullName': verifyAuthenModel.fullName!,
  //       'Code': verifyAuthenModel.code!,
  //       'Gender': verifyAuthenModel.gender.toString(),
  //       'InviteCode': verifyAuthenModel.inviteCode!,
  //       'Email': verifyAuthenModel.email!,
  //       'DateOfBirth': verifyAuthenModel.dateofBirth!,
  //       'Phone': verifyAuthenModel.phoneNumber!,
  //       'AccountId': accountId,
  //       'Address': '',
  //     });

  //     //gửi request
  //     var streamedResponse = await _api.send(request);
  //     var response = await http.Response.fromStream(streamedResponse);

  //     if (response.statusCode == 200) {
  //       print(response);
  //       final result = jsonDecode(utf8.decode(response.bodyBytes));
  //       this.authenModel = AuthenModel.fromJson(result);
  //       String authenString = jsonEncode(AuthenModel.fromJson(result));
  //       AuthenLocalDataSource.saveAuthen(authenString);
  //       AuthenLocalDataSource.saveToken(authenModel.jwt);
  //       AuthenLocalDataSource.saveAccountId(authenModel.accountId);
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     print(e);
  //     throw Exception(e.toString());
  //   }
  // }
}
