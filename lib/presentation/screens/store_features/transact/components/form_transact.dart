import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../config/constants.dart';
import 'text_form_field_default.dart';

class FormTransact extends StatefulWidget {
  const FormTransact(
      {super.key,
      required this.fem,
      required this.hem,
      required this.ffem,
      required this.beanController,
      required this.desController});

  final double fem;
  final double hem;
  final double ffem;
  final TextEditingController beanController;
  final TextEditingController desController;

  @override
  State<FormTransact> createState() => _FormTransactState();
}

class _FormTransactState extends State<FormTransact> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        width: 324 * widget.fem,
        height: 230 * widget.hem,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15 * widget.fem),
          color: Colors.white,
        ),
        padding: EdgeInsets.only(top: 15 * widget.hem, bottom: 15 * widget.fem),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormFieldDefault(
              autoFocus: true,
              hem: widget.hem,
              fem: widget.fem,
              ffem: widget.ffem,
              labelText: 'SỐ ĐẬU XANH',
              hintText: 'Nhập số đậu...',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Số đậu xanh không được bỏ trống';
                } else if (!numberRegExp.hasMatch(value)) {
                  return 'Số đậu xanh không hợp lệ!';
                }
                return null;
              },
              textController: widget.beanController,
            ),
            SizedBox(
              height: 15 * widget.hem,
            ),
            Container(
              width: 272 * widget.fem,
              height: 100 * widget.hem,
              // color: Colors.red,
              child: TextFormField(
                expands: true,
                maxLines: null,
                controller: widget.desController,
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15 * widget.ffem,
                        fontWeight: FontWeight.bold)),
                decoration: InputDecoration(
                  labelText: 'Lời nhắn',
                  hintText: 'Nhập lời nhắn...',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 15 * widget.ffem,
                        fontWeight: FontWeight.w900),
                  ),
                  hintStyle: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          color: kLowTextColor,
                          fontSize: 15 * widget.ffem,
                          fontWeight: FontWeight.w700)),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 26 * widget.fem, vertical: 10 * widget.hem),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10 * widget.fem),
                      borderSide: BorderSide(
                          width: 2,
                          color: const Color.fromARGB(255, 220, 220, 220)),
                      gapPadding: 10),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10 * widget.fem),
                      borderSide: BorderSide(
                          width: 2,
                          color: const Color.fromARGB(255, 220, 220, 220)),
                      gapPadding: 10),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10 * widget.fem),
                      borderSide: BorderSide(
                          width: 2,
                          color: const Color.fromARGB(255, 220, 220, 220)),
                      gapPadding: 10),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
