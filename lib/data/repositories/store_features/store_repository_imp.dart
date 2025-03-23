import 'dart:convert';

// import 'package:swallet_mobile/data/models/api_response.dart';
// import 'package:swallet_mobile/data/models/store_features/campagin_ranking_model.dart';
// import 'package:swallet_mobile/data/models/store_features/campaign_voucher_information_model.dart';
// import 'package:swallet_mobile/data/models/store_features/campaign_voucher_store_model.dart';
import 'package:swallet_mobile/data/models/store_features/store_model.dart';
import 'package:swallet_mobile/domain/interface_repositories/store_features/store_repository.dart';
// import 'package:swallet_mobile/data/models/store_features/student_ranking_model.dart';
// import 'package:swallet_mobile/data/models/store_features/transact_result_model.dart';

// import 'package:swallet_mobile/data/models/store_features/transaction_store_model.dart';
// import 'package:swallet_mobile/data/models/student_features/campaign_voucher_detail_model.dart';

import '../../../domain/repositories.dart';
import '../../../presentation/config/constants.dart';
import '../../datasource/authen_local_datasource.dart';
import 'package:http/http.dart' as http;

class StoreRepositoryImp extends StoreRepository {
  String endPoint = '${baseURL}stores';
  String sort = 'Id%2Cdesc';
  int page = 1;
  int limit = 10;
  bool state = true;

  // @override
  // Future<ApiResponse<List<TransactionStoreModel>>?> fetchTransactionsStoreId(
  //     int? page, int? limit, int? typeIds,
  //     {required String id}) async {
  //   try {
  //     final token = await AuthenLocalDataSource.getToken();
  //     // final storeId = await AuthenLocalDataSource.getStudentId();
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
  //         ApiResponse<List<TransactionStoreModel>> apiResponse =
  //             ApiResponse<List<TransactionStoreModel>>.fromJson(
  //                 result,
  //                 (data) => data
  //                     .map((e) => TransactionStoreModel.fromJson(e))
  //                     .toList());
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
  //         ApiResponse<List<TransactionStoreModel>> apiResponse =
  //             ApiResponse<List<TransactionStoreModel>>.fromJson(
  //                 result,
  //                 (data) => data
  //                     .map((e) => TransactionStoreModel.fromJson(e))
  //                     .toList());
  //         return apiResponse;
  //       } else {
  //         return null;
  //       }
  //     }
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  // @override
  // Future<StoreModel?> fetchStoreById({required String storeId}) async {
  //   try {
  //     final token = await AuthenLocalDataSource.getToken();

  //     final Map<String, String> headers = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token'
  //     };
  //     http.Response response =
  //         await http.get(Uri.parse('$endPoint/$storeId'), headers: headers);

  //     if (response.statusCode == 200) {
  //       final result = jsonDecode(utf8.decode(response.bodyBytes));
  //       StoreModel storeModel = StoreModel.fromJson(result);
  //       String storeString = jsonEncode(StoreModel.fromJson(result));
  //       AuthenLocalDataSource.saveStore(storeString);
  //       return storeModel;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  // @override
  // Future<ApiResponse<List<CampaignVoucherStoreModel>>?>
  //     fetchCampaignVoucherStoreId(int? page, int? limit, String? search) async {
  //   try {
  //     final token = await AuthenLocalDataSource.getToken();
  //     final storeId = await AuthenLocalDataSource.getStoreId();
  //     final Map<String, String> headers = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token'
  //     };
  //     if (search != null) {
  //       http.Response response = await http.get(
  //           Uri.parse(
  //               '$endPoint/$storeId/campaign-details?state=$state&sort=$sort&search=$search&page=$page&limit=$limit'),
  //           headers: headers);
  //       if (response.statusCode == 200) {
  //         final result = jsonDecode(utf8.decode(response.bodyBytes));
  //         ApiResponse<List<CampaignVoucherStoreModel>> apiResponse =
  //             ApiResponse<List<CampaignVoucherStoreModel>>.fromJson(
  //                 result,
  //                 (data) => data
  //                     .map((e) => CampaignVoucherStoreModel.fromJson(e))
  //                     .toList());
  //         return apiResponse;
  //       } else {
  //         return null;
  //       }
  //     } else if (search == null || search == '') {
  //       http.Response response = await http.get(
  //           Uri.parse(
  //               '$endPoint/$storeId/campaign-details?sort=$sort&page=$page&limit=$limit'),
  //           headers: headers);
  //       if (response.statusCode == 200) {
  //         final result = jsonDecode(utf8.decode(response.bodyBytes));
  //         ApiResponse<List<CampaignVoucherStoreModel>> apiResponse =
  //             ApiResponse<List<CampaignVoucherStoreModel>>.fromJson(
  //                 result,
  //                 (data) => data
  //                     .map((e) => CampaignVoucherStoreModel.fromJson(e))
  //                     .toList());
  //         return apiResponse;
  //       } else {
  //         return null;
  //       }
  //     }
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  //   return null;
  // }

  @override
  Future<Map<bool, String>> postScanVoucherCode({
    required String storeId,
    required String voucherCode,
    required String description,
    required bool state,
  }) async {
    try {
      final token = await AuthenLocalDataSource.getToken();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      Map<String, dynamic> body = {'description': description, 'state': true};

      http.Response response = await http.post(
        Uri.parse('$endPoint/$storeId/campaign-details/$voucherCode'),
        headers: headers,
        body: jsonEncode(body),
      );
      Map<bool, String> mapResult = {};

      if (response.statusCode == 201) {
        var result = utf8.decode(response.bodyBytes);
        mapResult[true] = result;
        return mapResult;
      }
      var error = utf8.decode(response.bodyBytes);
      mapResult[false] = error;
      return mapResult;
    } catch (e) {
      print(e);
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

  @override
  Future<Map<bool, dynamic>> fecthCampaignVoucherInformation({
    required String storeId,
    required String voucherCode,
  }) {
    // TODO: implement fecthCampaignVoucherInformation
    throw UnimplementedError();
  }

  @override
  Future<StoreModel?> fetchStoreById({required String storeId}) {
    // TODO: implement fetchStoreById
    throw UnimplementedError();
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

  // @override
  // Future<Map<bool, dynamic>> fecthCampaignVoucherInformation(
  //     {required String storeId, required String voucherCode}) async {
  //   try {
  //     final token = await AuthenLocalDataSource.getToken();

  //     final Map<String, String> headers = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token'
  //     };
  //     http.Response response = await http.get(
  //         Uri.parse(
  //             '$endPoint/$storeId/campaign-details/$voucherCode/information'),
  //         headers: headers);
  //     Map<bool, dynamic> mapResult = {};
  //     if (response.statusCode == 200) {
  //       final result = jsonDecode(utf8.decode(response.bodyBytes));
  //       CampaignVoucherInformationModel campaignVoucherDetail =
  //           CampaignVoucherInformationModel.fromJson(result);

  //       mapResult[true] = campaignVoucherDetail;
  //       return mapResult;
  //     } else {
  //       final result = response.body;
  //       mapResult[false] = result;
  //       return mapResult;
  //     }
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }
}
