import 'dart:io';

import 'package:flutter/material.dart';
import 'form_1.dart';

// import '../../../screens.dart';

class Body1 extends StatefulWidget {
  const Body1({super.key});

  @override
  State<Body1> createState() => _BodyState();
}

class _BodyState extends State<Body1> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/bg_signup_1.png'),
                )),
                child: Column(
                  children: [
                    SizedBox(
                      height: 100 * hem,
                    ),
                    _selectedImage != null
                        ? Container(
                            margin: EdgeInsets.only(bottom: 30 * hem),
                            width: 180 * fem,
                            height: 180 * hem,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(_selectedImage!))),
                          )
                        : Container(
                            width: 210 * fem,
                            height: 210 * fem,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/ava_signup.png'))),
                          ),
                    SizedBox(
                      height: 10 * hem,
                    ),
                    FormBody1(
                      ffem: ffem,
                      fem: fem,
                      hem: hem,
                      avatar: _selectedImage,
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     // _pickerImageFromGallery();
                    //     _imageModelBottomSheet(context);
                    //   },
                    //   child: Padding(
                    //     padding: EdgeInsets.only(left: 2 * fem, bottom: 20 * hem),
                    //     child: Text(
                    //       'Thêm hình cá nhân',
                    //       style: GoogleFonts.openSans(
                    //           textStyle: TextStyle(
                    //               fontSize: 13 * ffem,
                    //               fontWeight: FontWeight.w900,
                    //               height: 1.3625 * ffem / fem,
                    //               color: kPrimaryColor)),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
