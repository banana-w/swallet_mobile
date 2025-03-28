import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

class ButtonProfile extends StatelessWidget {
  const ButtonProfile({
    super.key,
    required this.fem,
    required this.hem,
    required this.ffem,
    required this.svgIcon,
    required this.title,
    required this.onPressed,
    this.widthIcon = 15,
    this.heightIcon = 15,
  });

  final double fem;
  final double hem;
  final double ffem;
  final String svgIcon;
  final String title;
  final VoidCallback onPressed;
  final double widthIcon;
  final double heightIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 324 * fem,
      height: 53 * hem,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x0c000000),
            offset: Offset(0 * fem, 10 * fem),
            blurRadius: 5 * fem,
          ),
        ],
      ),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: WidgetStateProperty.resolveWith<RoundedRectangleBorder?>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.pressed)) {
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10 * fem),
                side: const BorderSide(color: kPrimaryColor),
              );
            }
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10 * fem),
              side: const BorderSide(color: Colors.white),
            );
          }),
          backgroundColor: WidgetStateProperty.all(Colors.white),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 15 * fem),
            Container(
              width: 35 * fem,
              height: 35 * hem,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
              ),
              child: Center(
                child: SvgPicture.asset(
                  svgIcon,
                  height: heightIcon * hem,
                  width: widthIcon * fem,
                  colorFilter: ColorFilter.mode(kLowTextColor, BlendMode.srcIn),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10 * hem, left: 20 * fem),
              child: SizedBox(
                width: 130 * fem,
                child: Text(
                  title,
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: 14 * ffem,
                      height: 1.3625 * ffem / fem,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10 * hem, left: 70 * fem),
              child: Icon(
                Icons.arrow_forward_outlined,
                color: kLowTextColor,
                size: 18 * fem,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
