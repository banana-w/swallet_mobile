import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/login/login_screen.dart';

import 'components/body.dart';

class BrandListScreen extends StatelessWidget {
  static const String routeName = '/brand-list-student';
  static Route route() {
    return MaterialPageRoute(
      builder:
          (_) => BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationFailed) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  LoginScreen.routeName,
                  (Route<dynamic> route) => false,
                );
              }
            },
            child: BrandListScreen(),
          ),
      settings: const RouteSettings(name: routeName),
    );
  }

  const BrandListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_splash.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            'Thương hiệu',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 20 * ffem,
                fontWeight: FontWeight.w900,
                height: 1.3625 * ffem / fem,
                color: Colors.white,
              ),
            ),
          ),
          toolbarHeight: 40 * hem,
          leading: Container(
            margin: EdgeInsets.only(left: 20 * fem),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 30 * fem,
              ),
            ),
          ),
          leadingWidth: 60 * fem,
        ),
        backgroundColor: klighGreyColor,
        body: Body(),
      ),
    );
  }
}
