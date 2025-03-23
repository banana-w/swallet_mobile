import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentCodeProfile extends StatelessWidget {
  const StudentCodeProfile({
    super.key,
    required this.hem,
    required this.fem,
    required this.ffem,
    required this.studentCode,
  });

  final double hem;
  final double fem;
  final double ffem;
  final String studentCode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10 * hem, bottom: 5 * hem),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              width: 15 * fem,
              height: 15 * hem,
              child: SvgPicture.asset(
                'assets/icons/id-card-icon.svg',
              )),
          SizedBox(
            width: 5 * fem,
          ),
          Text(
            studentCode,
            style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    fontSize: 13 * ffem,
                    fontWeight: FontWeight.normal,
                    color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
