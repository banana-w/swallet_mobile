import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/api_response.dart';
import 'package:swallet_mobile/data/models/student_features/voucher_model.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/voucher_detail_model.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/voucher_repository.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';


class VoucherRepositoryImp implements VoucherRepository {
  String endPoint = '${baseURL}vouchers';
  String sort = 'Id%2Cdesc';
  int page = 1;
  int limit = 10;
  String? token;

  @override
  Future<ApiResponse<List<VoucherModel>>?> fetchVouchers({
    int? page,
    int? limit,
  }) async {
    try {
      token = await AuthenLocalDataSource.getToken();
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      page ??= this.page;
      http.Response response = await http.get(
        Uri.parse('$endPoint?sort=$sort&page=$page&limit=$limit'),
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
  Future<VoucherDetailModel?> fetchVoucherById({
    required String voucherId,
  }) async {
    try {
      token = await AuthenLocalDataSource.getToken();
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      http.Response response = await http.get(
        Uri.parse('$endPoint/$voucherId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        VoucherDetailModel voucherDetailModel = VoucherDetailModel.fromJson(
          result,
        );
        return voucherDetailModel;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
