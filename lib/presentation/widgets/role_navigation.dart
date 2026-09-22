import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/widgets/unverified_screen.dart';

/// Mở [routeName], hoặc màn hình yêu cầu xác thực nếu tài khoản chưa xác thực.
///
/// Đọc [RoleAppBloc] ngay lúc chạm thay vì `context.watch` trong `build`, nhờ
/// vậy màn hình không phải dựng lại mỗi khi role đổi state.
void openByRole(BuildContext context, String routeName, {Object? arguments}) {
  if (context.read<RoleAppBloc>().state is Unverified) {
    Navigator.pushNamed(context, UnverifiedScreen.routeName);
  } else {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }
}
