import 'dart:convert';
import 'package:swallet_mobile/data/models/authen_model.dart';
import 'package:swallet_mobile/data/models/student_features/create_model/create_authen_model.dart';
import 'package:swallet_mobile/domain/interface_repositories/authentication_repository.dart';

import '../../presentation/config/constants.dart';
import '../datasource/authen_local_datasource.dart';
import 'package:http/http.dart' as http;


class AuthenticationRepositoryImp implements AuthenticationRepository {
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

      http.Response response = await http.post(
        Uri.parse('$endPoint/login'),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        authenModel = AuthenModel.fromJson(result);
        if (authenModel.role == 'Sinh viên') {
          String authenString = jsonEncode(authenModel);

          AuthenLocalDataSource.saveAuthen(authenString);
          AuthenLocalDataSource.saveToken(authenModel.jwt);
          AuthenLocalDataSource.saveAccountId(authenModel.accountId);
          AuthenLocalDataSource.saveIsVerified(authenModel.isVerified);

          return authenModel;
        } else if (authenModel.role.contains("Giáo viên")) {
          String authenString = jsonEncode(authenModel);
          AuthenLocalDataSource.saveAuthen(authenString);
          AuthenLocalDataSource.saveToken(authenModel.jwt);
          AuthenLocalDataSource.saveAccountId(authenModel.accountId);
          AuthenLocalDataSource.saveIsVerified(authenModel.isVerified);
          return authenModel;
        } else {
          String authenString = jsonEncode(authenModel);
          AuthenLocalDataSource.saveAuthen(authenString);
          AuthenLocalDataSource.saveToken(authenModel.jwt);
          AuthenLocalDataSource.saveAccountId(authenModel.accountId);
          return authenModel;
        }
      }
      return null;
    } catch (e) {
      print(e);
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
  //     final streamedResponse = await http.Client().send(req);
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
          createAuthenModel.studentFrontCard!,
        ),
      );

      //thêm headers
      request.headers.addAll(headers);

      //thêm field cho request
      request.fields.addAll({
        'UserName': createAuthenModel.userName!,
        'Password': createAuthenModel.password!,
        'CampusId': createAuthenModel.campusId!,
        'FullName': createAuthenModel.fullName!,
        'Code': createAuthenModel.code!,
        'Gender': createAuthenModel.gender.toString(),
        'InviteCode': createAuthenModel.inviteCode!,
        'Email': createAuthenModel.email!,
        'DateOfBirth': createAuthenModel.dateofBirth!,
        'Phone': createAuthenModel.phoneNumber!,
        'Address': 'default',
        'Description': 'default',
        'State': 'true',
      });

      //gửi request
      var response = await request.send();

      if (response.statusCode == 200) {
        print(response);
        return true;
      } else {
        return false;
      }
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
  //     var streamedResponse = await request.send();
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
