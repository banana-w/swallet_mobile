import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/cubits/validation/validation_cubit.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_1_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_7_screen.dart';

import '../../../../../../../data/datasource/authen_local_datasource.dart';

import 'button_sign_up_5.dart';
import 'content_5.dart';
import 'textformfield_invited_code.dart';

class FormBody5 extends StatefulWidget {
  const FormBody5({
    super.key,
    required this.fem,
    required this.hem,
    required this.ffem,
  });

  final double fem;
  final double hem;
  final double ffem;

  @override
  State<FormBody5> createState() => _FormBody5State();
}

class _FormBody5State extends State<FormBody5> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          BlocBuilder<ValidationCubit, ValidationState>(
            builder: (context, state) {
              if (state is CheckInvitedCodeFailed) {
                return Container(
                  width: 318 * widget.fem,
                  height: 100 * widget.hem,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormFieldInviteCode(
                        hem: widget.hem,
                        fem: widget.fem,
                        ffem: widget.ffem,
                        labelText: 'MÃ GIỚI THIỆU',
                        hintText: 'Nhập mã giới thiệu...',
                        textController: codeController,
                      ),
                      SizedBox(height: 5 * widget.hem),
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
                    ],
                  ),
                );
              }
              return Content5(widget: widget, codeController: codeController);
            },
          ),
          SizedBox(height: 30 * widget.hem),
          BlocBuilder<ValidationCubit, ValidationState>(
            builder: (context, state) {
              return ButtonSignUp5(
                widget: widget,
                onPressed: () {
                  if (state is CheckInvitedCodeFailed) {
                    _submitForm(context, codeController);
                  } else {
                    _submitForm(context, codeController);
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

void _submitForm(BuildContext context, codeController) async {
  final authenModel = await AuthenLocalDataSource.getAuthen();
  if (authenModel == null) {
    context
        .read<ValidationCubit>()
        .validateInviteCode(codeController.text)
        .then((value) async {
          if (value == '') {
            final createAuthenModel =
                await AuthenLocalDataSource.getCreateAuthen();
            createAuthenModel!.inviteCode = codeController.text;
            String createAuthenString = jsonEncode(createAuthenModel);
            AuthenLocalDataSource.saveCreateAuthen(createAuthenString);
            Navigator.pushNamed(
              context,
              SignUp7Screen.routeName,
              arguments: SignUp1Screen.defaultRegister,
            );
          } else {
            return null;
          }
        });
  } else {
    context
        .read<ValidationCubit>()
        .validateInviteCode(codeController.text)
        .then((value) async {
          if (value == '') {
            final verifyAuthenModel =
                await AuthenLocalDataSource.getVerifyAuthen();
            verifyAuthenModel!.inviteCode = codeController.text;
            String verifyAuthenString = jsonEncode(verifyAuthenModel);
            AuthenLocalDataSource.saveVerifyAuthen(verifyAuthenString);
            Navigator.pushNamed(
              context,
              SignUp7Screen.routeName,
              arguments: SignUp1Screen.defaultRegister,
            );
          } else {
            return null;
          }
        });
  }
}
