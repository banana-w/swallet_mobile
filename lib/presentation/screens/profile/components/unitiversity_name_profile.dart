import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class UniversityProfile extends StatelessWidget {
  const UniversityProfile(
      {super.key,
      required this.fem,
      required this.hem,
      required this.ffem,
      required this.university});

  final double fem;
  final double hem;
  final double ffem;
  final String university;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            width: 15 * fem,
            height: 15 * hem,
            child: SvgPicture.asset(
              'assets/icons/university-icon.svg',
            )),
        SizedBox(
          width: 5 * fem,
        ),
        Text(
          university,
          style: GoogleFonts.openSans(
              textStyle: TextStyle(
                  fontSize: 13 * ffem,
                  fontWeight: FontWeight.normal,
                  color: Colors.black)),
        ),
      ],
    );
  }
}
