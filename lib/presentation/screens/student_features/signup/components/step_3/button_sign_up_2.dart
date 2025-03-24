import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

class ButtonSignUp2 extends StatelessWidget {
  const ButtonSignUp2({
    super.key,
    required this.fem,
    required this.hem,
    required this.ffem,
    required this.onPressed,
  });

  final double fem;
  final double hem;
  final double ffem;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      // onPressed: () {
      //   // Navigator.pushNamed(context, SignUp3Screen.routeName);
      // },
      onPressed: onPressed,
      child: Container(
        width: 220 * fem,
        height: 45 * hem,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(23 * fem),
        ),
        child: Center(
          child: Text(
            'Tiếp tục',
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
