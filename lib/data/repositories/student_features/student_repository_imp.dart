import 'dart:convert';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/api_response.dart';
import 'package:swallet_mobile/data/models/lecture_features/qr_response';
import 'package:swallet_mobile/data/models/student_features/campaign_detail_model.dart';
import 'package:swallet_mobile/data/models/student_features/redeemed_voucher_model.dart';
import 'package:swallet_mobile/data/models/student_features/student_model.dart';
import 'package:swallet_mobile/data/models/student_features/transaction_model.dart';
import 'package:swallet_mobile/data/models/student_features/voucher_student_model.dart';
import 'package:swallet_mobile/data/repositories/student_features/campaign_repository_imp.dart';
import 'package:swallet_mobile/domain/entities/student_features/campaign_voucher_detail_model.dart';
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
  final campaignRepoImp = CampaignRepositoryImp();
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
        String studentString = jsonEncode(studentModel);
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
  Future<ScanQRResponse> scanLectureQR({
    required String qrCode,
    required String studentId,
  }) async {
    try {
      token = await AuthenLocalDataSource.getToken();
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final Map<String, dynamic> body = {
        'qrCodeJson': qrCode,
        'studentId': studentId,
      };

      http.Response response = await http.post(
        Uri.parse('https://swallet-api.onrender.com/api/Lecturer/scan-qrcode'),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        print('API Response: $result'); // Log để kiểm tra
        return ScanQRResponse.fromJson(result);
      } else {
        throw Exception(
          'Failed to scan QR: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Failed to scan QR: ${e.toString()}');
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
      final Map<String, String> headers = {
        'accept': 'text/plain',
        'Authorization': 'Bearer $token',
      };

      page ??= 1;
      limit ??= 10;
      isUsed ??= false;

      final queryParams = {
        'studentId': id,
        'isUsed': isUsed.toString(),
        'page': page.toString(),
        'size': limit.toString(),
      };

      if (search != null && search.isNotEmpty) {
        queryParams['searchName'] = search;
      }

      // final baseURL = 'https://10.0.2.2:7137/api/';

      final uri = Uri.parse(
        '${baseURL}Activity/RedeemedVouchersByStudent',
      ).replace(queryParameters: queryParams);

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        final apiResponse = ApiResponse<List<VoucherStudentModel>>.fromJson(
          result,
          (data) => data.map((e) => VoucherStudentModel.fromJson(e)).toList(),
        );
        return apiResponse;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<ApiResponse<List<BrandVoucher>>?> fetchVoucherByStudentId(
    int? page,
    int? limit,
    String? search,
    bool? isUsed, {
    required String id,
  }) async {
    try {
      token = await AuthenLocalDataSource.getToken();
      final Map<String, String> headers = {
        'accept': 'text/plain',
        'Authorization': 'Bearer $token',
      };

      page ??= 1;
      limit ??= 10;
      isUsed ??= false;

      final queryParams = {
        'studentId': id,
        'isUsed': isUsed.toString(),
        'page': page.toString(),
        'size': limit.toString(),
      };

      if (search != null && search.isNotEmpty) {
        queryParams['searchName'] = search;
      }

      // final baseURL = 'https://10.0.2.2:7137/api/';

      final uri = Uri.parse(
        '${baseURL}Activity/RedeemedVouchersGroupByStudent',
      ).replace(queryParameters: queryParams);

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        final apiResponse = ApiResponse<List<BrandVoucher>>.fromJson(
          result,
          (data) => data.map((e) => BrandVoucher.fromJson(e)).toList(),
        );
        return apiResponse;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<ApiResponse<List<TransactionModel>>?> fetchTransactionsStudentId(
    int? page,
    int? limit,
    int? typeIds,
    String? searchName, {
    required String id,
  }) async {
    try {
      token = await AuthenLocalDataSource.getToken();
      final Map<String, String> headers = {
        'accept': 'text/plain', // Khớp với curl
        'Authorization': 'Bearer $token',
      };

      page ??= 1;
      limit ??= 10;

      final queryParams = {
        'studentId': id,
        'page': page.toString(),
        'size': limit.toString(),
      };

      if (searchName != null && searchName.isNotEmpty) {
        queryParams['searchName'] = searchName;
      }

      // final baseURL = 'https://10.0.2.2:7137/api/';

      final uri = Uri.parse(
        '${baseURL}Activity/ActivityTransaction',
      ).replace(queryParameters: queryParams);

      // final client = http.Client();
      // final ioClient =
      //     HttpClient()
      //       ..badCertificateCallback =
      //           (X509Certificate cert, String host, int port) =>
      //               true; // Bỏ qua kiểm tra chứng chỉ
      // final httpClient = IOClient(ioClient);

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        final apiResponse = ApiResponse<List<TransactionModel>>.fromJson(
          result,
          (data) => data.map((e) => TransactionModel.fromJson(e)).toList(),
        );
        return apiResponse;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

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

  @override
  Future<CampaignVoucherDetailModel?> fetchVoucherItemByStudentId({
    required String campaignId,
    required String voucherId,
  }) async {
    try {
      token = await AuthenLocalDataSource.getToken();
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final queryParams = {'id': voucherId, 'campaignId': campaignId};

      // Tạo URI với endpoint và query parameters
      final uri = Uri.parse(
        '${baseURL}Voucher/withCId',
      ).replace(queryParameters: queryParams);

      // Gửi yêu cầu HTTP GET
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        CampaignVoucherDetailModel campaignVoucherDetailModel =
            CampaignVoucherDetailModel.fromJson(result);
        return campaignVoucherDetailModel;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<CampaignDetailModel?> fecthCampaignById({required String id}) async {
    var campaignDetailModel = campaignRepoImp.fecthCampaignById(id: id);
    return campaignDetailModel;
  }

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
