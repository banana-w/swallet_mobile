import 'dart:convert';

import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/api_response.dart';
// import 'package:swallet_mobile/data/models/api_response.dart';
// import 'package:swallet_mobile/data/models/student_features/create_model/create_order_model.dart';
// import 'package:swallet_mobile/data/models/student_features/order_detail_model.dart';
// import 'package:swallet_mobile/data/models/student_features/order_model.dart';
import 'package:swallet_mobile/data/models/student_features/student_model.dart';
import 'package:swallet_mobile/data/models/student_features/voucher_student_model.dart';
// import 'package:swallet_mobile/data/models/student_features/transaction_model.dart';
// import 'package:swallet_mobile/data/models/student_features/voucher_student_item_model.dart';
// import 'package:swallet_mobile/data/models/student_features/voucher_student_model.dart';
import 'package:swallet_mobile/domain/interface_repositories/student_features/student_repository.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:http/http.dart' as http;

class StudentRepositoryImp implements StudentRepository {
  String endPoint = '${baseURL}Student';
  String? token;
  String? studentId;
  String sort = 'Id%2Cdesc';
  int page = 1;
  int limit = 10;
  bool state = true;
  @override
  Future<StudentModel?> fetchStudentById({required String id}) async {
    try {
      token = await AuthenLocalDataSource.getToken();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      http.Response response = await http.get(
        Uri.parse('$endPoint/account/$id'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        StudentModel studentModel = StudentModel.fromJson(result);
        String studentString = jsonEncode(StudentModel.fromJson(result));
        AuthenLocalDataSource.saveStudent(studentString);
        // AuthenLocalDataSource.saveStudentId(studentModel.id);
        return studentModel;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateWalletByStudentId(String studentId, int point) async {
    final response = await http.post(
      Uri.parse('${baseURL}Wallet/student?studentId=$studentId&points=$point'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'studentId': studentId, 'points': point}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update wallet: ${response.body}');
    }
  }

  @override
  Future<ApiResponse<List<VoucherStudentModel>>?> fetchVoucherStudentId(
    int? page,
    int? limit,
    String? search,
    bool? isUsed, {
    required String id,
  }) async {
    try {
      token = await AuthenLocalDataSource.getToken();
      studentId = await AuthenLocalDataSource.getStudentId();
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      if (search != null) {
        http.Response response = await http.get(
          Uri.parse(
            '$endPoint/$id/vouchers?isUsed=$isUsed&state=$state&sort=$sort&search=$search&page=$page&limit=$limit',
          ),
          headers: headers,
        );
        if (response.statusCode == 200) {
          final result = jsonDecode(utf8.decode(response.bodyBytes));
          ApiResponse<List<VoucherStudentModel>> apiResponse =
              ApiResponse<List<VoucherStudentModel>>.fromJson(
                result,
                (data) =>
                    data.map((e) => VoucherStudentModel.fromJson(e)).toList(),
              );
          return apiResponse;
        } else {
          return null;
        }
      } else if (search == null || search == '') {
        http.Response response = await http.get(
          Uri.parse(
            '$endPoint/$id/vouchers?sort=$sort&page=$page&limit=$limit',
          ),
          headers: headers,
        );
        if (response.statusCode == 200) {
          final result = jsonDecode(utf8.decode(response.bodyBytes));
          ApiResponse<List<VoucherStudentModel>> apiResponse =
              ApiResponse<List<VoucherStudentModel>>.fromJson(
                result,
                (data) =>
                    data.map((e) => VoucherStudentModel.fromJson(e)).toList(),
              );
          return apiResponse;
        } else {
          return null;
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  // @override
  // Future<ApiResponse<List<TransactionModel>>?> fetchTransactionsStudentId(
  //     int? page, int? limit, int? typeIds,
  //     {required String id}) async {
  //   try {
  //     token = await AuthenLocalDataSource.getToken();
  //     studentId = await AuthenLocalDataSource.getStudentId();
  //     final Map<String, String> headers = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token'
  //     };
  //     if (typeIds == 0) {
  //       http.Response response = await http.get(
  //           Uri.parse(
  //               '$endPoint/$id/histories?state=$state&sort=$sort&page=$page&limit=$limit'),
  //           headers: headers);
  //       if (response.statusCode == 200) {
  //         final result = jsonDecode(utf8.decode(response.bodyBytes));
  //         ApiResponse<List<TransactionModel>> apiResponse =
  //             ApiResponse<List<TransactionModel>>.fromJson(
  //                 result,
  //                 (data) =>
  //                     data.map((e) => TransactionModel.fromJson(e)).toList());
  //         return apiResponse;
  //       } else {
  //         return null;
  //       }
  //     } else {
  //       http.Response response = await http.get(
  //           Uri.parse(
  //               '$endPoint/$id/histories?state=$state&typeIds=$typeIds&sort=$sort&page=$page&limit=$limit'),
  //           headers: headers);
  //       if (response.statusCode == 200) {
  //         final result = jsonDecode(utf8.decode(response.bodyBytes));
  //         ApiResponse<List<TransactionModel>> apiResponse =
  //             ApiResponse<List<TransactionModel>>.fromJson(
  //                 result,
  //                 (data) =>
  //                     data.map((e) => TransactionModel.fromJson(e)).toList());
  //         return apiResponse;
  //       } else {
  //         return null;
  //       }
  //     }
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  @override
  Future<bool?> postChallengeStudentId({
    required String studentId,
    required String challengeId,
  }) async {
    try {
      token = await AuthenLocalDataSource.getToken();
      studentId = (await AuthenLocalDataSource.getStudentId())!;
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      http.Response response = await http.post(
        Uri.parse('$endPoint/$studentId/challenges/$challengeId'),
        headers: headers,
      );

      if (response.statusCode == 201) {
        return true;
      } else if (response.statusCode == 400) {
        return false;
      } else if (response.statusCode == 404) {
        return false;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<StudentModel?> putStudent({
    required String studentId,
    required String fullName,
    required String campusId,
    required String studentCode,
    required DateTime dateOfBirth,
    required int gender,
    required String avatar,
    required String address,
  }) async {
    try {
      final authenModel = await AuthenLocalDataSource.getAuthen();
      final accountId = authenModel!.accountId;
      final token = await AuthenLocalDataSource.getToken();
      final headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      // Format dateOfBirth thành chuỗi YYYY-MM-DD
      final formattedDateOfBirth =
          "${dateOfBirth.year}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}";

      // Tạo URI với tất cả các tham số cần thiết
      final uri = Uri.parse(
        '${baseURL}Student/$accountId'
        '?campusId=$campusId'
        '&fullName=${Uri.encodeComponent(fullName)}'
        '&code=$studentCode'
        '&gender=$gender'
        '&dateOfBirth=$formattedDateOfBirth'
        '&address=${Uri.encodeComponent(address)}',
      );
      final response = await http.put(uri, headers: headers);

      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        result.addAll({
          'totalSpending': result['totalSpending'] ?? 1,
          'totalIncome': result['totalIncome'] ?? 1,
          'state': result['state'] ?? 1,
          'status': result['status'] ?? true,
          'fileNameFront': result['fileNameFront'] ?? 'fileName',
          'fileNameBack': result['fileNameBack'] ?? 'fileName',
        });
        StudentModel studentModel = StudentModel.fromJson(result);
        String studentString = jsonEncode(studentModel);
        AuthenLocalDataSource.saveStudent(studentString);
        return studentModel;
      } else {
        print('API error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception(e.toString());
    }
  }

  // @override
  // Future<VoucherStudentItemModel?> fetchVoucherItemByStudentId(
  //     {required String studentId, required String voucherId}) async {
  //   try {
  //     token = await AuthenLocalDataSource.getToken();
  //     studentId = (await AuthenLocalDataSource.getStudentId())!;
  //     final Map<String, String> headers = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token'
  //     };
  //     http.Response response = await http.get(
  //         Uri.parse('$endPoint/$studentId/vouchers/$voucherId'),
  //         headers: headers);

  //     if (response.statusCode == 200) {
  //       final result = jsonDecode(utf8.decode(response.bodyBytes));
  //       VoucherStudentItemModel apiResponse =
  //           VoucherStudentItemModel.fromJson(result);
  //       return apiResponse;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  @override
  Future<List<String>?> fetchWishListByStudentId() async {
    try {
      token = await AuthenLocalDataSource.getToken();
      studentId = (await AuthenLocalDataSource.getStudentId())!;
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      http.Response response = await http.get(
        Uri.parse('$endPoint/$studentId/wishlists'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonReponse = jsonDecode(response.body);
        List<String> result =
            jsonReponse.map((item) => item.toString()).toList();
        return result;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<StudentModel?> putVerification({
    required String studentId,
    required String studentCardFont,
  }) async {
    try {
      final token = await AuthenLocalDataSource.getToken();
      final Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token',
      };
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('$endPoint/$studentId/studentCardFront'),
      );

      //thêm file cho request
      request.files.add(
        await http.MultipartFile.fromPath('StudentCardFront', studentCardFont),
      );     

      //thêm headers
      request.headers.addAll(headers);

      //thêm field cho request
      // request.fields.addAll({'Code': studentCode});

      //gửi request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print(response);
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        result.addAll({
          'totalSpending': result['totalSpending'] ?? 1,
          'totalIncome': result['totalIncome'] ?? 1,
          'state': result['state'] ?? 1,
          'status': result['status'] ?? true,
          'fileNameFront': result['fileNameFront'] ?? 'fileName',
          'fileNameBack': result['fileNameBack'] ?? 'fileName',
        });
        StudentModel studentModel = StudentModel.fromJson(result);

        String studentString = jsonEncode(StudentModel.fromJson(result));
        AuthenLocalDataSource.saveStudent(studentString);
        return studentModel;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
