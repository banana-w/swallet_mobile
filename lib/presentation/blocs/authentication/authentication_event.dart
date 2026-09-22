part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

/// Đưa bloc về [AuthenticationInitial].
///
/// Bloc này sống ở cấp app nên state của lần đăng nhập/đăng ký trước vẫn còn
/// nguyên khi quay lại màn đăng nhập. Màn đăng nhập bắn event này lúc mở để
/// không hiện lại lỗi cũ khi người dùng chưa gõ gì.
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

final class RegisterAccount extends AuthenticationEvent {
  final CreateAuthenModel createAuthenModel;

  const RegisterAccount({required this.createAuthenModel});

  @override
  List<Object?> get props => [createAuthenModel];
}
