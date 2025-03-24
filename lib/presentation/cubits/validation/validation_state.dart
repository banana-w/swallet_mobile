part of 'validation_cubit.dart';

sealed class ValidationState extends Equatable {
  const ValidationState();
}

final class ValidationInitial extends ValidationState {
  @override
  List<Object?> get props => [];
}

final class ValidationInProcess extends ValidationState {
  @override
  List<Object?> get props => [];
}


final class CheckEmailSuccess extends ValidationState {
  CheckEmailSuccess();

  @override
  List<Object?> get props => [];
}

final class CheckEmailFailed extends ValidationState {
  final String error;
  final bool check;
  CheckEmailFailed({required this.error, required this.check});

  @override
  List<Object?> get props => [error, check];
}

final class CheckUserNameSuccess extends ValidationState {
  CheckUserNameSuccess();

  @override
  List<Object?> get props => [];
}

final class CheckUserNameFailed extends ValidationState {
  final String error;
  final bool check;
  CheckUserNameFailed({required this.error, required this.check});

  @override
  List<Object?> get props => [error, check];
}

final class CheckStudentCodeSuccess extends ValidationState {
  CheckStudentCodeSuccess();

  @override
  List<Object?> get props => [];
}

final class CheckStudentCodeFailed extends ValidationState {
  final String error;
  final bool check;
  CheckStudentCodeFailed({required this.error, required this.check});

  @override
  List<Object?> get props => [error, check];
}

final class CheckInvitedCodeSuccess extends ValidationState {
  CheckInvitedCodeSuccess();

  @override
  List<Object?> get props => [];
}

final class CheckInvitedCodeFailed extends ValidationState {
  final String error;
  final bool check;
  CheckInvitedCodeFailed({required this.error, required this.check});

  @override
  List<Object?> get props => [error, check];
}

final class CheckPhoneSuccess extends ValidationState {
  CheckPhoneSuccess();

  @override
  List<Object?> get props => [];
}

final class CheckPhoneFailed extends ValidationState {
  final String error;
  final bool check;
  CheckPhoneFailed({required this.error, required this.check});

  @override
  List<Object?> get props => [error, check];
}