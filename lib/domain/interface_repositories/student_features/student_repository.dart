import 'package:swallet_mobile/data/models/student_features/student_model.dart';


abstract class StudentRepository {
  const StudentRepository();
  Future<StudentModel?> fetchStudentById({required String id});

  // Future<ApiResponse<List<VoucherStudentModel>>?> fetchVoucherStudentId(
  //     int? page, int? limit, String? search,
  //     bool? isUsed,
  //     {required String id});

  // Future<ApiResponse<List<TransactionModel>>?> fetchTransactionsStudentId(
  //     int? page, int? limit, int? typeIds,
  //     {required String id});

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
    required String majorId,
    required String campusId,
    required int gender,
    required String avatar,
    required String address,
  });

  // Future<VoucherStudentItemModel?> fetchVoucherItemByStudentId(
  //     {required String studentId, required String voucherId});

  Future<List<String>?> fetchWishListByStudentId();

  // Future<OrderModel?> createOrder(CreateOrderModel createOrderModel);

  // Future<StudentModel?> putVerification(
  //     {required String studentId,
  //     required String studentCode,
  //     required String studentCardFont,
  //     required String studentCardBack});

  // Future<OrderDetailModel?> fetchOrderDetailByStudentId(
  //     {required String studentId, required String orderId});
}
