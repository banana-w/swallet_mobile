import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/student_features/create_model/create_authen_model.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/cubits/validation/validation_cubit.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/step/button_sign_up.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/step/content_form.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_1_screen.dart';
import 'package:swallet_mobile/presentation/widgets/text_form_field_default.dart';
import 'package:swallet_mobile/presentation/widgets/text_form_field_password.dart';

// import 'package:unibean_app/presentation/blocs/validation/validation_bloc.dart';

class FormBody extends StatefulWidget {
  const FormBody({
    super.key,
    required this.hem,
    required this.fem,
    required this.ffem,
  });

  final double hem;
  final double fem;
  final double ffem;

  @override
  State<FormBody> createState() => _FormBodyState();
}

class _FormBodyState extends State<FormBody> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            'Chúng tôi sẽ kết nối với\n tài khoản của bạn!',
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
          SizedBox(height: 30 * widget.hem),
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
                SizedBox(height: 20 * widget.hem),
                BlocBuilder<ValidationCubit, ValidationState>(
                  builder: (context, state) {
                    if (state is CheckUserNameFailed) {
                      return Column(
                        children: [
                          TextFormFieldDefault(
                            hem: widget.hem,
                            fem: widget.fem,
                            ffem: widget.ffem,
                            labelText: 'TÀI KHOẢN',
                            hintText: 'Nhập tài khoản...',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Tài khoản không được bỏ trống';
                              } else if (!userNamePattern.hasMatch(value)) {
                                return 'Tài khoản phải chứa ký tự thường \nhoặc số, có độ dài từ 5 đến 50 ký tự';
                              }
                              return null;
                            },
                            textController: userNameController,
                          ),
                          SizedBox(height: 3 * widget.hem),
                          Padding(
                            padding: EdgeInsets.only(right: 44 * widget.fem),
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
                          SizedBox(height: 25 * widget.hem),
                          TextFormFieldPassword(
                            hem: widget.hem,
                            fem: widget.fem,
                            ffem: widget.ffem,
                            labelText: 'MẬT KHẨU *',
                            hintText: 'Nhập mật khẩu...',
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Mật khẩu không được bỏ trống';
                              } else if (!passwordPattern.hasMatch(value)) {
                                return 'Mật khẩu phải chứa ít nhất tám ký tự, \nít nhất một số và cả chữ thường, \nchữ hoa và ký tự đặc biệt.';
                              }
                              return null;
                            },
                            textController: passController,
                          ),
                          SizedBox(height: 25 * widget.hem),
                          TextFormFieldPassword(
                            hem: widget.hem,
                            fem: widget.fem,
                            ffem: widget.ffem,
                            labelText: 'XÁC NHẬN MẬT KHẨU *',
                            hintText: 'Nhập xác nhận...',
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nhập lại mật khẩu không được bỏ trống';
                              } else if (value != passController.text) {
                                return 'Mật khẩu không khớp';
                              }
                              return null;
                            },
                            textController: confirmPassController,
                          ),
                        ],
                      );
                    }
                    return ContentForm(
                      widget: widget,
                      userNameController: userNameController,
                      passController: passController,
                      confirmPassController: confirmPassController,
                    );
                  },
                ),
                SizedBox(height: 20 * widget.hem),
              ],
            ),
          ),
          SizedBox(height: 20 * widget.hem),
          BlocBuilder<ValidationCubit, ValidationState>(
            builder: (context, state) {
              return ButtonSignUp(
                widget: widget,
                onPress: () {
                  if (state is CheckUserNameFailed) {
                    if (_formKey.currentState!.validate()) {
                      _submitForm(
                        context,
                        userNameController,
                        passController,
                        confirmPassController,
                      );
                    }
                  } else {
                    if (_formKey.currentState!.validate()) {
                      _submitForm(
                        context,
                        userNameController,
                        passController,
                        confirmPassController,
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
  TextEditingController userNameController,
  TextEditingController passController,
  confirmPassController,
) {
  context
      .read<ValidationCubit>()
      .validateUserName(userNameController.text)
      .then((value) {
        if (value == '') {
          CreateAuthenModel createAuthenModel = CreateAuthenModel(
            userName: userNameController.text.trim(),
            password: passController.text.trim(),
            passwordConfirmed: confirmPassController.text.trim(),
          );
          String createAuthenString = jsonEncode(createAuthenModel);
          AuthenLocalDataSource.saveCreateAuthen(createAuthenString);
          Navigator.pushNamed(
            context,
            SignUp1Screen.routeName,
            arguments: true,
          );
        } else {
          return null;
        }
      });
}
