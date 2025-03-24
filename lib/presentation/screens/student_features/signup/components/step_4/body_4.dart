import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/step_4/form_4.dart';

class Body4 extends StatelessWidget {
  const Body4({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
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
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 130 * hem),
                    Container(
                      width: 190 * fem,
                      height: 210 * fem,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/signup_step4.png'),
                        ),
                      ),
                    ),
                    SizedBox(height: 10 * hem),
                    Text(
                      'Các thông tin ở trường của bạn',
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
                    SizedBox(height: 20 * hem),
                    Text(
                      'Để giúp việc xác thực thành công,\n mong bạn hãy cung cấp thông tin chính xác.',
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
                    SizedBox(height: 40 * hem),
                    FormBody4(fem: fem, hem: hem, ffem: ffem),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
