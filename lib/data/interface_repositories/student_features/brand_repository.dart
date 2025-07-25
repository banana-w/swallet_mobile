import 'package:swallet_mobile/data/models/api_response.dart';
import 'package:swallet_mobile/data/models/student_features/brand_model.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_model.dart';
import 'package:swallet_mobile/data/models/student_features/voucher_model.dart';

abstract class BrandRepository {
  const BrandRepository();

  Future<ApiResponse<List<BrandModel>>?> fetchBrands({
    int? page,
    int? size,
    bool status,
  });

  Future<BrandModel?> fecthBrandById({required String id});

  Future<ApiResponse<List<VoucherModel>>?> fecthVouchersByBrandId(
    int? page,
    int? limit, {
    required String id,
  });

  Future<ApiResponse<List<CampaignModel>>?> fecthCampaignssByBrandId(
    int? page,
    int? limit, {
    required String id,
  });

  Future<ApiResponse<List<CampaignModel>>?> fetchCampaignsByBrandId(
    int? page,
    int? size, { // Thay limit thành size
    required String id,
  });
}
