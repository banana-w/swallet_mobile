import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:swallet_mobile/data/models/api_response.dart';
import 'package:swallet_mobile/data/models/student_features/campus_model.dart';
import 'package:swallet_mobile/domain/interface_repositories/student_features/campus_repository.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

class CampusRepositoryImp implements CampusRepository {
  String endPoint = '${baseURL}campuses';
  String sort = 'Id%2Cdesc';
  int page = 1;
  int limit = 10;
  bool state = true;
  @override
  Future<ApiResponse<List<CampusModel>>?> fetchCampusByUniId({
    int? page,
    required String uniId,
  }) async {
    try {
      final Map<String, String> headers = {'Content-Type': 'application/json'};
      page ??= this.page;
      http.Response response = await http.get(
        Uri.parse(
          '$endPoint?state=$state&universityIds=$uniId&sort=$sort&page=$page&limit=100',
        ),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        ApiResponse<List<CampusModel>> apiResponse =
            ApiResponse<List<CampusModel>>.fromJson(
              result,
              (data) => data.map((e) => CampusModel.fromJson(e)).toList(),
            );
        print(apiResponse.result);
        return apiResponse;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<ApiResponse<List<CampusModel>>?> fetchCampus({
    required String searchName,
    int page = 1, // Giá trị mặc định là 1
    int size = 10, // Giá trị mặc định là 10
  }) async {
    try {
      // Thiết lập headers
      final Map<String, String> headers = {'Content-Type': 'application/json'};

      // Tạo URL với query parameters
      final url = Uri.parse(
        '$endPoint?searchName=$searchName&page=$page&size=$size',
      );

      // Gửi request GET
      http.Response response = await http.get(url, headers: headers);

      // Xử lý response
      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        ApiResponse<List<CampusModel>> apiResponse =
            ApiResponse<List<CampusModel>>.fromJson(
              result,
              (items) => items.map((e) => CampusModel.fromJson(e)).toList(),
            );
        print(apiResponse.result); // In kết quả để debug (có thể bỏ)
        return apiResponse;
      } else {
        print('Request failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      throw Exception('Error fetching campus data: $e');
    }
  }
}
