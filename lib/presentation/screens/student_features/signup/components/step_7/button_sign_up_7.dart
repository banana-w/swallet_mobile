import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/cubits/validation/validation_cubit.dart';

import 'form_7.dart';

class ButtonSignUp7 extends StatelessWidget {
  const ButtonSignUp7({
    super.key,
    required this.widget,
    required this.onPressed,
    this.isLoading = false,
  });

  final FormBody7 widget;

  /// `null` khi đang tạo tài khoản — nút tự khoá.
  final VoidCallback? onPressed;

  /// Đang gọi API tạo tài khoản (ngoài vòng xoay của bước kiểm tra số điện
  /// thoại do [ValidationCubit] quản lý).
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: 220 * widget.fem,
        height: 45 * widget.hem,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(23 * widget.fem),
        ),
        child: BlocBuilder<ValidationCubit, ValidationState>(
          builder: (context, state) {
            if (isLoading || state is ValidationInProcess) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }
            return Center(
              child: Text(
                'Tiếp tục',
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: 17 * widget.ffem,
                    fontWeight: FontWeight.w600,
                    height: 1.3625 * widget.ffem / widget.fem,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
