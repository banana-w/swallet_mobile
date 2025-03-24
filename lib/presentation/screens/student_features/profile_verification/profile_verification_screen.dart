import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/models/student_features/student_model.dart';
import 'package:swallet_mobile/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

import '../../../../data/models.dart';
import '../../../blocs/blocs.dart';
import '../../screens.dart';
import 'components/body.dart';

class ProfileVerificationScreen extends StatelessWidget {
  static const String routeName = '/profile-verification-student';
  static Route route({required StudentModel studentModel}) {
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
            child: ProfileVerificationScreen(studentModel: studentModel),
          ),
      settings: const RouteSettings(name: routeName),
    );
  }

  final StudentModel studentModel;
  const ProfileVerificationScreen({super.key, required this.studentModel});

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
          title: Container(
            child: Text(
              'Xác minh',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 20 * ffem,
                  fontWeight: FontWeight.w900,
                  height: 1.3625 * ffem / fem,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          toolbarHeight: 50 * hem,
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
        body: Body(studentModel: studentModel),
      ),
    );
  }
}
