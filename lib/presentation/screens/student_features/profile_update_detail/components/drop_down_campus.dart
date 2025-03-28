import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/models/student_features/campus_model.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

import '../../../../../../data/models.dart';

class DropDownCampus extends StatefulWidget {
  final double hem;
  final double fem;
  final double ffem;
  final String labelText;
  final String hintText;
  final TextEditingController campusController;
  final List<CampusModel> campuses;

  final FormFieldValidator<String> validator;
  final String campusId;

  const DropDownCampus({
    super.key,
    required this.hem,
    required this.fem,
    required this.ffem,
    required this.labelText,
    required this.hintText,
    required this.campusController,
    required this.validator,
    required this.campusId,
    required this.campuses,
  });

  @override
  State<DropDownCampus> createState() => _DropDownCampusState();
}

class _DropDownCampusState extends State<DropDownCampus> {
  String? initialValue;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 43 * widget.hem,
      width: 272 * widget.fem,
      child: _dropDownCampusLoaded(),
    );
  }

  DropdownButtonFormField<String> _dropDownCampusLoaded() {
    return DropdownButtonFormField(
      validator: widget.validator,
      style: GoogleFonts.openSans(
        textStyle: TextStyle(
          color: Colors.black,
          fontSize: 15 * widget.ffem,
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28 * widget.fem),
          borderSide: BorderSide(
            width: 2,
            color: const Color.fromARGB(255, 220, 220, 220),
          ),
          gapPadding: 10,
        ),
      ),
      value: widget.campuses.firstWhere((u) => u.id == widget.campusId).id,
      onChanged: (newValue) {
        setState(() {
          widget.campusController.text = newValue!;
        });
      },
      items:
          widget.campuses.map((u) {
            return DropdownMenuItem(
              value: u.id,
              child: Text(u.campusName.toString()),
            );
          }).toList(),
    );
  }
}
