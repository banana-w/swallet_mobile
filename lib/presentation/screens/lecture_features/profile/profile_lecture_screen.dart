import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/widgets/app_bar_campaign.dart';

import 'components/body.dart';

class ProfileLectureScreen extends StatelessWidget {
  const ProfileLectureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    final roleState = context.watch<RoleAppBloc>().state;

    return BlocBuilder<RoleAppBloc, RoleAppState>(
      builder: (context, state) {
        if (roleState is LectureRole) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                toolbarHeight: 80 * hem,
                centerTitle: true,
                title: Text(
                  'Swallet',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: 22 * ffem,
                      fontWeight: FontWeight.w900,
                      height: 1.3625 * ffem / fem,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              extendBodyBehindAppBar: true,
              extendBody: true,
              body: Body(),
            ),
          );
        } else if (roleState is RoleAppLoading) {
          return Scaffold(
            appBar: AppBarCampaign(hem: hem, ffem: ffem, fem: fem),
            body: Container(
              color: klighGreyColor,
              child: Center(
                child: Container(
                  child: Lottie.asset('assets/animations/loading-screen.json'),
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
