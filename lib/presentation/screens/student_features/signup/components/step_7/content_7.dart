import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

import 'form_7.dart';
import 'phone_number_text_field.dart';

class Content7 extends StatelessWidget {
  const Content7({
    super.key,
    required this.widget,
    required this.countryController,
    required this.phoneNumberController,
  });

  final FormBody7 widget;
  final TextEditingController countryController;
  final TextEditingController phoneNumberController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 272 * widget.fem,
      height: 80 * widget.hem,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'SỐ ĐIỆN THOẠI *',
          // hintText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: GoogleFonts.openSans(
            textStyle: TextStyle(
              color: kPrimaryColor,
              fontSize: 15 * widget.ffem,
              fontWeight: FontWeight.w900,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 40,
              child: TextField(
                readOnly: true,
                controller: countryController,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 17 * widget.ffem,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            Text("|", style: TextStyle(fontSize: 33, color: Colors.black)),
            SizedBox(width: 10),
            Expanded(
              child: PhoneNumberTextField(
                fem: widget.fem,
                ffem: widget.ffem,
                hem: widget.hem,
                textController: phoneNumberController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Số điện thoại không được bỏ trống';
                  } else if (!phoneNumberPattern.hasMatch(value)) {
                    return 'Số điện thoại không hợp lệ';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
