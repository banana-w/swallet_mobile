import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/api_response.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_detail_model.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_model.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_store_model.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_voucher_model.dart';
import 'package:swallet_mobile/data/repositories/student_features/student_repository_imp.dart';
import 'package:swallet_mobile/domain/entities/student_features/campaign_voucher_detail_model.dart';
import 'package:swallet_mobile/domain/interface_repositories/student_features/campaign_repository.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

class CampaignRepositoryImp implements CampaignRepository {
  final _studentRepository = StudentRepositoryImp();
  String endPoint = '${baseURL}Campaign';
  String sort = 'Id%2Cdesc';
  int page = 1;
  int limit = 3;
  String? token;

  @override
  Future<ApiResponse<List<CampaignModel>>?> fecthCampaigns({
    String? searchName,
    int? page,
    int? size,
  }) async {
    try {
      // Headers khớp với curl
      final Map<String, String> headers = {
        'accept': 'text/plain', // Thay vì Content-Type
      };

      // Gán giá trị mặc định nếu không truyền tham số
      page ??= this.page;
      size ??= limit;

      // Tạo query string dựa trên curl
      final queryParams = {
        if (searchName != null) 'searchName': searchName,
        'page': page.toString(),
        'size': size.toString(),
      };
      // Tạo URI với query parameters
      final uri = Uri.parse(
        '$endPoint/getAll',
      ).replace(queryParameters: queryParams);

      // Gửi yêu cầu HTTP GET
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        // Giả định response là JSON dù header accept là text/plain
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        final apiResponse = ApiResponse<List<CampaignModel>>.fromJson(
          result,
          (data) => (data).map((e) => CampaignModel.fromJson(e)).toList(),
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
  Future<CampaignDetailModel?> fecthCampaignById({required String id}) async {
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
        CampaignDetailModel campaignDetailModel = CampaignDetailModel.fromJson(
          result,
        );
        return campaignDetailModel;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<ApiResponse<List<CampaignStoreModel>>?> fecthCampaignStoreById(
    int? page,
    int? limit, {
    required String id,
    String? searchName,
  }) async {
    try {
      token = await AuthenLocalDataSource.getToken();
      final Map<String, String> headers = {
        'accept': 'text/plain', // Khớp với curl
        'Authorization': 'Bearer $token', // Giữ Authorization từ code gốc
      };

      // Gán giá trị mặc định nếu page hoặc size không được truyền
      page ??= this.page;
      limit ??= this.limit;

      // Tạo query parameters
      final queryParams = {
        if (searchName != null && searchName.isNotEmpty)
          'searchName': searchName,
        'page': page.toString(),
        'size': limit.toString(),
      };

      // Tạo URI với endpoint và query parameters
      final uri = Uri.parse(
        '${baseURL}Store/campaign/$id',
      ).replace(queryParameters: queryParams);

      // Gửi yêu cầu HTTP GET
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        final apiResponse = ApiResponse<List<CampaignStoreModel>>.fromJson(
          result,
          (data) => (data).map((e) => CampaignStoreModel.fromJson(e)).toList(),
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
  Future<List<CampaignVoucherModel>?> fecthCampaignVouchersById(
    int? page,
    int? limit, {
    required String id,
  }) async {
    try {
      token = await AuthenLocalDataSource.getToken();
      final Map<String, String> headers = {
        'accept': 'text/plain', // Khớp với curl
        'Authorization': 'Bearer $token', // Giữ Authorization
      };

      // Gán giá trị mặc định nếu page hoặc limit không được truyền
      page ??= this.page;
      limit ??= this.limit;

      // Tạo query parameters (tùy chọn)
      final queryParams = {'page': page.toString(), 'limit': limit.toString()};

      // Tạo URI với endpoint và query parameters
      final uri = Uri.parse(
        '${baseURL}Voucher/campaign-detail/$id',
      ).replace(queryParameters: queryParams);

      // Gửi yêu cầu HTTP GET
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final result =
            jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
        final vouchers =
            result
                .map(
                  (e) =>
                      CampaignVoucherModel.fromJson(e as Map<String, dynamic>),
                )
                .toList();
        return vouchers;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<CampaignVoucherDetailModel?> fecthCampaignVoucherDetailById({
    required String campaignId,
    required String campaignVoucherId,
  }) async {
    try {
      token = await AuthenLocalDataSource.getToken();
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final queryParams = {'id': campaignVoucherId, 'campaignId': campaignId};

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
  Future<String?> redeemCampaignVoucher({
    required String campaignId,
    required String studentId,
    required int quantity,
    required double cost,
  }) async {
    try {
      token = await AuthenLocalDataSource.getToken();
      final Map<String, String> headers = {
        'accept': 'text/plain',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      Map body = {
        'campaignId': campaignId,
        'studentId': studentId,
        'cost': cost,
        'quantity': quantity,
      };
      final response = await http.post(
        Uri.parse('${baseURL}Activity/RedeemVoucher'),
        body: jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 201) {
        return null;
      } else {
        return response.body;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
