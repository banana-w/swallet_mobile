import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/models/store_features/store_model.dart';
import 'package:swallet_mobile/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/login/login_screen.dart';

import 'components/body.dart';

class ProfileUpdateDetailStoreScreen extends StatelessWidget {
  static const String routeName = '/profile-update-detail-store';
  static Route route({required StoreModel storeModel}) {
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
            child: ProfileUpdateDetailStoreScreen(storeModel: storeModel),
          ),
      settings: const RouteSettings(name: routeName),
    );
  }

  final StoreModel storeModel;
  const ProfileUpdateDetailStoreScreen({super.key, required this.storeModel});

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
              'Sửa thông tin',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 20 * ffem,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          toolbarHeight: 60 * hem,
          leading: Container(
            margin: EdgeInsets.only(left: 20 * fem),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 35 * fem,
              ),
            ),
          ),
          leadingWidth: 60 * fem,
        ),
        backgroundColor: klighGreyColor,
        body: Body(storeModel: storeModel),
      ),
    );
  }
}
