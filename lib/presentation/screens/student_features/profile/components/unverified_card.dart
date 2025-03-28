import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/models/authen_model.dart';
import 'package:swallet_mobile/data/models/student_features/student_model.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/student_features/profile/components/name_profile.dart';
import 'package:swallet_mobile/presentation/screens/student_features/profile_verification/profile_verification_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/profile_verification/update_verification_screen.dart';
import 'package:swallet_mobile/presentation/widgets/unverified_screen.dart';

class UnverifiedCard extends StatelessWidget {
  const UnverifiedCard({
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
  Widget build(BuildContext context) {
    return Positioned(
      top: 80 * hem,
      left: 25 * fem,
      child: Container(
        width: 324 * fem,
        height: 180 * hem,
        decoration: BoxDecoration(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10 * hem),
            Container(
              padding: EdgeInsets.only(left: 15 * fem, right: 15 * fem),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //avatar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100 * fem),
                    child: SizedBox(
                      width: 80 * hem,
                      height: 80 * fem,
                      child: Image(
                        image: NetworkImage(studentModel.studentCardFront),
                        fit: BoxFit.fill,
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

                  SizedBox(width: 20 * fem),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Name
                      NameProfile(
                        fem: fem,
                        ffem: ffem,
                        hem: hem,
                        name: studentModel.fullName, //email
                      ),

                      //student code
                      Padding(
                        padding: EdgeInsets.only(
                          top: 10 * hem,
                          bottom: 5 * hem,
                        ),
                        child: Container(
                          padding: EdgeInsets.only(
                            right: 5 * fem,
                            left: 5 * fem,
                          ),
                          height: 30 * hem,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Color(0xfffffe58f)),
                            color: kbgYellow,
                          ),
                          child: Center(
                            child: Text(
                              'Chưa xác minh',
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
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 280 * fem,
              child: Divider(
                thickness: 1 * fem,
                color: const Color.fromARGB(255, 225, 223, 223),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10 * hem),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, UnverifiedScreen.routeName);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 5 * fem, right: 5 * fem),
                      width: 120 * fem,
                      height: 40 * hem,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[100],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: SvgPicture.asset(
                              'assets/icons/qr-unbean-icon.svg',
                              colorFilter: ColorFilter.mode(
                                kPrimaryColor,
                                BlendMode.srcIn,
                              ),
                              height: 18 * fem,
                              width: 18 * fem,
                            ),
                          ),
                          SizedBox(width: 5 * fem),
                          Text(
                            'Trang cá nhân',
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                fontSize: 11 * fem,
                                fontWeight: FontWeight.bold,
                                height: 1.3625 * ffem / fem,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.pushNamed(
                      //   context,
                      //   SignUp1Screen.routeName,
                      //   arguments: false,
                      // );
                      Navigator.pushNamed(
                        context,
                        UpdateVerificationScreen.routeName,
                        arguments: studentModel,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 5 * fem, right: 5 * fem),
                      width: 140 * fem,
                      height: 40 * hem,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[100],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: SvgPicture.asset(
                              'assets/icons/verifi-icon.svg',
                              colorFilter: ColorFilter.mode(
                                kPrimaryColor,
                                BlendMode.srcIn,
                              ),
                              height: 25 * fem,
                              width: 25 * fem,
                            ),
                          ),
                          SizedBox(width: 5 * fem),
                          Text(
                            'Xác minh',
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                fontSize: 12 * fem,
                                fontWeight: FontWeight.bold,
                                height: 1.3625 * ffem / fem,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
