import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/cubits/validation/validation_cubit.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_9_screen.dart';
import 'button_sign_up_7.dart';
import 'content_7.dart';
import 'phone_number_text_field.dart';

class FormBody7 extends StatefulWidget {
  const FormBody7({
    super.key,
    required this.fem,
    required this.hem,
    required this.ffem,
  });

  final double fem;
  final double hem;
  final double ffem;

  @override
  State<FormBody7> createState() => _FormBody7State();
}

class _FormBody7State extends State<FormBody7> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  String? errorString;

  @override
  void initState() {
    countryController.text = "+84";
    super.initState();
  }

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
                BlocBuilder<ValidationCubit, ValidationState>(
                  builder: (context, state) {
                    if (state is CheckPhoneFailed) {
                      return Column(
                        children: [
                          SizedBox(
                            width: 272 * widget.fem,
                            height: 80 * widget.hem,
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'SỐ ĐIỆN THOẠI *',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelStyle: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 15 * widget.ffem,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 26 * widget.fem,
                                  vertical: 10 * widget.hem,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    28 * widget.fem,
                                  ),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: const Color.fromARGB(
                                      255,
                                      220,
                                      220,
                                      220,
                                    ),
                                  ),
                                  gapPadding: 10,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    28 * widget.fem,
                                  ),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: const Color.fromARGB(
                                      255,
                                      220,
                                      220,
                                      220,
                                    ),
                                  ),
                                  gapPadding: 10,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    28 * widget.fem,
                                  ),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: const Color.fromARGB(
                                      255,
                                      220,
                                      220,
                                      220,
                                    ),
                                  ),
                                  gapPadding: 10,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 40,
                                    child: TextField(
                                      readOnly: true,
                                      controller: countryController,
                                      style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17 * widget.ffem,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "|",
                                    style: TextStyle(
                                      fontSize: 33,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: PhoneNumberTextField(
                                      fem: widget.fem,
                                      ffem: widget.ffem,
                                      hem: widget.hem,
                                      textController: phoneNumberController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Số điện thoại không được bỏ trống';
                                        } else if (!phoneNumberPattern.hasMatch(
                                          value,
                                        )) {
                                          return 'Số điện thoại không hợp lệ';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
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
                        ],
                      );
                    }
                    return Content7(
                      widget: widget,
                      countryController: countryController,
                      phoneNumberController: phoneNumberController,
                    );
                  },
                ),
                errorString != null
                    ? Padding(
                      padding: EdgeInsets.only(
                        top: 2 * widget.hem,
                        left: 45 * widget.fem,
                      ),
                      child: SizedBox(
                        width: 270 * widget.fem,
                        child: Text(
                          errorString.toString(),
                          style: GoogleFonts.openSans(
                            fontSize: 12 * widget.ffem,
                            fontWeight: FontWeight.normal,
                            height: 1.3625 * widget.ffem / widget.fem,
                            color: kErrorTextColor,
                          ),
                        ),
                      ),
                    )
                    : SizedBox(height: 5 * widget.hem),
                SizedBox(height: 20 * widget.hem),
              ],
            ),
          ),
          SizedBox(height: 30 * widget.hem),
          BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationSuccess) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  SignUp9Screen.routeName,
                  (Route<dynamic> route) => false,
                );
              } else if (state is AuthenticationInProcess) {
                showDialog<String>(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    Future.delayed(Duration(seconds: 20), () {
                      if(context.mounted) {
                        Navigator.pop(context);
                      }
                    });
                    return AlertDialog(
                      content: SizedBox(
                        width: 250,
                        height: 250,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: CircularProgressIndicator(
                                color: kPrimaryColor,
                              ),
                            ),
                            Text(
                              'Đang tạo tài khoản...',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
            child: BlocBuilder<ValidationCubit, ValidationState>(
              builder: (context, state) {
                return ButtonSignUp7(
                  widget: widget,
                  onPressed: () {
                    if (state is CheckPhoneFailed) {
                      if (_formKey.currentState!.validate()) {
                        _submitForm(
                          context,
                          countryController,
                          phoneNumberController,
                        );
                      }
                    } else {
                      if (_formKey.currentState!.validate()) {
                        _submitForm(
                          context,
                          countryController,
                          phoneNumberController,
                        );
                      }
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _submitForm(
    BuildContext context,
    countryController,
    phoneNumberController,
  ) async {
      if (context.mounted) {
        context
            .read<ValidationCubit>()
            .validatePhoneNumber('0${phoneNumberController.text}')
            .then((value) async {
              if (value == '') {
                // Lưu số điện thoại
                final createAuthenModel =
                    await AuthenLocalDataSource.getCreateAuthen();
                createAuthenModel!.phoneNumber =
                    '0${phoneNumberController.text}';
                    
                String createAuthenString = jsonEncode(createAuthenModel);
                // AuthenLocalDataSource.saveCreateAuthen(createAuthenString);

                if (context.mounted) {
                  context.read<AuthenticationBloc>().add(
                    RegisterAccount(createAuthenModel: createAuthenModel),
                  );
                }
              } else {
                if (value == '["Số điện thoại không hợp lệ"]') {
                  setState(() {
                    errorString = 'Số điện thoại không hợp lệ';
                  });
                }
              }
            });
      }
     
  }
}
