import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AppBarStore extends StatelessWidget implements PreferredSizeWidget {
  const AppBarStore({
    super.key,
    required this.hem,
    required this.ffem,
    required this.fem,
  });

  final double hem;
  final double ffem;
  final double fem;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background_splash.png'),
                fit: BoxFit.cover)),
      ),
      toolbarHeight: 50 * hem,
      centerTitle: true,
      title: Text(
        'UniBean',
        style: GoogleFonts.openSans(
            textStyle: TextStyle(
                fontSize: 22 * ffem,
                fontWeight: FontWeight.w900,
                color: Colors.white)),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
