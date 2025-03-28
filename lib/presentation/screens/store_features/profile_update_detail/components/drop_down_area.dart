import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/models/store_features/area_model.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

import '../../../../../../data/models.dart';

class DropDownArea extends StatefulWidget {
  final double hem;
  final double fem;
  final double ffem;
  final String labelText;
  final String hintText;
  final TextEditingController areaController;
  final List<AreaModel> areas;

  final FormFieldValidator<String> validator;
  final String areaId;

  const DropDownArea({
    super.key,
    required this.hem,
    required this.fem,
    required this.ffem,
    required this.labelText,
    required this.hintText,
    required this.areaController,
    required this.validator,
    required this.areaId,
    required this.areas,
  });

  @override
  State<DropDownArea> createState() => _DropDownAreaState();
}

class _DropDownAreaState extends State<DropDownArea> {
  String? initialValue;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 43 * widget.hem,
      width: 272 * widget.fem,
      child: _dropDownAreaLoaded(),
    );
  }

  DropdownButtonFormField<String> _dropDownAreaLoaded() {
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
      value: widget.areas.firstWhere((u) => u.id == widget.areaId).id,
      onChanged: (newValue) {
        setState(() {
          widget.areaController.text = newValue!;
        });
      },
      items:
          widget.areas.map((u) {
            return DropdownMenuItem(
              child: Text(u.areaName.toString()),
              value: u.id,
            );
          }).toList(),
    );
  }
}
