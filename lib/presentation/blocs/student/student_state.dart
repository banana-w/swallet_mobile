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

// final class StudentVouchersLoaded extends StudentState {
//   final List<VoucherStudentModel> voucherModels;

//   final bool hasReachedMax;

//   StudentVouchersLoaded(
//       {required this.voucherModels, this.hasReachedMax = false});

//   @override
//   List<Object?> get props => [voucherModels, hasReachedMax];
// }

final class StudentFaled extends StudentState {
  final String error;

  StudentFaled({required this.error});

  @override
  List<Object?> get props => [error];
}

final class StudentTransactionLoading extends StudentState {
  @override
  List<Object?> get props => [];
}

// final class StudentTransactionsLoaded extends StudentState {
//   final List<TransactionModel> transactions;
//   final bool hasReachedMax;

//   StudentTransactionsLoaded(
//       {required this.transactions, this.hasReachedMax = false});

//   @override
//   List<Object?> get props => [transactions, hasReachedMax];
// }

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

  StudentUpdateSuccess({required this.studentModel});

  @override
  List<Object?> get props => [studentModel];
}

final class StudentVoucherItemLoading extends StudentState {
  @override
  List<Object?> get props => [];
}

// final class StudentVoucherItemLoaded extends StudentState {
//   final VoucherStudentItemModel voucherStudentItemModel;

//   StudentVoucherItemLoaded({required this.voucherStudentItemModel});

//   @override
//   List<Object?> get props => [voucherStudentItemModel];
// }

final class StudentByIdSuccess extends StudentState {
  final StudentModel studentMode;

  StudentByIdSuccess({required this.studentMode});

  @override
  List<Object?> get props => [studentMode];
}

final class StudentByIdFailed extends StudentState {
  final String error;

  StudentByIdFailed({required this.error});

  @override
  List<Object?> get props => [error];
}

final class StudentByIdLoading extends StudentState {
  StudentByIdLoading();
  @override
  List<Object?> get props => [];
}

final class StudentUpdatingVerification extends StudentState {
  @override
  List<Object?> get props => [];
}

final class StudentUpdateVerificationSuccess extends StudentState {
  final StudentModel studentModel;

  StudentUpdateVerificationSuccess({required this.studentModel});

  @override
  List<Object?> get props => [studentModel];
}

final class StudentOrderDetailLoading extends StudentState {
  @override
  List<Object?> get props => [];
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

  StudentWishlistLoaded({required this.wishLists});

  @override
  List<Object?> get props => [wishLists];
}
