part of 'student_bloc.dart';

sealed class StudentEvent extends Equatable {
  const StudentEvent();
}

final class LoadStudentVouchers extends StudentEvent {
  final int page;
  final int limit;
  final String id;
  final String search;
  final bool isUsed;

  LoadStudentVouchers({
    this.page = 1,
    this.limit = 10,
    required this.id,
    this.search = '',
    required this.isUsed,
  });

  @override
  List<Object?> get props => [page, limit, id, search];
}

final class HideUsedVouchers extends StudentEvent {
  final bool hide;

  HideUsedVouchers({required this.hide});
  @override
  List<Object?> get props => [hide];
}

final class LoadMoreStudentVouchers extends StudentEvent {
  final int page;
  final int limit;
  final String search;
  final String id;
  final bool isUsed;
  final ScrollController scrollController;

  LoadMoreStudentVouchers(
    this.scrollController, {
    required this.id,
    this.page = 1,
    this.limit = 10,
    required this.isUsed,
    this.search = '',
  });
  @override
  List<Object?> get props => [page, limit, search, scrollController, id];
}

final class LoadStudentTransactions extends StudentEvent {
  final int page;
  final int limit;
  final String id;
  final int typeIds;
  LoadStudentTransactions({
    this.page = 1,
    this.limit = 10,
    required this.id,
    this.typeIds = 0,
  });

  @override
  List<Object?> get props => [page, limit, id, typeIds];
}

final class LoadMoreTransactions extends StudentEvent {
  final int page;
  final int limit;
  final int typeIds;
  final ScrollController scrollController;

  LoadMoreTransactions(
    this.scrollController, {
    this.page = 1,
    this.limit = 10,
    this.typeIds = 0,
  });
  @override
  List<Object?> get props => [page, limit, typeIds, scrollController];
}

final class LoadMoreActivityTransactions extends StudentEvent {
  final int page;
  final int limit;
  final int typeIds;
  final ScrollController scrollController;

  LoadMoreActivityTransactions(
    this.scrollController, {
    this.page = 1,
    this.limit = 10,
    this.typeIds = 0,
  });
  @override
  List<Object?> get props => [page, limit, typeIds, scrollController];
}

final class LoadMoreBonusTransactions extends StudentEvent {
  final int page;
  final int limit;
  final int typeIds;
  final ScrollController scrollController;

  LoadMoreBonusTransactions(
    this.scrollController, {
    this.page = 1,
    this.limit = 10,
    this.typeIds = 0,
  });
  @override
  List<Object?> get props => [page, limit, typeIds, scrollController];
}

final class LoadMoreOrderTransactions extends StudentEvent {
  final int page;
  final int limit;
  final int typeIds;
  final ScrollController scrollController;

  LoadMoreOrderTransactions(
    this.scrollController, {
    this.page = 1,
    this.limit = 10,
    this.typeIds = 0,
  });
  @override
  List<Object?> get props => [page, limit, typeIds, scrollController];
}

final class LoadMoreChallengeTransactions extends StudentEvent {
  final int page;
  final int limit;
  final int typeIds;
  final ScrollController scrollController;

  LoadMoreChallengeTransactions(
    this.scrollController, {
    this.page = 1,
    this.limit = 10,
    this.typeIds = 0,
  });
  @override
  List<Object?> get props => [page, limit, typeIds, scrollController];
}

final class LoadMoreOrders extends StudentEvent {
  final int page;
  final int limit;
  final ScrollController scrollController;

  LoadMoreOrders(this.scrollController, {this.page = 1, this.limit = 10});
  @override
  List<Object?> get props => [page, limit, scrollController];
}

final class LoadStudentOrders extends StudentEvent {
  final int page;
  final int limit;
  final String id;
  LoadStudentOrders({this.page = 1, this.limit = 10, required this.id});

  @override
  List<Object?> get props => [page, limit, id];
}

final class UpdateStudent extends StudentEvent {
  final String studentId;
  final String fullName;
  final String majorId;
  final String campusId;
  final int gender;
  final String avatar;
  final String address;

  UpdateStudent({
    required this.studentId,
    required this.fullName,
    required this.majorId,
    required this.campusId,
    required this.gender,
    this.avatar = '',
    this.address = '',
  });

  @override
  List<Object?> get props => [
    studentId,
    fullName,
    majorId,
    campusId,
    gender,
    address,
  ];
}

final class LoadVoucherItem extends StudentEvent {
  final String studentId;
  final String voucherId;

  LoadVoucherItem({required this.studentId, required this.voucherId});

  @override
  List<Object?> get props => [studentId, voucherId];
}

final class LoadStudentById extends StudentEvent {
  final String accountId;

  LoadStudentById({required this.accountId});

  @override
  List<Object?> get props => [accountId];
}

final class UpdateVerification extends StudentEvent {
  final String studentId;
  final String studentCode;
  final String studentCardFront;
  final String studentCardBack;

  UpdateVerification({
    required this.studentId,
    required this.studentCode,
    required this.studentCardFront,
    required this.studentCardBack,
  });

  @override
  List<Object?> get props => [
    studentId,
    studentCode,
    studentCardBack,
    studentCardFront,
  ];
}

final class LoadOrderDetailById extends StudentEvent {
  final String studentId;
  final String orderId;

  LoadOrderDetailById({required this.studentId, required this.orderId});

  @override
  List<Object?> get props => [studentId, orderId];
}

final class LoadWishList extends StudentEvent {
  @override
  List<Object?> get props => [];
}
