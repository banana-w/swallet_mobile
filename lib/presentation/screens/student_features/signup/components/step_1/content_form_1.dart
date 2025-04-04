import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/step_1/form_1.dart';
import 'package:swallet_mobile/presentation/widgets/text_form_field_default.dart';

class ContentFrom1 extends StatefulWidget {
  const ContentFrom1({
    super.key,
    required this.widget,
    required this.emailController,
    required this.nameController,
  });

  final FormBody1 widget;
  final TextEditingController emailController;
  final TextEditingController nameController;

  @override
  State<ContentFrom1> createState() => _ContentFrom1State();
}

class _ContentFrom1State extends State<ContentFrom1> {
  bool readOnly = false;
  @override
  void initState() {
    super.initState();
    // _getAuthen();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40 * widget.widget.hem),
        SizedBox(
          width: 272 * widget.widget.fem,
          // color: Colors.red,
          child: TextFormField(
            readOnly: readOnly,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Gmail không được bỏ trống';
              } else if (!emailValidationRegExp.hasMatch(value)) {
                return 'Gmail không hợp lệ';
              }
              return null;
            },
            controller: widget.emailController,
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 15 * widget.widget.ffem,
                fontWeight: FontWeight.bold,
              ),
            ),
            decoration: InputDecoration(
              labelText: 'GMAIL *',
              hintText: 'Nhập gmail...',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: GoogleFonts.openSans(
                textStyle: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 15 * widget.widget.ffem,
                  fontWeight: FontWeight.w900,
                ),
              ),
              hintStyle: GoogleFonts.openSans(
                textStyle: TextStyle(
                  color: kLowTextColor,
                  fontSize: 15 * widget.widget.ffem,
                  fontWeight: FontWeight.w700,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 26 * widget.widget.fem,
                vertical: 10 * widget.widget.fem,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28 * widget.widget.fem),
                borderSide: BorderSide(
                  width: 2,
                  color: const Color.fromARGB(255, 220, 220, 220),
                ),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28 * widget.widget.fem),
                borderSide: BorderSide(
                  width: 2,
                  color: const Color.fromARGB(255, 220, 220, 220),
                ),
                gapPadding: 10,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28 * widget.widget.fem),
                borderSide: BorderSide(
                  width: 2,
                  color: const Color.fromARGB(255, 220, 220, 220),
                ),
                gapPadding: 10,
              ),
            ),
          ),
        ),
        SizedBox(height: 25 * widget.widget.hem),
        TextFormFieldDefault(
          hem: widget.widget.hem,
          fem: widget.widget.fem,
          ffem: widget.widget.ffem,
          labelText: 'HỌ VÀ TÊN *',
          hintText: 'Nhập họ và tên...',
          validator: (value) {
            if (value == null || value.isEmpty || value.trim().isEmpty) {
              return 'Họ và tên không được bỏ trống';
            } else if (value.length < 3) {
              return 'Họ và tên ít nhất 3 kí tự';
            } else if (value.length > 50) {
              return 'Họ và tên tối đa 50 kí tự';
            } else if (!vietNameseTextOnlyPattern.hasMatch(value)) {
              return 'Họ và tên không hợp lệ';
            }
            return null;
          },
          textController: widget.nameController,
        ),
        SizedBox(height: 40 * widget.widget.hem),
      ],
    );
  }

  // Future<String> _getAuthen() async {
  //   final authen = await AuthenLocalDataSource.getAuthen();

  //   if (authen == null) return "";

  //   setState(() {
  //     widget.emailController.text = authen.accountId;
  //     readOnly = true;
  //   });
  //   return authen.accountId;
  // }
}
