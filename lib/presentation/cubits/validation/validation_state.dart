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
  const CheckEmailSuccess();

  @override
  List<Object?> get props => [];
}

final class CheckEmailFailed extends ValidationState {
  final String error;
  final bool check;
  const CheckEmailFailed({required this.error, required this.check});

  @override
  List<Object?> get props => [error, check];
}

final class CheckUserNameSuccess extends ValidationState {
  const CheckUserNameSuccess();

  @override
  List<Object?> get props => [];
}

final class CheckUserNameFailed extends ValidationState {
  final String error;
  final bool check;
  const CheckUserNameFailed({required this.error, required this.check});

  @override
  List<Object?> get props => [error, check];
}

final class CheckStudentCodeSuccess extends ValidationState {
  const CheckStudentCodeSuccess();

  @override
  List<Object?> get props => [];
}

final class CheckStudentCodeFailed extends ValidationState {
  final String error;
  final bool check;
  const CheckStudentCodeFailed({required this.error, required this.check});

  @override
  List<Object?> get props => [error, check];
}

final class CheckInvitedCodeSuccess extends ValidationState {
  const CheckInvitedCodeSuccess();

  @override
  List<Object?> get props => [];
}

final class CheckInvitedCodeFailed extends ValidationState {
  final String error;
  final bool check;
  const CheckInvitedCodeFailed({required this.error, required this.check});

  @override
  List<Object?> get props => [error, check];
}

final class CheckPhoneSuccess extends ValidationState {
  const CheckPhoneSuccess();

  @override
  List<Object?> get props => [];
}

final class CheckPhoneFailed extends ValidationState {
  final String error;
  final bool check;
  const CheckPhoneFailed({required this.error, required this.check});

  @override
  List<Object?> get props => [error, check];
}