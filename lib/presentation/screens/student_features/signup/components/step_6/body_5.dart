import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/step_6/form_body_5.dart';

class Body5 extends StatelessWidget {
  const Body5({super.key});

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
                    SizedBox(height: 130 * hem),
                    Container(
                      width: 190 * fem,
                      height: 220 * fem,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            'assets/images/signup_invitecode.png',
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Mã giới thiệu bạn bè',
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
                    SizedBox(height: 40 * hem),
                    FormBody5(fem: fem, hem: hem, ffem: ffem),
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
