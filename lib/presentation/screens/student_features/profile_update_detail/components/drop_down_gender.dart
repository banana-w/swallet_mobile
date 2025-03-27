import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/models/student_features/gender_model.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

class DropDownGender extends StatefulWidget {
  final double hem;
  final double fem;
  final double ffem;
  final String labelText;
  final String hintText;
  final TextEditingController genderController;
  final String genderName;
  final FormFieldValidator<String> validator;
  const DropDownGender({
    super.key,
    required this.hem,
    required this.fem,
    required this.ffem,
    required this.labelText,
    required this.hintText,
    required this.genderController,
    required this.genderName,
    required this.validator,
  });

  @override
  State<DropDownGender> createState() => _DropDownGenderState();
}

class _DropDownGenderState extends State<DropDownGender> {
  String? gender;

  @override
  void initState() {
    if (widget.genderName == 'Female') {
      gender = 'Nữ';
    } else {
      gender = 'Nam';
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 272 * widget.fem,
      child: DropdownButtonFormField(
        style: GoogleFonts.openSans(
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 14 * widget.ffem,
            fontWeight: FontWeight.w700,
          ),
        ),
        decoration: InputDecoration(
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
        ),
        value: GenderModel.genders.firstWhere((g) => g.name == gender).id,
        onChanged: (newValue) {
          setState(() {
            widget.genderController.text = newValue.toString();
          });
        },
        items:
            GenderModel.genders.map((g) {
              return DropdownMenuItem(
                child: Text(g.name.toString()),
                value: g.id,
              );
            }).toList(),
      ),
    );
  }
}
