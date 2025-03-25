part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

final class StartAuthen extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

final class LoginAccount extends AuthenticationEvent {
  final String userName;
  final String password;

  const LoginAccount({required this.userName, required this.password});

  @override
  List<Object?> get props => [userName, password];
}

final class LogoutAccount extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

final class RegisterAccount extends AuthenticationEvent {
  final CreateAuthenModel createAuthenModel;

  const RegisterAccount({required this.createAuthenModel});

  @override
  List<Object?> get props => [createAuthenModel];
}

final class VerifyAccount extends AuthenticationEvent {
  final VerifyAuthenModel verifyAuthenModel;

  const VerifyAccount({required this.verifyAuthenModel});

  @override
  List<Object?> get props => [verifyAuthenModel];
}
