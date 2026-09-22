import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

class ButtonLogin extends StatelessWidget {
  const ButtonLogin({
    super.key,
    required this.fem,
    required this.hem,
    required this.ffem,
    required this.isLoading,
    required this.onPressed,
  });

  final double fem;
  final double hem;
  final double ffem;
  final bool isLoading;

  /// `null` khi đang đăng nhập — nút tự khoá.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: 300 * fem,
        height: 45 * hem,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(23 * fem),
        ),
        child: Center(
          child:
              isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                    'Đăng nhập',
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontSize: 17 * ffem,
                        fontWeight: FontWeight.w600,
                        height: 1.3625 * ffem / fem,
                        color: Colors.white,
                      ),
                    ),
                  ),
        ),
      ),
    );
  }
}
