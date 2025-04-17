import 'package:swallet_mobile/data/models/api_response.dart';
import 'package:swallet_mobile/data/models/store_features/campagin_ranking_model.dart';
import 'package:swallet_mobile/data/models/store_features/campaign_voucher_store_model.dart';
import 'package:swallet_mobile/data/models/store_features/store_model.dart';
import 'package:swallet_mobile/data/models/store_features/transaction_store_model.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_detail_model.dart';
import 'package:swallet_mobile/data/models/student_features/student_ranking_model.dart';
import 'package:swallet_mobile/domain/entities/student_features/campaign_voucher_detail_model.dart';

abstract class StoreRepository {
  const StoreRepository();

  Future<List<CampaignRankingModel>?> fecthCampaignRanking();
  Future<List<StudentRankingModel>?> fecthStudentRanking();

  Future<StoreModel?> fetchStoreById({required String accountId});

  Future<ApiResponse<List<TransactionStoreModel>>?> fetchTransactionsStoreId(
    int? page,
    int? limit,
    int? typeIds, {
    required String id,
  });

  Future<ApiResponse<List<CampaignVoucherStoreModel>>?>
  fetchCampaignVoucherStoreId(int? page, int? limit, String? search);

  Future<Map<bool, String>> postScanVoucherCode({
    required String storeId,
    required String voucherId,
    required String studentId,
    required String voucherItemId,
  });

  // Future<List<CampaignRankingModel>?> fecthCampaignRanking();
  // Future<List<StudentRankingModel>?> fecthStudentRanking();

  // Future<TransactResultModel?> createBonus({
  //   required String storeId,
  //   required String studentId,
  //   required double amount,
  //   required String description,
  //   required bool state,
  // });

  // Future<CampaignVoucherDetailModel?> fetchCampaignVoucherDetail(
  //     {required String storeId, required String campaignVoucherDetailId});

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
  });

  // Future<Map<bool, dynamic>> fecthCampaignVoucherInformation({
  //   required String storeId,
  //   required String voucherCode,
  // });

  Future<CampaignDetailModel?> fecthCampaignById({required String id});
  Future<CampaignVoucherDetailModel?> fetchVoucherItemByStudentId({
    required String campaignId,
    required String voucherId,
  });
}
