part of 'role_app_bloc.dart';

sealed class RoleAppState extends Equatable {
  const RoleAppState();
}

final class Verified extends RoleAppState {
  final AuthenModel authenModel;
  final StudentModel studentModel;

  const Verified({required this.authenModel, required this.studentModel});
  @override
  List<Object?> get props => [authenModel, studentModel];
}

final class Unverified extends RoleAppState {
  final AuthenModel authenModel;
  final StudentModel studentModel;

  const Unverified({required this.authenModel, required this.studentModel});
  @override
  List<Object?> get props => [authenModel];
}

final class StoreRole extends RoleAppState {
  final AuthenModel authenModel;
  final StoreModel storeModel;

  const StoreRole({required this.authenModel, required this.storeModel});

  @override
  List<Object?> get props => [authenModel, storeModel];
}

final class LectureRole extends RoleAppState {
  final AuthenModel authenModel;
  final LectureModel lectureModel;

  const LectureRole({required this.authenModel, required this.lectureModel});

  @override
  List<Object?> get props => [authenModel, lectureModel];
}

final class RoleAppLoading extends RoleAppState {
  @override
  List<Object?> get props => [];
}
final class RoleReset extends RoleAppState {
  @override
  List<Object?> get props => [];
}

// final class Pending extends RoleAppState {
//   final AuthenModel authenModel;
//   final StudentModel studentModel;

//   Pending({required this.authenModel, required this.studentModel});
//   @override
//   List<Object?> get props => [authenModel, studentModel];
// }

// final class Rejected extends RoleAppState {
//   final AuthenModel authenModel;
//   final StudentModel studentModel;

//   Rejected({required this.authenModel, required this.studentModel});
//   @override
//   List<Object?> get props => [authenModel, studentModel];
// }

// final class InActive extends RoleAppState {
//   final AuthenModel authenModel;

//   InActive({required this.authenModel});
//   @override
//   List<Object?> get props => [
//         authenModel,
//       ];
// }
