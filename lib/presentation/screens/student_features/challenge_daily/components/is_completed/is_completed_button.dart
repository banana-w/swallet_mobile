import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/constants.dart';

class IsCompletedButton extends StatelessWidget {
  const IsCompletedButton(
      {super.key,
      required this.fem,
      required this.hem,
      required this.onPressed});

  final double fem;
  final double hem;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85 * fem,
      height: 32 * hem,
      margin: EdgeInsets.only(bottom: 15 * hem, left: 10 * fem),
      decoration: BoxDecoration(
          color: kPrimaryColor, borderRadius: BorderRadius.circular(5)),
      child: TextButton(
        onPressed: onPressed,
        child: Center(
          child: Text(
            'Nhận',
            style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
