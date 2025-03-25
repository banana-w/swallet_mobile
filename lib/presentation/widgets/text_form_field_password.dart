import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

class TextFormFieldPassword extends StatefulWidget {
  const TextFormFieldPassword({
    super.key,
    required this.hem,
    required this.fem,
    required this.ffem,
    required this.labelText,
    required this.hintText,
    required this.isPassword,
    required this.validator,
    required this.textController,
  });

  final double hem;
  final double fem;
  final double ffem;
  final String labelText;
  final String hintText;
  final bool isPassword;
  final FormFieldValidator<String> validator;
  final TextEditingController textController;

  @override
  State<TextFormFieldPassword> createState() => _TextFormFieldPasswordState();
}

class _TextFormFieldPasswordState extends State<TextFormFieldPassword> {
  bool _isObscure = true;

  @override
  void initState() {
    _isObscure = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 272 * widget.fem,
      child: TextFormField(
        obscureText: _isObscure,
        validator: widget.validator,
        controller: widget.textController,
        style: GoogleFonts.openSans(
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 15 * widget.ffem,
            fontWeight: FontWeight.w700,
          ),
        ),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
            icon: Icon(
              widget.isPassword
                  ? _isObscure
                      ? Icons.visibility
                      : Icons.visibility_off
                  : null,
            ),
          ),
          labelText: widget.labelText,
          hintText: widget.hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: GoogleFonts.openSans(
            textStyle: TextStyle(
              color: kPrimaryColor,
              fontSize: 15 * widget.ffem,
              fontWeight: FontWeight.w900,
            ),
          ),
          hintStyle: GoogleFonts.openSans(
            textStyle: TextStyle(
              color: kLowTextColor,
              fontSize: 15 * widget.ffem,
              fontWeight: FontWeight.w700,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 26 * widget.fem,
            vertical: 10 * widget.hem,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28 * widget.fem),
            borderSide: BorderSide(
              width: 2,
              color: const Color.fromARGB(255, 220, 220, 220),
            ),
            gapPadding: 10,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28 * widget.fem),
            borderSide: BorderSide(
              width: 2,
              color: const Color.fromARGB(255, 220, 220, 220),
            ),
            gapPadding: 10,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28 * widget.fem),
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
