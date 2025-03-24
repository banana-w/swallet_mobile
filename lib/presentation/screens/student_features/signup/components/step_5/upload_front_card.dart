import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

class UpLoadFrontCard extends StatelessWidget {
  const UpLoadFrontCard({
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
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 100 * fem,
        height: 35 * hem,
        decoration: BoxDecoration(
          border: Border.all(color: kPrimaryColor, width: 1),
          borderRadius: BorderRadius.circular(10 * fem),
        ),
        child: Center(
          child: Text(
            'Thêm ảnh',
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                color: kPrimaryColor,
                fontSize: 14 * ffem,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
