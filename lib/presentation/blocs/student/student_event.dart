part of 'student_bloc.dart';

sealed class StudentEvent extends Equatable {
  const StudentEvent();
}

class ScanLectureQR extends StudentEvent {
  final String qrCode;
  final String studentId;
  final double longitude;
  final double latitude;

  const ScanLectureQR({
    required this.qrCode,
    required this.studentId,
    required this.longitude,
    required this.latitude,
  });

  @override
  List<Object> get props => [qrCode, studentId];
}

final class LoadStudentVouchers extends StudentEvent {
  final int page;
  final int limit;
  final String id;
  final String search;
  final bool isUsed;

  const LoadStudentVouchers({
    this.page = 1,
    this.limit = 3,
    required this.id,
    this.search = '',
    required this.isUsed,
  });

  @override
  List<Object?> get props => [page, limit, id, search];
}

final class HideUsedVouchers extends StudentEvent {
  final bool hide;

  const HideUsedVouchers({required this.hide});
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

  const LoadMoreStudentVouchers(
    this.scrollController, {
    required this.id,
    this.page = 1,
    this.limit = 3,
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
  const LoadStudentTransactions({
    this.page = 1,
    this.limit = 10,
    required this.id,
    required this.typeIds,
  });

  @override
  List<Object?> get props => [page, limit, id, typeIds];
}

final class LoadMoreTransactions extends StudentEvent {
  final int page;
  final int limit;
  final int typeIds;
  final ScrollController scrollController;

  const LoadMoreTransactions(
    this.scrollController, {
    this.page = 1,
    this.limit = 10,
    this.typeIds = 0,
  });
  @override
  List<Object?> get props => [page, limit, typeIds, scrollController];
}

final class LoadVoucherTransactions extends StudentEvent {
  final int page;
  final int limit;
  final String id;
  final int typeIds;
  const LoadVoucherTransactions({
    this.page = 1,
    this.limit = 10,
    required this.id,
    this.typeIds = 0,
  });

  @override
  List<Object?> get props => [page, limit, id, typeIds];
}

final class LoadMoreVoucherTransactions extends StudentEvent {
  final int page;
  final int limit;
  final int typeIds;
  final ScrollController scrollController;

  const LoadMoreVoucherTransactions(
    this.scrollController, {
    this.page = 1,
    this.limit = 10,
    this.typeIds = 0,
  });
  @override
  List<Object?> get props => [page, limit, typeIds, scrollController];
}

final class LoadVoucherStoreTransactions extends StudentEvent {
  final int page;
  final int limit;
  final String id;
  final int typeIds;
  const LoadVoucherStoreTransactions({
    this.page = 1,
    this.limit = 10,
    required this.id,
    this.typeIds = 0,
  });

  @override
  List<Object?> get props => [page, limit, id, typeIds];
}

final class LoadMoreVoucherStoreTransactions extends StudentEvent {
  final int page;
  final int limit;
  final int typeIds;
  final ScrollController scrollController;

  const LoadMoreVoucherStoreTransactions(
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

  const LoadMoreActivityTransactions(
    this.scrollController, {
    this.page = 1,
    this.limit = 10,
    this.typeIds = 1,
  });
  @override
  List<Object?> get props => [page, limit, typeIds, scrollController];
}

final class LoadMoreChallengeTransactions extends StudentEvent {
  final int page;
  final int limit;
  final int typeIds;
  final ScrollController scrollController;

  const LoadMoreChallengeTransactions(
    this.scrollController, {
    this.page = 1,
    this.limit = 10,
    this.typeIds = 2,
  });
  @override
  List<Object?> get props => [page, limit, typeIds, scrollController];
}

final class UpdateStudent extends StudentEvent {
  final String studentId;
  final String fullName;
  final String studentCode;
  final DateTime dateOfBirth;
  // final String majorId;
  final String campusId;
  final int gender;
  final String avatar;
  final String address;

  const UpdateStudent({
    required this.studentId,
    required this.fullName,
    required this.studentCode,
    required this.dateOfBirth,
    // required this.majorId,
    required this.campusId,
    required this.gender,
    this.avatar = '',
    this.address = '',
  });

  @override
  List<Object?> get props => [
    studentId,
    fullName,
    // majorId,
    campusId,
    gender,
    address,
  ];
}

final class LoadVoucherItem extends StudentEvent {
  final String campaignId;
  final String voucherId;

  const LoadVoucherItem({required this.campaignId, required this.voucherId});

  @override
  List<Object?> get props => [campaignId, voucherId];
}

final class LoadStudentById extends StudentEvent {
  final String accountId;

  const LoadStudentById({required this.accountId});

  @override
  List<Object?> get props => [accountId];
}

final class UpdateVerification extends StudentEvent {
  final String studentId;
  final String studentCardFront;

  const UpdateVerification({
    required this.studentId,
    required this.studentCardFront,
  });

  @override
  List<Object?> get props => [studentId, studentCardFront];
}

class SkipUpdateVerification extends StudentEvent {
  final String studentId;
  const SkipUpdateVerification({required this.studentId});

  @override
  List<Object?> get props => [studentId];
}

final class LoadOrderDetailById extends StudentEvent {
  final String studentId;
  final String orderId;

  const LoadOrderDetailById({required this.studentId, required this.orderId});

  @override
  List<Object?> get props => [studentId, orderId];
}

final class LoadWishList extends StudentEvent {
  @override
  List<Object?> get props => [];
}
