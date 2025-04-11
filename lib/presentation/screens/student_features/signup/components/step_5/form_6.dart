import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_6_screen.dart';

import 'button_signup6.dart';
import 'upload_back_card.dart';
import 'upload_front_card.dart';

class FormBody6 extends StatefulWidget {
  const FormBody6({
    super.key,
    required this.fem,
    required this.hem,
    required this.ffem,
  });

  final double fem;
  final double hem;
  final double ffem;

  @override
  State<FormBody6> createState() => _FormBody6State();
}

class _FormBody6State extends State<FormBody6> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController campusController = TextEditingController();
  File? _selectedFrontCard;
  File? _selectedBackCard;
  String? errorCard;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
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
                            fit: BoxFit.fill,
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
                            _imageModelBottomSheet(context, _selectedFrontCard);
                          },
                        ),
                      ],
                    ),
                // SizedBox(
                //   width: 280 * widget.fem,
                //   child: Divider(
                //     thickness: 1 * widget.fem,
                //     color: const Color.fromARGB(255, 225, 223, 223),
                //   ),
                // ),
                // _selectedBackCard != null
                //     ? InkWell(
                //       onTap: () {
                //         _imageModelBottomSheet(context, _selectedBackCard);
                //       },
                //       child: Container(
                //         width: 150 * widget.fem,
                //         height: 150 * widget.hem,
                //         decoration: BoxDecoration(
                //           image: DecorationImage(
                //             fit: BoxFit.fill,
                //             image: FileImage(_selectedBackCard!),
                //           ),
                //         ),
                //       ),
                //     )
                //     : Column(
                //       children: [
                //         Text(
                //           'Tải hình mặt sau của thẻ',
                //           textAlign: TextAlign.center,
                //           style: GoogleFonts.openSans(
                //             textStyle: TextStyle(
                //               color: Colors.black,
                //               fontSize: 14 * widget.ffem,
                //               fontWeight: FontWeight.w700,
                //             ),
                //           ),
                //         ),
                //         SizedBox(height: 10 * widget.hem),
                //         UpLoadBackCard(
                //           fem: widget.fem,
                //           hem: widget.hem,
                //           ffem: widget.ffem,
                //           onPressed: () {
                //             _imageModelBottomSheet(context, _selectedBackCard);
                //           },
                //         ),
                //       ],
                //     ),
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
          ButtonSignUp6(
            fem: widget.fem,
            hem: widget.hem,
            ffem: widget.ffem,
            onPressed: () async {
              _submitForm(context, _selectedFrontCard, _selectedBackCard);
            },
          ),
        ],
      ),
    );
  }

  void _submitForm(
    BuildContext context,
    selectedFrontCard,
    selectedBackCard,
  ) async {
    final authenModel = await AuthenLocalDataSource.getAuthen();
    if (authenModel == null) {
      if (selectedFrontCard == null) {
        setState(() {
          errorCard = 'Thẻ sinh viên không được bỏ trống';
        });
      } else if (_formKey.currentState!.validate()) {
        final createAuthenModel = await AuthenLocalDataSource.getCreateAuthen();
        createAuthenModel!.studentFrontCard = selectedFrontCard!.path;
        // createAuthenModel.studentBackCard = _selectedBackCard!.path;
        String createAuthenString = jsonEncode(createAuthenModel);
        AuthenLocalDataSource.saveCreateAuthen(createAuthenString);
        Navigator.pushNamed(context, SignUp6Screen.routeName);
      }
    } 
    else {
      if (selectedFrontCard == null) {
        setState(() {
          errorCard = 'Thẻ sinh viên không được bỏ trống';
        });
      } else if (_formKey.currentState!.validate()) {
        final verifyAuthenModel = await AuthenLocalDataSource.getVerifyAuthen();
        verifyAuthenModel!.studentFrontCard = selectedFrontCard!.path;
        verifyAuthenModel.studentBackCard = selectedBackCard!.path;
        String verifyAuthenString = jsonEncode(verifyAuthenModel);
        AuthenLocalDataSource.saveVerifyAuthen(verifyAuthenString);
        Navigator.pushNamed(context, SignUp6Screen.routeName);
      }
    }
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
        return SizedBox(
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
