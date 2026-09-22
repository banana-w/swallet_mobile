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

/// Tạo tài khoản thành công — khác hẳn với đăng nhập thành công.
///
/// Trước đây đăng ký cũng phát [AuthenticationSuccess]. Màn đăng nhập nằm dưới
/// các bước đăng ký trong stack nên `BlocListener` của nó vẫn sống và vẫn nghe:
/// đăng ký xong là nó bắn `RoleAppStart` rồi đẩy thẳng vào `/landing-screen`,
/// tranh chấp với điều hướng sang bước xác minh của chính màn đăng ký.
final class RegistrationSuccess extends AuthenticationState {
  const RegistrationSuccess();

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

final class AuthenticationFailed extends AuthenticationState {
  final String error;

  const AuthenticationFailed({required this.error});

  @override
  List<Object?> get props => [error];
}
