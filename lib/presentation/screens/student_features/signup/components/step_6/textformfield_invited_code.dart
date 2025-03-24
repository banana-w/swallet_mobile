import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

// ignore: must_be_immutable
class TextFormFieldInviteCode extends StatelessWidget {
  TextFormFieldInviteCode({
    super.key,
    required this.hem,
    required this.fem,
    required this.ffem,
    required this.labelText,
    required this.hintText,
    required this.textController,
  });

  final double hem;
  final double fem;
  final double ffem;
  final String labelText;
  final String hintText;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 272 * fem,
      // color: Colors.red,
      child: TextFormField(
        controller: textController,
        style: GoogleFonts.openSans(
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 15 * ffem,
            fontWeight: FontWeight.w700,
          ),
        ),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: GoogleFonts.openSans(
            textStyle: TextStyle(
              color: kPrimaryColor,
              fontSize: 15 * ffem,
              fontWeight: FontWeight.w900,
            ),
          ),
          hintStyle: GoogleFonts.openSans(
            textStyle: TextStyle(
              color: kLowTextColor,
              fontSize: 15 * ffem,
              fontWeight: FontWeight.w700,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 26 * fem,
            vertical: 10 * hem,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28 * fem),
            borderSide: BorderSide(
              width: 2,
              color: const Color.fromARGB(255, 220, 220, 220),
            ),
            gapPadding: 10,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28 * fem),
            borderSide: BorderSide(
              width: 2,
              color: const Color.fromARGB(255, 220, 220, 220),
            ),
            gapPadding: 10,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28 * fem),
            borderSide: BorderSide(
              width: 2,
              color: const Color.fromARGB(255, 220, 220, 220),
            ),
            gapPadding: 10,
          ),
        ),
      ),
    );
  }
}
