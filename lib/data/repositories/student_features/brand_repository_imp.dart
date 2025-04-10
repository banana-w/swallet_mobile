import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/api_response.dart';
import 'package:swallet_mobile/data/models/student_features/brand_model.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_model.dart';
import 'package:swallet_mobile/data/models/student_features/voucher_model.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/brand_repository.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';


class BrandRepositoryImp implements BrandRepository {
  String endPoint = '${baseURL}Brand';
  String sort = 'Id%2Cdesc';
  int page = 1;
  int limit = 10;
  bool state = true;
  String? token;

  @override
  Future<ApiResponse<List<BrandModel>>?> fetchBrands({
    int? page,
    int? size, // Thay limit thành size
    bool status = true, // Thêm tham số status, mặc định là true
  }) async {
    try {
      final Map<String, String> headers = {'Content-Type': 'application/json'};

      // Sử dụng giá trị mặc định nếu page hoặc size không được truyền
      page ??= this.page;
      size ??=
          limit; // Nếu bạn đã định nghĩa this.limit, nếu không thì có thể đặt giá trị mặc định như 10

      // Tạo URL với các query parameters page, size, và status
      final url = Uri.parse(
        '${baseURL}Brand?page=$page&size=$size&status=$status',
      );

      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        ApiResponse<List<BrandModel>> apiResponse =
            ApiResponse<List<BrandModel>>.fromJson(
              result,
              (data) => data.map((e) => BrandModel.fromJson(e)).toList(),
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
  Future<BrandModel?> fecthBrandById({required String id}) async {
    try {
      token = await AuthenLocalDataSource.getToken();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      http.Response response = await http.get(
        Uri.parse('$endPoint/$id'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        BrandModel brandModel = BrandModel.fromJson(result);
        return brandModel;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<ApiResponse<List<VoucherModel>>?> fecthVouchersByBrandId(
    int? page,
    int? limit, {
    required String id,
  }) async {
    try {
      token = await AuthenLocalDataSource.getToken();
      final Map<String, String> headers = {'Content-Type': 'application/json'};
      page ??= this.page;
      limit ??= this.limit;

      http.Response response = await http.get(
        Uri.parse(
          '$endPoint/$id/vouchers?state=$state&sort=$sort&page=$page&limit=$limit',
        ),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        ApiResponse<List<VoucherModel>> apiResponse =
            ApiResponse<List<VoucherModel>>.fromJson(
              result,
              (data) => data.map((e) => VoucherModel.fromJson(e)).toList(),
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
  Future<ApiResponse<List<CampaignModel>>?> fecthCampaignssByBrandId(
    int? page,
    int? limit, {
    required String id,
  }) async {
    try {
      token = await AuthenLocalDataSource.getToken();
      final Map<String, String> headers = {'Content-Type': 'application/json'};
      page ??= this.page;
      limit ??= this.limit;
      final studentModel = await AuthenLocalDataSource.getStudent();
      if (studentModel == null) {
        http.Response response = await http.get(
          Uri.parse(
            '$endPoint/$id/campaigns?stateIds=3&sort=$sort&page=$page&limit=$limit',
          ),
          headers: headers,
        );

        if (response.statusCode == 200) {
          final result = jsonDecode(utf8.decode(response.bodyBytes));
          ApiResponse<List<CampaignModel>> apiResponse =
              ApiResponse<List<CampaignModel>>.fromJson(
                result,
                (data) => data.map((e) => CampaignModel.fromJson(e)).toList(),
              );
          return apiResponse;
        } else {
          return null;
        }
      } else {
        String campusId = studentModel.campusId ?? '';
        http.Response response = await http.get(
          Uri.parse(
            '$endPoint/$id/campaigns?campusIds=$campusId&stateIds=3&sort=$sort&page=$page&limit=$limit',
          ),
          headers: headers,
        );

        if (response.statusCode == 200) {
          final result = jsonDecode(utf8.decode(response.bodyBytes));
          ApiResponse<List<CampaignModel>> apiResponse =
              ApiResponse<List<CampaignModel>>.fromJson(
                result,
                (data) => data.map((e) => CampaignModel.fromJson(e)).toList(),
              );
          return apiResponse;
        } else {
          return null;
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<ApiResponse<List<CampaignModel>>?> fetchCampaignsByBrandId(
    int? page,
    int? size, { // Thay limit thành size
    required String id,
  }) async {
    try {
      token = await AuthenLocalDataSource.getToken();
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer $token', // Thêm token vào header nếu API yêu cầu
      };

      // Sử dụng giá trị mặc định nếu page hoặc size không được truyền
      page ??= this.page;
      size ??= this.limit;

      // Tạo URL với các query parameters page và size
      final url = Uri.parse(
        '${baseURL}Campaign/brand/$id?page=$page&size=$size',
      );

      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        ApiResponse<List<CampaignModel>> apiResponse =
            ApiResponse<List<CampaignModel>>.fromJson(
              result,
              (data) => data.map((e) => CampaignModel.fromJson(e)).toList(),
            );
        return apiResponse;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
