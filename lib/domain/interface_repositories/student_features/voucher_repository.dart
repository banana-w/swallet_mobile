import 'package:swallet_mobile/data/models/api_response.dart';
import 'package:swallet_mobile/data/models/student_features/voucher_model.dart';
import 'package:swallet_mobile/domain/interface_repositories/student_features/voucher_detail_model.dart';

abstract class VoucherRepository {
  const VoucherRepository();

  Future<ApiResponse<List<VoucherModel>>?> fetchVouchers({
    int? page,
    int? limit,
  });

  Future<VoucherDetailModel?> fetchVoucherById({required String voucherId});
}
