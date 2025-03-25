import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

import 'form_7.dart';

class Body7 extends StatelessWidget {
  const Body7({super.key});

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
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/bg_signup_4.png'),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 400 * hem),
              Text(
                'Số điện thoại của bạn',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: 20 * ffem,
                    fontWeight: FontWeight.w900,
                    height: 1.3625 * ffem / fem,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 10 * hem),
              Text(
                'Nhập số điện thoại của bạn,\n chúng tôi sẽ gửi đến bạn mã OTP để xác nhận',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: 15 * ffem,
                    fontWeight: FontWeight.w600,
                    height: 1.3625 * ffem / fem,
                    color: kLowTextColor,
                  ),
                ),
              ),
              SizedBox(height: 30 * hem),
              FormBody7(fem: fem, hem: hem, ffem: ffem),
            ],
          ),
        ),
      ),
    );
  }
}
