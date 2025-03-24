import 'package:flutter/material.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/step/form_0.dart';

// import '../../../screens.dart';

class Body extends StatelessWidget {
  const Body({super.key});

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
                width: MediaQuery.of(context).size.width,
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
                      width: 210 * fem,
                      height: 210 * fem,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/signup_account.png'),
                        ),
                      ),
                    ),
                    SizedBox(height: 10 * hem),
                    FormBody(hem: hem, fem: fem, ffem: ffem),
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
