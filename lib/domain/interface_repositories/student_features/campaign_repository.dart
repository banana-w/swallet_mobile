import 'package:swallet_mobile/data/models/api_response.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_detail_model.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_model.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_store_model.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_voucher_model.dart';
import 'package:swallet_mobile/domain/entities/student_features/campaign_voucher_detail_model.dart';

abstract class CampaignRepository {
  const CampaignRepository();

  Future<ApiResponse<List<CampaignModel>>?> fecthCampaigns({
    int? page,
    int? limit,
  });

  Future<CampaignDetailModel?> fecthCampaignById({required String id});

  Future<ApiResponse<List<CampaignStoreModel>>?> fecthCampaignStoreById(
    int? page,
    int? limit, {
    required String id,
  });

  Future<ApiResponse<List<CampaignVoucherModel>>?> fecthCampaignVouchersById(
    int? page,
    int? limit, {
    required String id,
  });

  Future<CampaignVoucherDetailModel?> fecthCampaignVoucherDetailById({
    required String campaignId,
    required String campaignVoucherId,
  });

  Future<String?> redeemCampaignVoucher({
    required String campaignId,
    required String campaignVoucherId,
    required String studentId,
    required int quantity,
    required String description,
  });
}
