import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/cubits/validation/validation_cubit.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/step_4/button_sign_up_4.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_1_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_5_screen.dart';
import 'package:swallet_mobile/presentation/widgets/text_form_field_default.dart';

import 'content_4.dart';

class FormBody4 extends StatefulWidget {
  const FormBody4({
    super.key,
    required this.fem,
    required this.hem,
    required this.ffem,
  });

  final double fem;
  final double hem;
  final double ffem;

  @override
  State<FormBody4> createState() => _FormBody4State();
}

class _FormBody4State extends State<FormBody4> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController studentCodeController = TextEditingController();
  TextEditingController majorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          BlocBuilder<ValidationCubit, ValidationState>(
            builder: (context, state) {
              if (state is CheckStudentCodeFailed) {
                return Container(
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
                      SizedBox(height: 40 * widget.hem),
                      TextFormFieldDefault(
                        hem: widget.hem,
                        fem: widget.fem,
                        ffem: widget.ffem,
                        labelText: 'MÃ SỐ SINH VIÊN *',
                        hintText: 'Nhập mã số sinh viên',
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().isEmpty) {
                            return 'MSSV không được bỏ trống';
                          }
                          return null;
                        },
                        textController: studentCodeController,
                      ),
                      SizedBox(height: 3 * widget.hem),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 48 * widget.fem),
                          child: Text(
                            state.error.toString(),
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                color: kErrorTextColor,
                                fontSize: 12 * widget.ffem,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20 * widget.hem),
                      // DropDownMajor(
                      //   hem: widget.hem,
                      //   fem: widget.fem,
                      //   ffem: widget.ffem,
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Chuyên ngành không được bỏ trống';
                      //     }
                      //     return null;
                      //   },
                      //   labelText: 'CHUYÊN NGÀNH *',
                      //   hintText: 'Chọn chuyên ngành',
                      //   majorController: majorController,
                      // ),
                      SizedBox(height: 40 * widget.hem),
                    ],
                  ),
                );
              }
              return Content4(
                widget: widget,
                studentCodeController: studentCodeController,
                majorController: majorController,
              );
            },
          ),
          SizedBox(height: 10 * widget.hem),
          BlocBuilder<ValidationCubit, ValidationState>(
            builder: (context, state) {
              return ButtonSignUp4(
                widget: widget,
                onPressed: () {
                  if (state is CheckStudentCodeFailed) {
                    if (_formKey.currentState!.validate()) {
                      _submitForm(
                        context,
                        studentCodeController,
                        majorController,
                      );
                    }
                  } else {
                    if (_formKey.currentState!.validate()) {
                      _submitForm(
                        context,
                        studentCodeController,
                        majorController,
                      );
                    }
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

void _submitForm(
  BuildContext context,
  studentCodeController,
  majorController,
) async {
  final authenModel = await AuthenLocalDataSource.getAuthen();
  if (authenModel == null) {
    context
        .read<ValidationCubit>()
        .validateStudentCode(studentCodeController.text)
        .then((value) async {
          if (value == '') {
            final createAuthenModel =
                await AuthenLocalDataSource.getCreateAuthen();
            createAuthenModel!.code = studentCodeController.text.trim();
            // createAuthenModel.majorId = majorController.text.trim();
            String createAuthenString = jsonEncode(createAuthenModel);
            AuthenLocalDataSource.saveCreateAuthen(createAuthenString);
            Navigator.pushNamed(
              context,
              SignUp5Screen.routeName,
              arguments: SignUp1Screen.defaultRegister,
            );
          } else {
            return null;
          }
        });
  } else {
    context
        .read<ValidationCubit>()
        .validateStudentCode(studentCodeController.text)
        .then((value) async {
          if (value == '') {
            final verifyAuthenModel =
                await AuthenLocalDataSource.getVerifyAuthen();
            verifyAuthenModel!.code = studentCodeController.text.trim();
            // verifyAuthenModel.majorId = majorController.text.trim();
            String verifyAuthenString = jsonEncode(verifyAuthenModel);
            AuthenLocalDataSource.saveVerifyAuthen(verifyAuthenString);
            Navigator.pushNamed(
              context,
              SignUp5Screen.routeName,
              arguments: SignUp1Screen.defaultRegister,
            );
          } else {
            return null;
          }
        });
  }
}
