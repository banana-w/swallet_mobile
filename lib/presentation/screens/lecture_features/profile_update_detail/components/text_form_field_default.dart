import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

// ignore: must_be_immutable
class TextFormFieldDefault extends StatelessWidget {
  const TextFormFieldDefault({
    super.key,
    required this.hem,
    required this.fem,
    required this.ffem,
    required this.labelText,
    required this.hintText,
    required this.initialValue,
    this.readOnly = true, // Mặc định là readonly
    this.maxLines = 1, // Mặc định là 1 dòng
  });

  final double hem;
  final double fem;
  final double ffem;
  final String labelText;
  final String hintText;
  final String initialValue;
  final bool readOnly;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 272 * fem,
      child: TextFormField(
        initialValue: initialValue,
        readOnly: readOnly,
        maxLines: maxLines,
        style: GoogleFonts.openSans(
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 15 * ffem,
            fontWeight: FontWeight.bold,
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
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromARGB(255, 220, 220, 220),
            ),
            gapPadding: 10,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28 * fem),
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromARGB(255, 220, 220, 220),
            ),
            gapPadding: 10,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28 * fem),
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromARGB(255, 220, 220, 220),
            ),
            gapPadding: 10,
          ),
        ),
      ),
    );
  }
}
