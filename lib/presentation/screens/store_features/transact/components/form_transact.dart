import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/constants.dart';
import 'text_form_field_default.dart';

class FormTransact extends StatelessWidget {
  const FormTransact({
    super.key,
    required this.fem,
    required this.hem,
    required this.ffem,
    required this.beanController,
    required this.desController,
  });

  final double fem;
  final double hem;
  final double ffem;
  final TextEditingController beanController;
  final TextEditingController desController;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10 * fem),
      borderSide: const BorderSide(
        width: 2,
        color: Color.fromARGB(255, 220, 220, 220),
      ),
      gapPadding: 10,
    );

    return Container(
      width: 324 * fem,
      height: 230 * hem,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15 * fem),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(top: 15 * hem, bottom: 15 * fem),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormFieldDefault(
            autoFocus: true,
            hem: hem,
            fem: fem,
            ffem: ffem,
            labelText: 'SỐ ĐẬU XANH',
            hintText: 'Nhập số đậu...',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Số đậu xanh không được bỏ trống';
              }
              if (!numberRegExp.hasMatch(value)) {
                return 'Số đậu xanh không hợp lệ!';
              }
              return null;
            },
            textController: beanController,
          ),
          SizedBox(height: 15 * hem),
          SizedBox(
            width: 272 * fem,
            height: 100 * hem,
            child: TextFormField(
              expands: true,
              maxLines: null,
              controller: desController,
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 15 * ffem,
                  fontWeight: FontWeight.bold,
                ),
              ),
              decoration: InputDecoration(
                labelText: 'Lời nhắn',
                hintText: 'Nhập lời nhắn...',
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
                enabledBorder: border,
                focusedBorder: border,
                errorBorder: border,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
