import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/widgets/app_bar_campaign.dart';

import 'components/body.dart';

class ProfileStoreScreen extends StatelessWidget {
  const ProfileStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    return BlocBuilder<RoleAppBloc, RoleAppState>(
      builder: (context, state) {
        if (state is StoreRole) {
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
              body: const Body(),
            ),
          );
        }

        if (state is RoleAppLoading) {
          return Scaffold(
            appBar: AppBarCampaign(hem: hem, ffem: ffem, fem: fem),
            body: Container(
              color: klighGreyColor,
              child: Center(
                child: Lottie.asset('assets/animations/loading-screen.json'),
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
