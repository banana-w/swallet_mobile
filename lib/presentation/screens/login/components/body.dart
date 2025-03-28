import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/login/components/form_login.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_screen.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    double height = MediaQuery.of(context).size.height;
    print(height);

    double responsiveSize() {
      if (height < 800) {
        return 270 * hem;
      }
      return 330 * hem;
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg_login.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: responsiveSize()),
              Text(
                'Chào mừng bạn đến với Swallet!',
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: 20 * ffem,
                    fontWeight: FontWeight.w900,
                    height: 1.3625 * ffem / fem,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20 * hem),
              Text(
                'Đăng nhập và tận hưởng những ưu đãi\n yêu thích của bạn!',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: 15 * ffem,
                    fontWeight: FontWeight.w900,
                    height: 1.3625 * ffem / fem,
                    color: kLowTextColor,
                  ),
                ),
              ),
              SizedBox(height: 20 * hem),
              FormLogin(fem: fem, hem: hem, ffem: ffem),
              SizedBox(height: 10 * hem),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20 * hem),
                    child: Text(
                      'Bạn chưa có tài khoản?',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 13 * ffem,
                          fontWeight: FontWeight.bold,
                          height: 1.3625 * ffem / fem,
                          color: kLowTextColor,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, SignUpScreen.routeName);
                      // Navigator.pushNamed(
                      //   context,
                      //   SignUp6Screen.routeName,
                      //   arguments: true,
                      // );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 2 * fem, bottom: 20 * hem),
                      child: Text(
                        'Đăng ký',
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 13 * ffem,
                            fontWeight: FontWeight.w900,
                            height: 1.3625 * ffem / fem,
                            color: kPrimaryColor,
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
      ),
    );
  }
}
