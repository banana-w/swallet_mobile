import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.hem,
    required this.fem,
    required this.ffem,
  });

  final double hem;
  final double fem;
  final double ffem;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Center(
        child: Container(
          margin: EdgeInsets.only(top: 20 * hem),
          width: 300 * fem,
          height: 45 * hem,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(23 * fem),
          ),
          child: Center(
            child: Text(
              'Lọc',
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
      ),
    );
  }
}
