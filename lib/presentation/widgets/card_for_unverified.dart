import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/screens/student_features/profile_verification/update_verification_screen.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

class CardForUnVerified extends StatelessWidget {
  const CardForUnVerified({
    super.key,
    required this.fem,
    required this.hem,
    required this.ffem,
  });

  final double fem;
  final double hem;
  final double ffem;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 324 * fem,
        height: 200 * hem,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15 * fem),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: kLowTextColor,
              offset: Offset(0 * fem, 0 * fem),
              blurRadius: 1 * fem,
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(height: 15 * hem),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Bắt đầu',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 13 * ffem,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  'Đăng nhập',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 13 * ffem,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  'Xác minh',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      color: kLowTextColor,
                      fontSize: 13 * ffem,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              // color: Colors.red,
              height: 40 * hem,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TimelineTile(
                    axis: TimelineAxis.horizontal,
                    isFirst: true,
                    indicatorStyle: IndicatorStyle(
                      // color: kPrimaryColor,
                      width: 30 * fem,
                      height: 30 * hem,
                      indicator: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100 * fem),
                          color: const Color.fromARGB(255, 178, 247, 180),
                        ),
                        child: Icon(
                          Icons.check_rounded,
                          color: kPrimaryColor,
                          size: 25 * fem,
                        ),
                      ),
                    ),
                    afterLineStyle: LineStyle(color: kPrimaryColor),
                  ),
                  TimelineTile(
                    axis: TimelineAxis.horizontal,
                    indicatorStyle: IndicatorStyle(
                      // color: kPrimaryColor,
                      width: 30 * fem,
                      height: 30 * hem,
                      indicator: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100 * fem),
                          color: const Color.fromARGB(255, 178, 247, 180),
                        ),
                        child: Icon(
                          Icons.check_rounded,
                          color: kPrimaryColor,
                          size: 25 * fem,
                        ),
                      ),
                    ),
                    beforeLineStyle: LineStyle(color: kPrimaryColor),
                  ),
                  TimelineTile(
                    axis: TimelineAxis.horizontal,
                    isLast: true,
                    indicatorStyle: IndicatorStyle(
                      // color: kPrimaryColor,
                      width: 30 * fem,
                      height: 30 * hem,
                      indicator: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100 * fem),
                          color: klighGreyColor,
                        ),
                        child: Center(
                          child: Text(
                            '3',
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                color: kLowTextColor,
                                fontSize: 16 * ffem,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    beforeLineStyle: LineStyle(color: klighGreyColor),
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
              padding: EdgeInsets.only(top: 5 * hem),
              child: Text(
                'Xác minh tài khoản \nđể có thể nhận nhiều ưu đãi',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                // Navigator.pushNamed(
                //   context,
                //   SignUp1Screen.routeName,
                //   arguments: false,
                // );
                final roleAppstate = context.read<RoleAppBloc>().state;
                if (roleAppstate is Unverified) {
                  Navigator.pushNamed(
                    context,
                    UpdateVerificationScreen.routeName,
                    arguments: roleAppstate.studentModel,
                  );
                }
              },
              child: Container(
                width: 120 * fem,
                height: 40 * hem,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(23 * fem),
                ),
                child: Center(
                  child: Text(
                    'Xác minh',
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontSize: 14 * ffem,
                        fontWeight: FontWeight.w600,
                        height: 1.3625 * ffem / fem,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
