import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/api_response.dart';
import 'package:swallet_mobile/data/models/student_features/challenge_model.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/challenge_repository.dart';
import 'package:swallet_mobile/data/models/student_features/location_model.dart';

import '../../../presentation/config/constants.dart';

class ChallengeRepositoryImp extends ChallengeRepository {
  String endPoint = '${baseURL}students';
  String? token;
  String? studentId;
  String sort = 'Id%2Casc';
  int page = 1;
  int limit = 10;

  @override
  Future<ApiResponse<List<ChallengeModel>>?> fecthChallenges({
    int? page,
    int? limit,
  }) async {
    try {
      token = await AuthenLocalDataSource.getToken();
      var student = await AuthenLocalDataSource.getStudent();
      studentId = student?.id;
      page ??= this.page;

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      // final baseURL = 'https://10.0.2.2:7137/api/';


      // final client = http.Client();
      // final ioClient =
      //     HttpClient()
      //       ..badCertificateCallback =
      //           (X509Certificate cert, String host, int port) =>
      //               true; // Bỏ qua kiểm tra chứng chỉ
      // final httpClient = IOClient(ioClient);

      http.Response response = await http.get(
        Uri.parse(
          '${baseURL}Challenge/extra?studentId=$studentId&types=2&page=$page&size=100',
        ),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        ApiResponse<List<ChallengeModel>> apiResponse =
            ApiResponse<List<ChallengeModel>>.fromJson(
              result,
              (data) => data.map((e) => ChallengeModel.fromJson(e)).toList(),
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
  Future<ApiResponse<List<ChallengeModel>>?> fecthDailyChallenges({
    int? page,
    int? limit,
  }) async {
    try {
      token = await AuthenLocalDataSource.getToken();
      var student = await AuthenLocalDataSource.getStudent();
      studentId = student?.id;
      page ??= this.page;

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      // final baseURL = 'https://10.0.2.2:7137/api/';


      // final client = http.Client();
      // final ioClient =
      //     HttpClient()
      //       ..badCertificateCallback =
      //           (X509Certificate cert, String host, int port) =>
      //               true; // Bỏ qua kiểm tra chứng chỉ
      // final httpClient = IOClient(ioClient);

      http.Response response = await http.get(
        Uri.parse(
          '${baseURL}Challenge/extra?studentId=$studentId&types=1&page=$page&size=100',
        ),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        ApiResponse<List<ChallengeModel>> apiResponse =
            ApiResponse<List<ChallengeModel>>.fromJson(
              result,
              (data) => data.map((e) => ChallengeModel.fromJson(e)).toList(),
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
  Future<List<LocationModel>?> fetchLocation() async {
    try {
      final response = await http.get(
        Uri.parse('${baseURL}Location/getAll'),
        headers: {'accept': 'text/plain'},
      );

      if (response.statusCode == 200) {
        // Giải mã JSON thành danh sách
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        // Chuyển đổi từng JSON thành LocationModel
        final List<LocationModel> locations = 
            (result as List).map((e) => LocationModel.fromJson(e)).toList();
        return locations;
      } else {
        // Nếu API trả về lỗi (ví dụ: 404, 500)
        throw Exception('Failed to fetch locations: ${response.statusCode}');
      }
    } catch (e) {
      // Xử lý lỗi mạng hoặc lỗi khác
      throw Exception('Error fetching locations: $e');
    }
  }
}
