import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/models/student_features/student_model.dart';
import 'package:swallet_mobile/presentation/widgets/shimmer_widget.dart';

import '../../../../../data/models.dart';
import '../../../../config/constants.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.studentModel});

  final StudentModel studentModel;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            Column(
              children: [
                SizedBox(height: 20 * hem),
                Text(
                  'Thông tin xác minh',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18 * ffem,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 20 * hem),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 15 * fem, right: 15 * fem),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          SizedBox(
                            width: 272 * fem,
                            // color: Colors.red,
                            child: TextFormField(
                              readOnly: true,
                              initialValue: studentModel.code,
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15 * ffem,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              decoration: InputDecoration(
                                labelText: 'MÃ SỐ SINH VIÊN',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelStyle: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 15 * ffem,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                hintStyle: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: kLowTextColor,
                                    fontSize: 15 * ffem,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 26 * fem,
                                  vertical: 10 * hem,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28 * fem),
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
                                  borderRadius: BorderRadius.circular(28 * fem),
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
                                  borderRadius: BorderRadius.circular(28 * fem),
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
                            ),
                          ),

                          SizedBox(height: 20), // Khoảng cách giữa các field
                          SizedBox(
                            width: 272 * fem,
                            child: TextFormField(
                              readOnly: true,
                              initialValue: studentModel.address,
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15 * ffem,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              decoration: InputDecoration(
                                labelText: 'EMAIL SINH VIÊN',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelStyle: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 15 * ffem,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                hintStyle: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: kLowTextColor,
                                    fontSize: 15 * ffem,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 26 * fem,
                                  vertical: 10 * hem,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28 * fem),
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
                                  borderRadius: BorderRadius.circular(28 * fem),
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
                                  borderRadius: BorderRadius.circular(28 * fem),
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
                            ),
                          ),

                          SizedBox(height: 20),
                          Text(
                            'MẶT TRƯỚC',
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                fontSize: 13 * ffem,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 10 * fem),
                          Container(
                            width: 300 * fem,
                            height: 300 * fem,
                            decoration: BoxDecoration(
                              border: Border.all(color: klightPrimaryColor),
                              borderRadius: BorderRadius.circular(15 * fem),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x0c000000),
                                  offset: Offset(0 * fem, 10 * fem),
                                  blurRadius: 5 * fem,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                height: 250,
                                width: double.infinity,
                                child: Image.network(
                                  studentModel.studentCardFront,
                                  fit: BoxFit.fill,
                                  loadingBuilder: (
                                    context,
                                    child,
                                    loadingProgress,
                                  ) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return ShimmerWidget.rectangular(
                                      height: 250 * hem,
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/ava_signup.png',
                                      width: 100 * fem,
                                      height: 100 * hem,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          // Text(
                          //   'MẶT SAU',
                          //   style: GoogleFonts.openSans(
                          //     textStyle: TextStyle(
                          //       fontSize: 13 * ffem,
                          //       fontWeight: FontWeight.bold,
                          //       color: kPrimaryColor,
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(height: 10 * fem),
                          // Container(
                          //   width: 300 * fem,
                          //   height: 300 * fem,
                          //   decoration: BoxDecoration(
                          //     border: Border.all(color: klightPrimaryColor),
                          //     borderRadius: BorderRadius.circular(15 * fem),
                          //     color: Colors.white,
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color: Color(0x0c000000),
                          //         offset: Offset(0 * fem, 10 * fem),
                          //         blurRadius: 5 * fem,
                          //       ),
                          //     ],
                          //   ),
                          //   child: ClipRRect(
                          //     borderRadius: BorderRadius.circular(10),
                          //     child: Container(
                          //       height: 250,
                          //       width: double.infinity,
                          //       child: Image.network(
                          //         '${studentModel.studentCardBack}',
                          //         fit: BoxFit.fill,
                          //         loadingBuilder: (
                          //           context,
                          //           child,
                          //           loadingProgress,
                          //         ) {
                          //           if (loadingProgress == null) {
                          //             return child;
                          //           }
                          //           return ShimmerWidget.rectangular(
                          //             height: 250 * hem,
                          //           );
                          //         },
                          //         errorBuilder: (context, error, stackTrace) {
                          //           return Image.asset(
                          //             'assets/images/ava_signup.png',
                          //             width: 100 * fem,
                          //             height: 100 * hem,
                          //           );
                          //         },
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ]),
        ),
      ],
    );
  }

  Widget checkVerification(
    StudentModel studentModel,
    double fem,
    double hem,
    double ffem,
  ) {
    if (studentModel.status && studentModel.state == 1) {
      return Container(
        padding: EdgeInsets.only(right: 5 * fem, left: 5 * fem),
        height: 30 * hem,
        width: 100 * fem,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Color(0xfffb7eb8f)),
          color: Color(0xffff6ffed),
        ),
        child: Center(
          child: Text(
            'Đã xác minh',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 13 * ffem,
                height: 1.3625 * ffem / fem,
                fontWeight: FontWeight.w600,
                color: kPrimaryColor,
              ),
            ),
          ),
        ),
      );
    } else if (studentModel.status && studentModel.state == 2) {
      return Container(
        padding: EdgeInsets.only(right: 5 * fem, left: 5 * fem),
        height: 30 * hem,
        width: 120 * fem,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Color(0xfffffe58f)),
          color: kbgYellow,
        ),
        child: Center(
          child: Text(
            'Đang chờ duyệt',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 13 * ffem,
                height: 1.3625 * ffem / fem,
                fontWeight: FontWeight.w600,
                color: kYellow,
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(right: 5 * fem, left: 5 * fem),
        height: 30 * hem,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Color(0xfffffe58f)),
          color: kbgYellow,
        ),
        child: Center(
          child: Text(
            'Xác minh thất bại',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 13 * ffem,
                height: 1.3625 * ffem / fem,
                fontWeight: FontWeight.w600,
                color: kYellow,
              ),
            ),
          ),
        ),
      );
    }
  }
}
