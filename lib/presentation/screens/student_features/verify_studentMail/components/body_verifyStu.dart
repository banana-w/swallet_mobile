import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/student_features/verify_studentMail/components/otp_form_student.dart';

// import '../../../../screens.dart';

class BodyVerifyStudent extends StatelessWidget {
  final String email;
  const BodyVerifyStudent({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;

    final defaultPinTheme = PinTheme(
        width: 50 * fem,
        height: 60 * hem,
        textStyle: GoogleFonts.openSans(
            textStyle: TextStyle(
                fontSize: 22 * ffem,
                fontWeight: FontWeight.w900,
                height: 1.3625 * ffem / fem,
                color: Colors.black)),
        decoration: BoxDecoration(
            // color: kPrimaryColor,
            border: Border(bottom: BorderSide(color: Colors.black))));
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
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/bg_signup_5.png'),
                )),
                child: Column(
                  children: [
                    SizedBox(
                      height: 400 * hem,
                    ),
                    Text(
                      'Nhập mã xác nhận email sinh viên',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 20 * ffem,
                              fontWeight: FontWeight.w900,
                              height: 1.3625 * ffem / fem,
                              color: Colors.black)),
                    ),
                    SizedBox(
                      height: 10 * hem,
                    ),
                    Text(
                      'Nhập mã số xác nhận đã được gửi đến\n email $email',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 15 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.3625 * ffem / fem,
                              color: kLowTextColor)),
                    ),
                    SizedBox(
                      height: 30 * hem,
                    ),
                    OTPFormStudent(
                      fem: fem,
                      hem: hem,
                      defaultPinTheme: defaultPinTheme,
                      ffem: ffem,
                      email: email,
                    ),
                  ],
                ),
              ),
            ]))
          ],
        ));
  }
}
