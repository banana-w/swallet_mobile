import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/student_features/verify_authen_model.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/cubits/validation/validation_cubit.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/step_1/button_sign_up_1.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/step_1/content_form_1.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_1_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_2_screen.dart';
import 'package:swallet_mobile/presentation/widgets/text_form_field_default.dart';

class FormBody1 extends StatefulWidget {
  const FormBody1({
    super.key,
    required this.ffem,
    required this.fem,
    required this.hem,
    required this.avatar,
  });

  final double ffem;
  final double fem;
  final double hem;
  final File? avatar;

  @override
  State<FormBody1> createState() => _FormBody1State();
}

class _FormBody1State extends State<FormBody1> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  // var box = Hive.box('myBox');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            'Chúng tôi sẽ kết nối với\n Gmail của bạn!',
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 20 * widget.ffem,
                fontWeight: FontWeight.w900,
                height: 1.3625 * widget.ffem / widget.fem,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 20 * widget.hem),
          Text(
            'Hãy kiểm tra thông tin thật cẩn thận',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 15 * widget.ffem,
                fontWeight: FontWeight.w600,
                height: 1.3625 * widget.ffem / widget.fem,
                color: kLowTextColor,
              ),
            ),
          ),
          SizedBox(height: 40 * widget.hem),
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
            child: BlocBuilder<ValidationCubit, ValidationState>(
              builder: (context, state) {
                if (state is CheckEmailFailed) {
                  return Column(
                    children: [
                      SizedBox(height: 40 * widget.hem),
                      Container(
                        width: 272 * widget.fem,
                        // color: Colors.red,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Gmail không được bỏ trống';
                            } else if (!emailValidationRegExp.hasMatch(value)) {
                              return 'Gmail không hợp lệ';
                            }
                            return null;
                          },
                          controller: emailController,
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 15 * widget.ffem,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          decoration: InputDecoration(
                            labelText: 'Gmail *',
                            hintText: 'Nhập Gmail...',
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
                              vertical: 10 * widget.fem,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                28 * widget.fem,
                              ),
                              borderSide: BorderSide(
                                width: 2,
                                color: const Color.fromARGB(255, 220, 220, 220),
                              ),
                              gapPadding: 10,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                28 * widget.fem,
                              ),
                              borderSide: BorderSide(
                                width: 2,
                                color: const Color.fromARGB(255, 220, 220, 220),
                              ),
                              gapPadding: 10,
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                28 * widget.fem,
                              ),
                              borderSide: BorderSide(
                                width: 2,
                                color: const Color.fromARGB(255, 220, 220, 220),
                              ),
                              gapPadding: 10,
                            ),
                          ),
                        ),
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
                      SizedBox(height: 25 * widget.hem),
                      TextFormFieldDefault(
                        hem: widget.hem,
                        fem: widget.fem,
                        ffem: widget.ffem,
                        labelText: 'HỌ VÀ TÊN *',
                        hintText: 'Nhập họ và tên...',
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().isEmpty) {
                            return 'Họ và tên không được bỏ trống';
                          } else if (value.length < 3) {
                            return 'Họ và tên ít nhất 3 kí tự';
                          } else if (value.length > 50) {
                            return 'Họ và tên tối đa 50 kí tự';
                          } else if (!vietNameseTextOnlyPattern.hasMatch(
                            value,
                          )) {
                            return 'Họ và tên không hợp lệ';
                          }
                          return null;
                        },
                        textController: nameController,
                      ),
                      SizedBox(height: 40 * widget.hem),
                    ],
                  );
                }
                return ContentFrom1(
                  widget: widget,
                  emailController: emailController,
                  nameController: nameController,
                );
              },
            ),
          ),
          SizedBox(height: 20 * widget.hem),
          BlocBuilder<ValidationCubit, ValidationState>(
            builder: (context, state) {
              return ButtonSignUp1(
                widget: widget,
                onPress: () {
                  if (state is CheckEmailFailed) {
                    if (_formKey.currentState!.validate()) {
                      _submitForm(context, emailController, nameController);
                    }
                  } else {
                    if (_formKey.currentState!.validate()) {
                      _submitForm(context, emailController, nameController);
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

void _submitForm(BuildContext context, emailController, nameController) async {
  final authenModel = await AuthenLocalDataSource.getAuthen();
  if (authenModel == null) {
    context.read<ValidationCubit>().validateEmail(emailController.text).then((
      value,
    ) async {
      if (value == '') {
        final createAuthenModel = await AuthenLocalDataSource.getCreateAuthen();
        createAuthenModel!.email = emailController.text.trim();
        createAuthenModel.fullName = nameController.text.trim();
        String createAuthenString = jsonEncode(createAuthenModel);
        AuthenLocalDataSource.saveCreateAuthen(createAuthenString);
        Navigator.pushNamed(
          context,
          SignUp2Screen.routeName,
          arguments: SignUp1Screen.defaultRegister,
        );
      } else {
        return null;
      }
    });
  } else {
    VerifyAuthenModel verifyAuthenModel = VerifyAuthenModel(
      email: emailController.text.trim(),
      fullName: nameController.text.trim(),
    );
    String verifyAuthenString = jsonEncode(verifyAuthenModel);
    AuthenLocalDataSource.saveVerifyAuthen(verifyAuthenString);
    Navigator.pushNamed(
      context,
      SignUp2Screen.routeName,
      arguments: SignUp1Screen.defaultRegister,
    );
  }
}
