part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();
}

final class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

final class AuthenticationSuccess extends AuthenticationState {
  const AuthenticationSuccess();

  @override
  List<Object?> get props => [];
}

final class AuthenticationSuccessButNotVerified extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

final class AuthenticationStoreSuccess extends AuthenticationState {
  const AuthenticationStoreSuccess();

  @override
  List<Object?> get props => [];
}

final class AuthenticationLectureSuccess extends AuthenticationState {
  const AuthenticationLectureSuccess();

  @override
  List<Object?> get props => [];
}

final class AuthenticationInProcess extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

final class AuthenticationInProcessByGmail extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

final class AuthenticationFailed extends AuthenticationState {
  final String error;

  const AuthenticationFailed({required this.error});

  @override
  List<Object?> get props => [error];
}
