import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

class ItemIconCardProfile extends StatelessWidget {
  const ItemIconCardProfile({
    super.key,
    required this.fem,
    required this.hem,
    required this.ffem,
    required this.title,
    required this.svgAssetName,
  });

  final double fem;
  final double hem;
  final double ffem;
  final String title;
  final String svgAssetName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40 * fem,
          height: 40 * hem,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[100],
          ),
          child: Center(
            child: SvgPicture.asset(
              svgAssetName,
              height: 25 * fem,
              width: 25 * fem,
            ),
          ),
        ),
        Text(
          title,
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontSize: 10 * fem,
              fontWeight: FontWeight.w600,
              height: 1.3625 * ffem / fem,
              color: kLowTextColor,
            ),
          ),
        ),
      ],
    );
  }
}
