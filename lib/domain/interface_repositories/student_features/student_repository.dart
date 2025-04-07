import 'package:swallet_mobile/data/models/api_response.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_detail_model.dart';
import 'package:swallet_mobile/data/models/student_features/redeemed_voucher_model.dart';
import 'package:swallet_mobile/data/models/lecture_features/qr_response.dart';
import 'package:swallet_mobile/data/models/student_features/student_model.dart';
import 'package:swallet_mobile/data/models/student_features/transaction_model.dart';
import 'package:swallet_mobile/data/models/student_features/voucher_student_model.dart';
import 'package:swallet_mobile/domain/entities/student_features/campaign_voucher_detail_model.dart';

abstract class StudentRepository {
  const StudentRepository();
  Future<StudentModel?> fetchStudentById({required String id});

  Future<void> updateWalletByStudentId(String studentId, int point);

  Future<ScanQRResponse> scanLectureQR({
    required String qrCode,
    required String studentId,
  });

  Future<ApiResponse<List<VoucherStudentModel>>?> fetchVoucherStudentId(
    int? page,
    int? limit,
    String? search,
    bool? isUsed, {
    required String id,
  });

  Future<ApiResponse<List<BrandVoucher>>?> fetchVoucherByStudentId(
    int? page,
    int? limit,
    String? search,
    bool? isUsed, {
    required String id,
  });

  Future<ApiResponse<List<TransactionModel>>?> fetchTransactionsStudentId(
    int? page,
    int? limit,
    int? typeIds,
    String? searchName, {
    required String id,
  });

  Future<ApiResponse<List<TransactionModel>>?> fetchVoucherTransactionsByStudentId(
    int? page,
    int? limit,
    int? typeIds,
    String? searchName, {
    required String id,
  });

  // Future<ApiResponse<List<OrderModel>>?> fetchOrdersStudentId(
  //     int? page, int? limit,
  //     {required String id});

  // Future<bool?> postChallengeStudentId({
  //   required String studentId,
  //   required String challengeId,
  // });

  Future<StudentModel?> putStudent({
    required String studentId,
    required String fullName,
    required String campusId,
    required String studentCode,
    required DateTime dateOfBirth,
    required int gender,
    required String avatar,
    required String address,
  });

  Future<CampaignVoucherDetailModel?> fetchVoucherItemByStudentId({
    required String campaignId,
    required String voucherId,
  });
  
  Future<CampaignDetailModel?> fecthCampaignById({required String id});

  Future<List<String>?> fetchWishListByStudentId();

  // Future<OrderModel?> createOrder(CreateOrderModel createOrderModel);

  Future<StudentModel?> putVerification({
    required String studentId,
    required String studentCardFont,
  });

  // Future<OrderDetailModel?> fetchOrderDetailByStudentId(
  //     {required String studentId, required String orderId});
}
