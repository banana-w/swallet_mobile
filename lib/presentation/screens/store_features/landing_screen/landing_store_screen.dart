import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/presentation/blocs/landing_screen/landing_screen_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/store_features/campaign/campaign_store_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/dashboard/dashboard_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/profile/profile_store_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/qr_view/qr_view_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/voucher_history/voucher_history.dart';
import 'package:swallet_mobile/presentation/widgets/app_bar_store.dart';
import 'components/cus_nav_bar_strore.dart';

class LandingStoreScreen extends StatelessWidget {
  const LandingStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    return BlocBuilder<LandingScreenBloc, LandingScreenState>(
      builder: (context, state) {
        if (state.tabIndex == 0 || state.tabIndex == 1) {
          return SafeArea(
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
                      color: Color.fromARGB(
                        255,
                        186,
                        186,
                        186,
                      ).withValues(alpha: .35),
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
                      final store = await AuthenLocalDataSource.getStore();
                      final storeId = store?.id;

                      Navigator.pushNamed(
                        context,
                        QrViewScreen.routeName,
                        arguments: storeId,
                      );
                    },
                    child: SizedBox(
                      width: 30 * fem,
                      height: 30 * hem,
                      child: Icon(
                        Icons.qr_code_scanner,
                        color: Colors.white,
                        size: 30 * fem,
                      ),
                    ),
                  ),
                ),
              ),
              body: bottomNavScreen.elementAt(state.tabIndex),
              backgroundColor: klighGreyColor,
              extendBody: true,
              bottomNavigationBar: CusNavStoreBar(),
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
                        color: Color.fromARGB(
                          255,
                          186,
                          186,
                          186,
                        ).withValues(alpha: .35),
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
                        final store = await AuthenLocalDataSource.getStore();
                        final storeId = store?.id;
                        Navigator.pushNamed(
                          context,
                          QrViewScreen.routeName,
                          arguments: storeId,
                        );
                      },
                      child: SizedBox(
                        width: 20 * fem,
                        height: 20 * hem,
                        child: Icon(
                          Icons.qr_code_scanner,
                          color: Colors.white,
                          size: 20 * fem,
                        ),
                      ),
                    ),
                  ),
                ),
                body: bottomNavScreen.elementAt(state.tabIndex),
                backgroundColor: klighGreyColor,
                extendBody: true,
                bottomNavigationBar: CusNavStoreBar(),
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
                      color: Color.fromARGB(
                        255,
                        186,
                        186,
                        186,
                      ).withValues(alpha: .35),
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
                      final store = await AuthenLocalDataSource.getStore();
                      final storeId = store?.id;
                      Navigator.pushNamed(
                        context,
                        QrViewScreen.routeName,
                        arguments: storeId,
                      );
                    },
                    child: SizedBox(
                      width: 20 * fem,
                      height: 20 * hem,
                      child: Icon(
                        Icons.qr_code_scanner,
                        color: Colors.white,
                        size: 20 * fem,
                      ),
                    ),
                  ),
                ),
              ),
              body: bottomNavScreen.elementAt(state.tabIndex),
              backgroundColor: klighGreyColor,
              extendBody: true,
              bottomNavigationBar: CusNavStoreBar(),
            ),
          );
        }
      },
    );
  }
}

List<Widget> bottomNavScreen = [
  CampaignStoreScreen(),
  DashboardScreen(),
  VoucherHistoryScreenStore(),
  ProfileStoreScreen(),
];

PreferredSizeWidget? _buildAppbar(
  int tabIndex,
  double hem,
  double fem,
  double ffem,
) {
  if (tabIndex == 0 || tabIndex == 1) {
    return AppBarStore(hem: hem, ffem: ffem, fem: fem);
  } else
    return null;
}

