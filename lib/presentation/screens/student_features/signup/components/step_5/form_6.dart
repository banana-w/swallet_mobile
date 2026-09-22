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
                        _imageModelBottomSheet(context);
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
                            _imageModelBottomSheet(context);
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
            onPressed: () => _submitForm(context, _selectedFrontCard),
          ),
        ],
      ),
    );
  }

  Future<void> _submitForm(
    BuildContext context,
    File? selectedFrontCard,
  ) async {
    if (selectedFrontCard == null) {
      setState(() => errorCard = 'Thẻ sinh viên không được bỏ trống');
      return;
    }
    if (!_formKey.currentState!.validate()) return;

    final authenModel = await AuthenLocalDataSource.getAuthen();
    if (!mounted) return;

    if (authenModel == null) {
      final createAuthenModel = await AuthenLocalDataSource.getCreateAuthen();
      // Trước đây dùng `!` trên dữ liệu đọc từ bộ nhớ cục bộ.
      if (createAuthenModel == null) return;
      createAuthenModel.studentFrontCard = selectedFrontCard.path;
      // Lưu là async, trước đây không await.
      await AuthenLocalDataSource.saveCreateAuthen(
        jsonEncode(createAuthenModel),
      );
    } else {
      final verifyAuthenModel = await AuthenLocalDataSource.getVerifyAuthen();
      if (verifyAuthenModel == null) return;
      verifyAuthenModel.studentFrontCard = selectedFrontCard.path;
      // Dòng `studentBackCard = selectedBackCard!.path` đã bị bỏ: phần chọn
      // ảnh mặt sau bị comment từ lâu nên biến đó luôn null — nhánh xác minh
      // lại chắc chắn ném lỗi null tại đây.
      await AuthenLocalDataSource.saveVerifyAuthen(
        jsonEncode(verifyAuthenModel),
      );
    }

    if (!mounted) return;
    Navigator.pushNamed(context, SignUp6Screen.routeName);
  }

  /// Chọn ảnh từ camera hoặc thư viện (trước đây là hai hàm giống hệt nhau,
  /// phân biệt ô ảnh bằng cách so hashCode của hai File?).
  Future<void> _pickImage(ImageSource source) async {
    final picked = await ImagePicker().pickImage(source: source);
    if (picked == null || !mounted) return;
    setState(() {
      _selectedFrontCard = File(picked.path);
      errorCard = null;
    });
    Navigator.pop(context);
  }

  void _imageModelBottomSheet(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final hem = size.height / 812;
    final ffem = fem * 0.97;

    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return SizedBox(
          height: size.height * 0.2,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SourceOption(
                icon: Icons.camera_alt,
                label: 'Chụp ảnh',
                fem: fem,
                ffem: ffem,
                onTap: () => _pickImage(ImageSource.camera),
              ),
              SizedBox(height: 18 * hem),
              SizedBox(
                width: size.width * 0.7,
                child: Divider(color: kLowTextColor, thickness: 2 * fem),
              ),
              SizedBox(height: 18 * hem),
              _SourceOption(
                icon: Icons.photo_size_select_actual_rounded,
                label: 'Chọn sẵn có',
                fem: fem,
                ffem: ffem,
                onTap: () => _pickImage(ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Một dòng lựa chọn nguồn ảnh trong bottom sheet.
class _SourceOption extends StatelessWidget {
  const _SourceOption({
    required this.icon,
    required this.label,
    required this.fem,
    required this.ffem,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final double fem;
  final double ffem;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: kPrimaryColor, size: 30 * fem),
          SizedBox(width: 5 * fem),
          Text(
            label,
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
    );
  }
}
