import 'dart:convert';
import 'package:swallet_mobile/data/models/api_response.dart';
import 'package:swallet_mobile/data/models/store_features/campagin_ranking_model.dart';
import 'package:swallet_mobile/data/models/store_features/campaign_voucher_store_model.dart';
import 'package:swallet_mobile/data/models/store_features/store_model.dart';
import 'package:swallet_mobile/data/models/store_features/transaction_store_model.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_detail_model.dart';
import 'package:swallet_mobile/data/models/student_features/student_ranking_model.dart';
import 'package:swallet_mobile/data/repositories/student_features/campaign_repository_imp.dart';
import 'package:swallet_mobile/data/repositories/student_features/student_repository_imp.dart';
import 'package:swallet_mobile/domain/entities/student_features/campaign_voucher_detail_model.dart';
import 'package:swallet_mobile/data/interface_repositories/store_features/store_repository.dart';

import '../../../presentation/config/constants.dart';
import '../../datasource/authen_local_datasource.dart';
import 'package:http/http.dart' as http;

class StoreRepositoryImp extends StoreRepository {
  String endPoint = '${baseURL}Store';
  String sort = 'Id%2Cdesc';
  int page = 1;
  int limit = 10;
  bool state = true;
  final campaignRepoImp = CampaignRepositoryImp();
  final studentRepo = StudentRepositoryImp();
  @override
  Future<ApiResponse<List<TransactionStoreModel>>?> fetchTransactionsStoreId(
    int? page,
    int? limit,
    int? typeIds, {
    required String id,
  }) async {
    try {
      final token = await AuthenLocalDataSource.getToken();
      // final storeId = await AuthenLocalDataSource.getStudentId();
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      if (typeIds == 0) {
        http.Response response = await http.get(
          Uri.parse(
            '$endPoint/$id/histories?state=$state&sort=$sort&page=$page&limit=$limit',
          ),
          headers: headers,
        );
        if (response.statusCode == 200) {
          final result = jsonDecode(utf8.decode(response.bodyBytes));
          ApiResponse<List<TransactionStoreModel>> apiResponse =
              ApiResponse<List<TransactionStoreModel>>.fromJson(
                result,
                (data) =>
                    data.map((e) => TransactionStoreModel.fromJson(e)).toList(),
              );
          return apiResponse;
        } else {
          return null;
        }
      } else {
        http.Response response = await http.get(
          Uri.parse(
            '$endPoint/$id/histories?state=$state&typeIds=$typeIds&sort=$sort&page=$page&limit=$limit',
          ),
          headers: headers,
        );
        if (response.statusCode == 200) {
          final result = jsonDecode(utf8.decode(response.bodyBytes));
          ApiResponse<List<TransactionStoreModel>> apiResponse =
              ApiResponse<List<TransactionStoreModel>>.fromJson(
                result,
                (data) =>
                    data.map((e) => TransactionStoreModel.fromJson(e)).toList(),
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
  Future<List<CampaignRankingModel>?> fecthCampaignRanking() async {
    try {
      final token = await AuthenLocalDataSource.getToken();
      final store = await AuthenLocalDataSource.getStore();
      final storeId = store?.id;
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      http.Response response = await http.get(
        Uri.parse('$endPoint/$storeId/campaign-ranking'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List result = jsonDecode(utf8.decode(response.bodyBytes));
        List<CampaignRankingModel> apiResponse =
            result.map((e) => CampaignRankingModel.fromJson(e)).toList();
        return apiResponse;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<StudentRankingModel>?> fecthStudentRanking() async {
    try {
      final token = await AuthenLocalDataSource.getToken();
      final store = await AuthenLocalDataSource.getStore();
      final storeId = store?.id;
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      http.Response response = await http.get(
        Uri.parse('$endPoint/$storeId/student-ranking'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List result = jsonDecode(utf8.decode(response.bodyBytes));
        List<StudentRankingModel> apiResponse =
            result.map((e) => StudentRankingModel.fromJson(e)).toList();
        return apiResponse;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<StoreModel?> fetchStoreById({required String accountId}) async {
    try {
      final token = await AuthenLocalDataSource.getToken();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      http.Response response = await http.get(
        Uri.parse('$endPoint/account/$accountId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        StoreModel storeModel = StoreModel.fromJson(result);
        String storeString = jsonEncode(StoreModel.fromJson(result));
        AuthenLocalDataSource.saveStore(storeString);
        return storeModel;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<ApiResponse<List<CampaignVoucherStoreModel>>?>
  fetchCampaignVoucherStoreId(int? page, int? limit, String? search) async {
    try {
      final token = await AuthenLocalDataSource.getToken();
      final store = await AuthenLocalDataSource.getStore();
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'accept': 'text/plain', // Thêm header accept theo API
      };

      // Định nghĩa endpoint cơ bản
      const String endPoint =
          '${baseURL}CampaignDetail/get-all-campaign-detail-by-storeId';

      // Xây dựng URL với query parameters
      final Map<String, String> queryParams = {
        'storeId': store!.id,
        'page': page?.toString() ?? '1',
        'size': limit?.toString() ?? '10',
      };

      // Nếu có search, thêm searchName vào query parameters
      if (search != null && search.isNotEmpty) {
        queryParams['searchName'] = search;
      }

      // Tạo URI với query parameters
      final Uri uri = Uri.parse(endPoint).replace(queryParameters: queryParams);

      // Gửi request
      http.Response response = await http.get(uri, headers: headers);

      // Xử lý response
      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        ApiResponse<List<CampaignVoucherStoreModel>> apiResponse =
            ApiResponse<List<CampaignVoucherStoreModel>>.fromJson(
              result,
              (data) =>
                  data
                      .map((e) => CampaignVoucherStoreModel.fromJson(e))
                      .toList(),
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
  Future<Map<bool, String>> postScanVoucherCode({
    required String storeId,
    required String voucherId,
    required String studentId,
    required String voucherItemId,
  }) async {
    try {
      final token = await AuthenLocalDataSource.getToken();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'accept': 'text/plain',
      };

      Map<String, dynamic> body = {
        'studentId': studentId,
        'voucherId': voucherId,
        'storeId': storeId,
        'voucherItemId': voucherItemId,
      };

      const String endPoint = '${baseURL}Activity/UseVoucher';

      // Gửi request POST
      var response = await http.post(
        Uri.parse(endPoint),
        headers: headers,
        body: jsonEncode(body),
      );

      Map<bool, String> mapResult = {};

      if (response.statusCode == 200) {
        mapResult[true] = "QR code hợp lệ";
        return mapResult;
      } else {
        mapResult[false] = "Lỗi QR code không hợp lệ";
        return mapResult;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // @override
  // Future<List<CampaignRankingModel>?> fecthCampaignRanking() async {
  //   try {
  //     final token = await AuthenLocalDataSource.getToken();
  //     final storeId = await AuthenLocalDataSource.getStoreId();
  //     final Map<String, String> headers = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token'
  //     };
  //     http.Response response = await http.get(
  //         Uri.parse('$endPoint/$storeId/campaign-ranking'),
  //         headers: headers);

  //     if (response.statusCode == 200) {
  //       final List result = jsonDecode(utf8.decode(response.bodyBytes));
  //       List<CampaignRankingModel> apiResponse =
  //           result.map((e) => CampaignRankingModel.fromJson(e)).toList();
  //       return apiResponse;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  // @override
  // Future<TransactResultModel?> createBonus(
  //     {required String storeId,
  //     required String studentId,
  //     required double amount,
  //     required String description,
  //     required bool state}) async {
  //   try {
  //     final token = await AuthenLocalDataSource.getToken();

  //     final Map<String, String> headers = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token'
  //     };

  //     Map<String, dynamic> body = {
  //       'studentId': studentId,
  //       'amount': amount.toString(),
  //       'description': description,
  //       'state': true
  //     };

  //     http.Response response = await http.post(
  //         Uri.parse('$endPoint/$storeId/bonuses'),
  //         headers: headers,
  //         body: jsonEncode(body));

  //     if (response.statusCode == 201) {
  //       final result = jsonDecode(utf8.decode(response.bodyBytes));
  //       TransactResultModel apiRepsonse = TransactResultModel.fromJson(result);
  //       return apiRepsonse;
  //     }
  //     return null;
  //   } catch (e) {
  //     print(e);
  //     throw Exception(e.toString());
  //   }
  // }

  // @override
  // Future<CampaignVoucherDetailModel?> fetchCampaignVoucherDetail(
  //     {required String storeId,
  //     required String campaignVoucherDetailId}) async {
  //   try {
  //     final token = await AuthenLocalDataSource.getToken();

  //     final Map<String, String> headers = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token'
  //     };
  //     http.Response response = await http.get(
  //         Uri.parse(
  //             '$endPoint/$storeId/campaign-details/$campaignVoucherDetailId'),
  //         headers: headers);

  //     if (response.statusCode == 200) {
  //       final result = jsonDecode(utf8.decode(response.bodyBytes));
  //       CampaignVoucherDetailModel campaignVoucherDetail =
  //           CampaignVoucherDetailModel.fromJson(result);
  //       return campaignVoucherDetail;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  @override
  Future<StoreModel?> updateStore({
    required String areaId,
    required String storeName,
    required String address,
    required String avatar,
    required String openHours,
    required String closeHours,
    required String description,
    required String storeId,
    required bool state,
  }) async {
    try {
      final token = await AuthenLocalDataSource.getToken();
      final Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('$endPoint/$storeId'),
      );

      //thêm file cho request
      if (avatar != '') {
        request.files.add(await http.MultipartFile.fromPath('Avatar', avatar));
      }

      //thêm headers
      request.headers.addAll(headers);

      //thêm field cho request
      request.fields.addAll({
        'AreaId': areaId,
        'StoreName': storeName,
        'Address': address,
        'OpeningHours': openHours,
        'ClosingHours': closeHours,
        'Description': description,
        'State': state.toString(),
      });

      //gửi request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print(response);
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        StoreModel storeModel = StoreModel.fromJson(result);

        String storeString = jsonEncode(StoreModel.fromJson(result));
        AuthenLocalDataSource.saveStore(storeString);
        return storeModel;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  // @override
  // Future<List<StudentRankingModel>?> fecthStudentRanking() async {
  //   try {
  //     final token = await AuthenLocalDataSource.getToken();
  //     final storeId = await AuthenLocalDataSource.getStoreId();
  //     final Map<String, String> headers = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token'
  //     };
  //     http.Response response = await http.get(
  //         Uri.parse('$endPoint/$storeId/student-ranking'),
  //         headers: headers);

  //     if (response.statusCode == 200) {
  //       final List result = jsonDecode(utf8.decode(response.bodyBytes));
  //       List<StudentRankingModel> apiResponse =
  //           result.map((e) => StudentRankingModel.fromJson(e)).toList();
  //       return apiResponse;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  @override
  Future<CampaignDetailModel?> fecthCampaignById({required String id}) async {
    var campaignDetailModel = campaignRepoImp.fecthCampaignById(id: id);
    return campaignDetailModel;
  }

  @override
  Future<CampaignVoucherDetailModel?> fetchVoucherItemByStudentId({
    required String campaignId,
    required String voucherId,
  }) {
    var voucherItem = studentRepo.fetchVoucherItemByStudentId(
      campaignId: campaignId,
      voucherId: voucherId,
    );
    return voucherItem;
  }
}
