import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/step_2/birthday_form.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/step_2/drop_down_gender.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_3_screen.dart';

import '../../../../../../../data/datasource/authen_local_datasource.dart';

class FormBody3 extends StatefulWidget {
  const FormBody3({
    super.key,
    required this.fem,
    required this.hem,
    required this.ffem,
    required this.dobController,
  });

  final double fem;
  final double hem;
  final double ffem;
  final TextEditingController dobController;

  @override
  State<FormBody3> createState() => _FormBody3State();
}

class _FormBody3State extends State<FormBody3> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController genderController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            width: 318 * widget.fem,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15 * widget.fem),
              boxShadow: [
                BoxShadow(
                  color: Color(0x0c000000),
                  offset: Offset(0 * widget.fem, 4 * widget.fem),
                  blurRadius: 2.5 * widget.fem,
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(height: 25 * widget.hem),
                DropDownGender(
                  fem: widget.fem,
                  hem: widget.hem,
                  ffem: widget.ffem,
                  hintText: 'Chọn giới tính',
                  labelText: 'GIỚI TÍNH *',
                  genderController: genderController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Giới tính không được bỏ trống';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20 * widget.hem),
                BirthdayForm(
                  hem: widget.hem,
                  fem: widget.fem,
                  ffem: widget.ffem,
                  controller: widget.dobController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ngày sinh không được bỏ trống';
                    } else {
                      DateTime? dateValue = DateTime.parse(value.toString());
                      DateTime currentDate = DateTime.now();
                      int? age = currentDate.year - dateValue.year;
                      if (age < 18 || age >= 40) {
                        return 'Độ tuổi không hợp lệ';
                      }
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20 * widget.hem),
              ],
            ),
          ),
          SizedBox(height: 20 * widget.hem),
          TextButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _submitForm(context, genderController);
              }
            },
            child: Container(
              width: 220 * widget.fem,
              height: 45 * widget.hem,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(23 * widget.fem),
              ),
              child: Center(
                child: Text(
                  'Tiếp tục',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: 17 * widget.ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.3625 * widget.ffem / widget.fem,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submitForm(
    BuildContext context,
    TextEditingController genderController,
  ) async {
    final gender = int.parse(genderController.text.trim());
    final dateOfBirth = widget.dobController.text.trim();
    final authenModel = await AuthenLocalDataSource.getAuthen();
    if (!mounted) return;

    if (authenModel == null) {
      final createAuthenModel = await AuthenLocalDataSource.getCreateAuthen();
      // Trước đây dùng `!` trên dữ liệu đọc từ bộ nhớ cục bộ.
      if (createAuthenModel == null) return;
      createAuthenModel.gender = gender;
      createAuthenModel.dateofBirth = dateOfBirth;
      // Lưu là async, trước đây không await nên có thể sang bước sau trước
      // khi dữ liệu kịp ghi.
      await AuthenLocalDataSource.saveCreateAuthen(
        jsonEncode(createAuthenModel),
      );
    } else {
      final verifyAuthenModel = await AuthenLocalDataSource.getVerifyAuthen();
      if (verifyAuthenModel == null) return;
      verifyAuthenModel.gender = gender;
      verifyAuthenModel.dateofBirth = dateOfBirth;
      await AuthenLocalDataSource.saveVerifyAuthen(
        jsonEncode(verifyAuthenModel),
      );
    }

    if (!mounted) return;
    Navigator.pushNamed(context, SignUp3Screen.routeName);
  }
}
