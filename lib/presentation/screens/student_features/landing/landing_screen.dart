import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/presentation/blocs/landing_screen/landing_screen_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/student_features/profile/profile_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/campaign/campaign_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/challenge/challenge_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/landing/components/cus_nav_bar.dart';
import 'package:swallet_mobile/presentation/screens/student_features/qr_view/qr_student_view_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/voucher/voucher_screen.dart';
import 'package:swallet_mobile/presentation/widgets/app_bar_campaign.dart';
import 'package:swallet_mobile/presentation/widgets/unverified_screen.dart';

const List<Widget> bottomNavScreen = [
  CampaignScreen(),
  VoucherScreen(),
  ChallengeScreen(),
  ProfileScreen(),
];

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;

    return BlocBuilder<LandingScreenBloc, LandingScreenState>(
      builder: (context, state) {
        // Đảm bảo tabIndex nằm trong khoảng hợp lệ
        final int safeTabIndex = state.tabIndex.clamp(
          0,
          bottomNavScreen.length - 1,
        );

        return SafeArea(
          child: DefaultTabController(
            length:
                safeTabIndex == 1
                    ? 2
                    : safeTabIndex == 2
                    ? 3
                    : 0,
            child: Scaffold(
              appBar: _buildAppbar(safeTabIndex, hem, fem, ffem),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: _buildFloatingActionButton(
                context,
                fem,
                hem,
              ),
              body: bottomNavScreen.elementAt(safeTabIndex),
              backgroundColor: klighGreyColor,
              extendBody: true,
              bottomNavigationBar: const CusNavBar(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFloatingActionButton(
    BuildContext context,
    double fem,
    double hem,
  ) {
    return Container(
      width: 52.5 * fem,
      height: 52.5 * hem,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50 * fem),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 186, 186, 186).withValues(alpha: .35),
            spreadRadius: 8,
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 10 * hem),
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          elevation: 5 * fem,
          shape: const CircleBorder(),
          onPressed: () async {
            final student = await AuthenLocalDataSource.getStudent();
            final studentId = student!.id;
            Navigator.pushNamed(
              context,
              QrStudentViewScreen.routeName,
              arguments: studentId,
            );
                    },
          child: SizedBox(
            width: 20 * fem,
            height: 20 * hem,
            child: SvgPicture.asset('assets/icons/qr-unbean-icon.svg'),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget? _buildAppbar(
    int tabIndex,
    double hem,
    double fem,
    double ffem,
  ) {
    if (tabIndex == 0) {
      return AppBarCampaign(hem: hem, ffem: ffem, fem: fem);
    } else {
      return null;
    }
  }
}
