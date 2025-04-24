import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/presentation/blocs/landing_screen/landing_screen_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/lecture_features/campus/campus_screen.dart';
import 'package:swallet_mobile/presentation/screens/lecture_features/qr_history/history_screen.dart';
import 'package:swallet_mobile/presentation/screens/lecture_features/landing_screen/components/cus_nav_bar_lecture.dart';
import 'package:swallet_mobile/presentation/screens/lecture_features/profile/profile_lecture_screen.dart';
import 'package:swallet_mobile/presentation/screens/lecture_features/qr_generate/qr_generate_screen.dart';
import 'package:swallet_mobile/presentation/screens/lecture_features/used_qr_history/used_qr_history_screen.dart';
import 'package:swallet_mobile/presentation/widgets/app_bar_campaign.dart';

import 'package:swallet_mobile/presentation/widgets/app_bar_store.dart';

class LandingLectureScreen extends StatelessWidget {
  const LandingLectureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;

    final List<Widget> bottomNavScreen = [
      const CampusScreen(),
      const HistoryTabScreen(),
      const QRCodeHistoryScreen(),
      const ProfileLectureScreen(),
    ];

    return BlocBuilder<LandingScreenBloc, LandingScreenState>(
      builder: (context, state) {
        if (state.tabIndex == 0 || state.tabIndex == 1) {
          return SafeArea(
            child: Scaffold(
              appBar: _buildAppbar(state.tabIndex, -hem, fem, ffem),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: Container(
                width: 52.5 * fem,
                height: 52.5 * hem,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50 * fem),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(
                        255,
                        186,
                        186,
                        186,
                      ).withOpacity(0.35),
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
                      final lecture = await AuthenLocalDataSource.getLecture();
                      final lectureId = lecture?.id;
                      if (lectureId != null) {
                        Navigator.pushNamed(
                          context,
                          QRGenerateScreen.routeName,
                          arguments: lectureId,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Không thể lấy lectureId'),
                          ),
                        );
                      }
                    },
                    child: SizedBox(
                      width: 20 * fem,
                      height: 20 * hem,
                      child: SvgPicture.asset(
                        'assets/icons/qr-unbean-icon.svg',
                      ),
                    ),
                  ),
                ),
              ),
              body: bottomNavScreen.elementAt(state.tabIndex),
              backgroundColor: klighGreyColor,
              extendBody: true,
              bottomNavigationBar: const CusNavLectureBar(),
            ),
          );
        } else if (state.tabIndex == 2) {
          return DefaultTabController(
            length: 3,
            child: SafeArea(
              child: Scaffold(
                appBar: _buildAppbar(state.tabIndex, hem, fem, ffem),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton: Container(
                  width: 52.5 * fem,
                  height: 52.5 * hem,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50 * fem),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(
                          255,
                          186,
                          186,
                          186,
                        ).withOpacity(0.35),
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
                        final lecture =
                            await AuthenLocalDataSource.getLecture();
                        final lectureId = lecture?.id;
                        if (lectureId != null) {
                          Navigator.pushNamed(
                            context,
                            QRGenerateScreen.routeName,
                            arguments: lectureId,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Không thể lấy lectureId'),
                            ),
                          );
                        }
                      },
                      child: SizedBox(
                        width: 20 * fem,
                        height: 20 * hem,
                        child: SvgPicture.asset(
                          'assets/icons/qr-unbean-icon.svg',
                        ),
                      ),
                    ),
                  ),
                ),
                body: bottomNavScreen.elementAt(state.tabIndex),
                backgroundColor: klighGreyColor,
                extendBody: true,
                bottomNavigationBar: const CusNavLectureBar(),
              ),
            ),
          );
        } else {
          return SafeArea(
            child: Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: Container(
                width: 52.5 * fem,
                height: 52.5 * hem,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50 * fem),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(
                        255,
                        186,
                        186,
                        186,
                      ).withOpacity(0.35),
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
                      final lecture = await AuthenLocalDataSource.getLecture();
                      final lectureId = lecture?.id;
                      if (lectureId != null) {
                        Navigator.pushNamed(
                          context,
                          QRGenerateScreen.routeName,
                          arguments: lectureId,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Không thể lấy lectureId'),
                          ),
                        );
                      }
                    },
                    child: SizedBox(
                      width: 20 * fem,
                      height: 20 * hem,
                      child: SvgPicture.asset(
                        'assets/icons/qr-unbean-icon.svg',
                      ),
                    ),
                  ),
                ),
              ),
              body: bottomNavScreen.elementAt(state.tabIndex),
              backgroundColor: klighGreyColor,
              extendBody: true,
              bottomNavigationBar: const CusNavLectureBar(),
            ),
          );
        }
      },
    );
  }

  PreferredSizeWidget? _buildAppbar(
    int tabIndex,
    double hem,
    double fem,
    double ffem,
  ) {
    if (tabIndex == 0 || tabIndex == 1) {
      // return AppBarCampaign(hem: hem, ffem: ffem, fem: fem);
      return null;
    } else {
      return null;
    }
  }
}
