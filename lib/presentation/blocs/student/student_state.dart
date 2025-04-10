part of 'student_bloc.dart';

sealed class StudentState extends Equatable {
  const StudentState();
}

final class StudentInitial extends StudentState {
  @override
  List<Object?> get props => [];
}

final class StudentVoucherLoading extends StudentState {
  @override
  List<Object?> get props => [];
}

final class StudentVouchersLoaded extends StudentState {
  final List<VoucherStudentModel> voucherModels;

  final bool hasReachedMax;

  const StudentVouchersLoaded({
    required this.voucherModels,
    this.hasReachedMax = false,
  });

  @override
  List<Object?> get props => [voucherModels, hasReachedMax];
}

final class StudentVouchersLoaded1 extends StudentState {
  final List<BrandVoucher> brandVoucherModels;

  final bool hasReachedMax;

  const StudentVouchersLoaded1({
    required this.brandVoucherModels,
    this.hasReachedMax = false,
  });

  @override
  List<Object?> get props => [brandVoucherModels, hasReachedMax];
}

final class StudentFaled extends StudentState {
  final String error;

  const StudentFaled({required this.error});

  @override
  List<Object?> get props => [error];
}

final class StudentTransactionLoading extends StudentState {
  @override
  List<Object?> get props => [];
}

final class StudentTransactionsLoaded extends StudentState {
  final List<TransactionModel> transactions;
  final bool hasReachedMax;

  const StudentTransactionsLoaded(
      {required this.transactions, this.hasReachedMax = false});

  @override
  List<Object?> get props => [transactions, hasReachedMax];
}

final class StudentOrderLoading extends StudentState {
  @override
  List<Object?> get props => [];
}

// final class StudentOrdersLoaded extends StudentState {
//   final List<OrderModel> orderModels;
//   final bool hasReachedMax;

//   StudentOrdersLoaded({required this.orderModels, this.hasReachedMax = false});

//   @override
//   List<Object?> get props => [orderModels, hasReachedMax];
// }

final class StudentUpding extends StudentState {
  @override
  List<Object?> get props => [];
}

final class StudentUpdateSuccess extends StudentState {
  final StudentModel studentModel;

  const StudentUpdateSuccess({required this.studentModel});

  @override
  List<Object?> get props => [studentModel];
}

final class StudentVoucherItemLoading extends StudentState {
  @override
  List<Object?> get props => [];
}

final class StudentVoucherLoadingMore extends StudentState {
  @override
  List<Object?> get props => [];
}

final class StudentVoucherItemLoaded extends StudentState {
  final CampaignVoucherDetailModel voucherStudentItemModel;
  final CampaignDetailModel campaignDetailModel;
  final String studentId;

  const StudentVoucherItemLoaded({required this.voucherStudentItemModel, 
    required this.campaignDetailModel, required this.studentId});

  @override
  List<Object?> get props => [voucherStudentItemModel, campaignDetailModel, studentId];
}

final class StudentByIdSuccess extends StudentState {
  final StudentModel studentMode;

  const StudentByIdSuccess({required this.studentMode});

  @override
  List<Object?> get props => [studentMode];
}

final class StudentByIdFailed extends StudentState {
  final String error;

  const StudentByIdFailed({required this.error});

  @override
  List<Object?> get props => [error];
}

final class StudentByIdLoading extends StudentState {
  const StudentByIdLoading();
  @override
  List<Object?> get props => [];
}

final class StudentUpdatingVerification extends StudentState {
  @override
  List<Object?> get props => [];
}

final class StudentUpdateVerificationSuccess extends StudentState {
  final StudentModel studentModel;

  const StudentUpdateVerificationSuccess({required this.studentModel});

  @override
  List<Object?> get props => [studentModel];
}

final class StudentOrderDetailLoading extends StudentState {
  @override
  List<Object?> get props => [];
}

class QRScanLoading extends StudentState {
  const QRScanLoading();

  @override
  List<Object?> get props => [];
}

class QRScanSuccess extends StudentState {
  final ScanQRResponse response;

  const QRScanSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class QRScanFailed extends StudentState {
  final String error;

  const QRScanFailed(this.error);

  @override
  List<Object?> get props => [error];
}

// final class StudentOrderDetailLoaded extends StudentState {
//   final OrderDetailModel orderDetailModel;

//   StudentOrderDetailLoaded({required this.orderDetailModel});

//   @override
//   List<Object?> get props => [orderDetailModel];
// }

final class StudentWishlistLoading extends StudentState {
  @override
  List<Object?> get props => [];
}

final class StudentWishlistLoaded extends StudentState {
  final List<String> wishLists;

  const StudentWishlistLoaded({required this.wishLists});

  @override
  List<Object?> get props => [wishLists];
}
