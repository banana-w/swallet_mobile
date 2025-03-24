import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

class BirthdayForm extends StatefulWidget {
  const BirthdayForm({
    super.key,
    required this.hem,
    required this.fem,
    required this.ffem,
    required this.validator,
    required this.controller,
  });

  final double hem;
  final double fem;
  final double ffem;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;

  @override
  State<BirthdayForm> createState() => _BirthdayFormState();
}

class _BirthdayFormState extends State<BirthdayForm> {
  DateTime? date = DateTime.now();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 272 * widget.fem,
      child: TextFormField(
        validator: widget.validator,
        style: GoogleFonts.openSans(
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 14 * widget.ffem,
            fontWeight: FontWeight.w700,
          ),
        ),
        keyboardType: TextInputType.number,
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: 'NGÀY SINH *',
          hintText: 'Chọn ngày sinh...',
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
        onTap: () async {
          date = DateTime(1900);
          date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          String formateDate = DateFormat('yyy-MM-dd').format(date!);
          widget.controller.text = formateDate;
        },
      ),
    );
  }
}
