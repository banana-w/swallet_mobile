import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

class AppBarSignUp extends StatelessWidget implements PreferredSizeWidget {
  const AppBarSignUp({
    super.key,
    required this.hem,
    required this.ffem,
    required this.fem,
    required this.text,
  });

  final double hem;
  final double ffem;
  final double fem;
  final String text;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 120 * hem,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(
        text,
        style: GoogleFonts.openSans(
          textStyle: TextStyle(
            fontSize: 15 * ffem,
            fontWeight: FontWeight.w900,
            height: 1.3625 * ffem / fem,
            color: kLowTextColor,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(140);
}
