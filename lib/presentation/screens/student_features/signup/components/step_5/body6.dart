import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/step_5/form_6.dart';

class Body6 extends StatelessWidget {
  const Body6({super.key});

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
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 120 * hem),
                    // Container(
                    //   width: 250 * fem,
                    //   height: 200 * fem,
                    //   decoration: const BoxDecoration(
                    //       image: DecorationImage(
                    //           fit: BoxFit.cover,
                    //           image: AssetImage(
                    //               'assets/images/signup_student_card.png'))),
                    // ),
                    Text(
                      'Thẻ sinh viên',
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
                    Container(
                      padding: EdgeInsets.only(left: 15 * fem, right: 15 * fem),
                      child: Text(
                        'Hãy tải lên mặt trước \ncủa thẻ sinh viên',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                          fontSize: 15 * ffem,
                          fontWeight: FontWeight.w600,
                          color: kLowTextColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 20 * hem),
                    FormBody6(fem: fem, hem: hem, ffem: ffem),
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
