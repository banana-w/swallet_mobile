import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/student_features/student_model.dart';
import 'package:swallet_mobile/presentation/blocs/student/student_bloc.dart';
import 'package:swallet_mobile/presentation/cubits/validation/validation_cubit.dart';

import '../../../../../data/models.dart';
import '../../../../config/constants.dart';
import '../../signup/components/step_5/upload_back_card.dart';
import '../../signup/components/step_5/upload_front_card.dart';
import 'text_form_field_default.dart';

class FormVerification extends StatefulWidget {
  const FormVerification({
    super.key,
    required this.hem,
    required this.fem,
    required this.ffem,
    required this.studentModel,
  });

  final double hem;
  final double fem;
  final double ffem;
  final StudentModel studentModel;

  @override
  State<FormVerification> createState() => _FormVerificationState();
}

class _FormVerificationState extends State<FormVerification> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController codeController = TextEditingController();
  File? _selectedFrontCard;
  File? _selectedBackCard;
  String? errorCard;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StudentBloc, StudentState>(
      listener: (context, state) {
        if (state is StudentUpdateVerificationSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                elevation: 0,
                duration: const Duration(milliseconds: 2000),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Xác minh thành công',
                  message: 'Xác minh sinh viên thành công!',
                  contentType: ContentType.success,
                ),
              ),
            );
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/landing-screen',
            (Route<dynamic> route) => false,
          );
        } else if (state is StudentFaled) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                elevation: 0,
                duration: const Duration(milliseconds: 2000),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Xác minh thất bại',
                  message: 'Vui lòng xác minh lại!',
                  contentType: ContentType.failure,
                ),
              ),
            );
          Navigator.pop(context);
        } else if (state is StudentUpdatingVerification) {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(Duration(seconds: 10));
              return AlertDialog(
                content: Container(
                  width: 250,
                  height: 250,
                  child: Center(
                    child: CircularProgressIndicator(color: kPrimaryColor),
                  ),
                ),
              );
            },
          );
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            BlocBuilder<ValidationCubit, ValidationState>(
              builder: (context, state) {
                if (state is CheckStudentCodeFailed) {
                  return Column(
                    children: [
                      Container(
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
                        child: Center(
                          child: TextFormFieldDefault(
                            hem: widget.hem,
                            fem: widget.fem,
                            ffem: widget.ffem,
                            labelText: 'MÃ SỐ SINH VIÊN *',
                            hintText: 'Nhập mã số sinh viên',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'MSSV không được bỏ trống';
                              }
                              return null;
                            },
                            textController: codeController,
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
                  child: Center(
                    child: TextFormFieldDefault(
                      hem: widget.hem,
                      fem: widget.fem,
                      ffem: widget.ffem,
                      labelText: 'MÃ SỐ SINH VIÊN *',
                      hintText: 'Nhập mã số sinh viên',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'MSSV không được bỏ trống';
                        }
                        return null;
                      },
                      textController: codeController,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 15 * widget.hem),
            Container(
              width: 318 * widget.fem,
              height: 400 * widget.hem,
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _selectedFrontCard != null
                      ? InkWell(
                        onTap: () {
                          _imageModelBottomSheet(context, _selectedFrontCard);
                        },
                        child: Container(
                          width: 150 * widget.fem,
                          height: 150 * widget.hem,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(_selectedFrontCard!),
                            ),
                          ),
                        ),
                      )
                      : Column(
                        children: [
                          Text(
                            'Tải hình mặt trước của thẻ',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14 * widget.ffem,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(height: 10 * widget.hem),
                          UpLoadFrontCard(
                            fem: widget.fem,
                            hem: widget.hem,
                            ffem: widget.ffem,
                            onPressed: () {
                              _imageModelBottomSheet(
                                context,
                                _selectedFrontCard,
                              );
                            },
                          ),
                        ],
                      ),
                  SizedBox(
                    width: 280 * widget.fem,
                    child: Divider(
                      thickness: 1 * widget.fem,
                      color: const Color.fromARGB(255, 225, 223, 223),
                    ),
                  ),
                  _selectedBackCard != null
                      ? InkWell(
                        onTap: () {
                          _imageModelBottomSheet(context, _selectedBackCard);
                        },
                        child: Container(
                          width: 150 * widget.fem,
                          height: 150 * widget.hem,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(_selectedBackCard!),
                            ),
                          ),
                        ),
                      )
                      : Column(
                        children: [
                          Text(
                            'Tải hình mặt sau của thẻ',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14 * widget.ffem,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(height: 10 * widget.hem),
                          UpLoadBackCard(
                            fem: widget.fem,
                            hem: widget.hem,
                            ffem: widget.ffem,
                            onPressed: () {
                              _imageModelBottomSheet(
                                context,
                                _selectedBackCard,
                              );
                            },
                          ),
                        ],
                      ),
                ],
              ),
            ),
            errorCard != null
                ? Padding(
                  padding: EdgeInsets.only(top: 5 * widget.hem),
                  child: SizedBox(
                    width: 270 * widget.fem,
                    child: Text(
                      errorCard.toString(),
                      style: GoogleFonts.openSans(
                        fontSize: 13 * widget.ffem,
                        fontWeight: FontWeight.normal,
                        color: Color(0xffba1c1c),
                      ),
                    ),
                  ),
                )
                : SizedBox(height: 5 * widget.hem),
            SizedBox(height: 15 * widget.hem),
            BlocBuilder<ValidationCubit, ValidationState>(
              builder: (context, state) {
                return TextButton(
                  onPressed: () async {
                    if (state is CheckStudentCodeFailed) {
                      if (_selectedBackCard == null ||
                          _selectedFrontCard == null) {
                        setState(() {
                          errorCard = 'Thẻ sinh viên không được bỏ trống';
                        });
                      } else if (_formKey.currentState!.validate()) {
                        _submitForm(
                          context,
                          _selectedFrontCard,
                          _selectedBackCard,
                          codeController,
                        );
                      }
                    } else {
                      if (_selectedBackCard == null ||
                          _selectedFrontCard == null) {
                        setState(() {
                          errorCard = 'Thẻ sinh viên không được bỏ trống';
                        });
                      } else if (_formKey.currentState!.validate()) {
                        _submitForm(
                          context,
                          _selectedFrontCard,
                          _selectedBackCard,
                          codeController,
                        );
                      }
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
                        'Xác minh',
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 17 * widget.ffem,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm(
    BuildContext context,
    _selectedFrontCard,
    _selectedBackCard,
    codeController,
  ) async {
    context
        .read<ValidationCubit>()
        .validateStudentCode(codeController.text)
        .then((value) async {
          if (value == '') {
            final studentModel = await AuthenLocalDataSource.getStudent();
            context.read<StudentBloc>().add(
              UpdateVerification(
                studentId: studentModel!.id,
                studentCode: codeController.text,
                studentCardFront: _selectedFrontCard!.path,
                studentCardBack: _selectedBackCard!.path,
              ),
            );
          } else {
            return null;
          }
        });
  }

  Future _pickerImageFromGallery(File? selectedImage, context) async {
    final returnedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (returnedImage == null) return;

    if (selectedImage.hashCode == _selectedFrontCard.hashCode) {
      selectedImage = File(returnedImage.path);

      setState(() {
        _selectedFrontCard = selectedImage;
      });
      Navigator.pop(context);
    } else {
      selectedImage = File(returnedImage.path);

      setState(() {
        _selectedBackCard = selectedImage;
      });
      Navigator.pop(context);
    }
  }

  Future _pickerImageFromCamera(File? selectedImage, context) async {
    final returnedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (returnedImage == null) return;

    if (selectedImage.hashCode == _selectedFrontCard.hashCode) {
      selectedImage = File(returnedImage.path);

      setState(() {
        _selectedFrontCard = selectedImage;
      });
      Navigator.pop(context);
    } else {
      selectedImage = File(returnedImage.path);

      setState(() {
        _selectedBackCard = selectedImage;
      });
      Navigator.pop(context);
    }
  }

  void _imageModelBottomSheet(context, File? selectedImage) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _pickerImageFromCamera(selectedImage, context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: kPrimaryColor,
                      size: 30 * fem,
                    ),
                    SizedBox(width: 5 * fem),
                    Text(
                      'Chụp ảnh',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 20 * ffem,
                          fontWeight: FontWeight.bold,
                          height: 1.3625 * ffem / fem,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18 * hem),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Divider(
                  color: kLowTextColor,
                  thickness: 2 * fem,
                  // height: 300*fem,
                ),
              ),
              SizedBox(height: 18 * hem),
              GestureDetector(
                onTap: () {
                  _pickerImageFromGallery(selectedImage, context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.photo_size_select_actual_rounded,
                      color: kPrimaryColor,
                      size: 30 * fem,
                    ),
                    SizedBox(width: 5 * fem),
                    Text(
                      'Chọn sẵn có',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 20 * ffem,
                          fontWeight: FontWeight.bold,
                          height: 1.3625 * ffem / fem,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
