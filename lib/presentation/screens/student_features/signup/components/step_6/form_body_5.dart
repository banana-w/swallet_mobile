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
                // Hai nhánh if/else cũ chạy đúng cùng một đoạn lệnh.
                onPressed: () => _submitForm(context, codeController),
              );
            },
          ),
        ],
      ),
    );
  }
}

Future<void> _submitForm(
  BuildContext context,
  TextEditingController codeController,
) async {
  final inviteCode = codeController.text;
  final authenModel = await AuthenLocalDataSource.getAuthen();
  if (!context.mounted) return;

  // Hai nhánh cũ gọi cùng một hàm kiểm tra mã mời, chỉ khác bản nháp được ghi.
  final validationError = await context
      .read<ValidationCubit>()
      .validateInviteCode(inviteCode);
  if (!context.mounted || validationError != '') return;

  if (authenModel == null) {
    final createAuthenModel = await AuthenLocalDataSource.getCreateAuthen();
    // Trước đây dùng `!` trên dữ liệu đọc từ bộ nhớ cục bộ.
    if (createAuthenModel == null) return;
    createAuthenModel.inviteCode = inviteCode;
    // Lưu là async, trước đây không await.
    await AuthenLocalDataSource.saveCreateAuthen(jsonEncode(createAuthenModel));
  } else {
    final verifyAuthenModel = await AuthenLocalDataSource.getVerifyAuthen();
    if (verifyAuthenModel == null) return;
    verifyAuthenModel.inviteCode = inviteCode;
    await AuthenLocalDataSource.saveVerifyAuthen(jsonEncode(verifyAuthenModel));
  }

  if (!context.mounted) return;
  Navigator.pushNamed(
    context,
    SignUp7Screen.routeName,
    arguments: SignUp1Screen.defaultRegister,
  );
}
