import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/constants.dart';

class IsClaimedButton extends StatelessWidget {
  const IsClaimedButton({
    super.key,
    required this.fem,
    required this.hem,
  });

  final double fem;
  final double hem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85 * fem,
      height: 33 * hem,
      margin: EdgeInsets.only(bottom: 15*hem,left: 10*fem),
      decoration: BoxDecoration(
          border: Border.all(color: kPrimaryColor),
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: Text(
          'Đã nhận',
          style: GoogleFonts.openSans(
              textStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor)),
        ),
      ),
    );
  }
}
