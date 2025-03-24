import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/presentation/blocs/blocs.dart';
import 'package:swallet_mobile/presentation/blocs/landing_screen/landing_screen_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/profile/profile_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/landing/components/cus_nav_bar.dart';
import 'package:swallet_mobile/presentation/screens/screens.dart';
import 'package:swallet_mobile/presentation/screens/student_features/lucky_wheel/lucky_wheel_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/qr/qr_screen.dart';
import 'package:swallet_mobile/presentation/widgets/app_bar_campaign.dart';

import '../../../widgets/unverified_screen.dart';

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
                    color: Color.fromARGB(255, 186, 186, 186).withOpacity(0.35),
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
                    final studentId =
                        await AuthenLocalDataSource.getStudentId();
                    if (studentId != null) {
                      Navigator.pushNamed(
                        context,
                        QRScreen.routeName,
                        arguments: studentId,
                      );
                    } else {
                      Navigator.pushNamed(context, UnverifiedScreen.routeName);
                    }
                  },
                  child: Container(
                    width: 20 * fem,
                    height: 20 * hem,
                    child: SvgPicture.asset('assets/icons/qr-unbean-icon.svg'),
                  ),
                ),
              ),
            ),
            body: bottomNavScreen.elementAt(0), // Luôn hiển thị ProfileScreen
            backgroundColor: klighGreyColor,
            extendBody: true,
            bottomNavigationBar: const CusNavBar(),
          ),
        );
      },
    );
  }
}

// class LandingScreen extends StatelessWidget {
//   const LandingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double baseWidth = 375;
//     double fem = MediaQuery.of(context).size.width / baseWidth;
//     double ffem = fem * 0.97;
//     double baseHeight = 812;
//     double hem = MediaQuery.of(context).size.height / baseHeight;
//     return BlocBuilder<LandingScreenBloc, LandingScreenState>(
//       builder: (context, state) {
//         if (state.tabIndex == 0) {
//           return SafeArea(
//             child: Scaffold(
//               appBar: _buildAppbar(state.tabIndex, hem, fem, ffem),
//               floatingActionButtonLocation:
//                   FloatingActionButtonLocation.centerDocked,
//               floatingActionButton: Container(
//                 width: 52.5 * fem,
//                 height: 52.5 * hem,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(50 * fem),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color.fromARGB(
//                         255,
//                         186,
//                         186,
//                         186,
//                       ).withOpacity(0.35),
//                       spreadRadius: 8,
//                       blurRadius: 8,
//                       offset: const Offset(0, 1),
//                     ),
//                   ],
//                 ),
//                 margin: EdgeInsets.only(top: 10 * hem),
//                 child: FittedBox(
//                   child: FloatingActionButton(
//                     backgroundColor: kPrimaryColor,
//                     elevation: 5 * fem,
//                     shape: const CircleBorder(),
//                     onPressed: () async {
//                       final studentId =
//                           await AuthenLocalDataSource.getStudentId();
//                       if (studentId != null) {
//                         // Navigator.pushNamed(
//                         //   context,
//                         //   QRScreen.routeName,
//                         //   arguments: studentId,
//                         // );
//                       } else {
//                         Navigator.pushNamed(
//                           context,
//                           UnverifiedScreen.routeName,
//                         );
//                       }
//                     },
//                     child: Container(
//                       width: 20 * fem,
//                       height: 20 * hem,
//                       child: SvgPicture.asset(
//                         'assets/icons/qr-unbean-icon.svg',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               body: bottomNavScreen.elementAt(state.tabIndex),
//               backgroundColor: klighGreyColor,
//               extendBody: true,
//               bottomNavigationBar: CusNavBar(),
//             ),
//           );
//         } else if (state.tabIndex == 1) {
//           return DefaultTabController(
//             length: 2,
//             child: SafeArea(
//               child: Scaffold(
//                 appBar: _buildAppbar(state.tabIndex, hem, fem, ffem),
//                 floatingActionButtonLocation:
//                     FloatingActionButtonLocation.centerDocked,
//                 floatingActionButton: Container(
//                   width: 52.5 * fem,
//                   height: 52.5 * hem,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(50 * fem),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Color.fromARGB(
//                           255,
//                           186,
//                           186,
//                           186,
//                         ).withOpacity(0.35),
//                         spreadRadius: 8,
//                         blurRadius: 8,
//                         offset: const Offset(0, 1),
//                       ),
//                     ],
//                   ),
//                   margin: EdgeInsets.only(top: 10 * hem),
//                   child: FittedBox(
//                     child: FloatingActionButton(
//                       backgroundColor: kPrimaryColor,
//                       elevation: 5 * fem,
//                       shape: const CircleBorder(),
//                       onPressed: () async {
//                         final studentId =
//                             await AuthenLocalDataSource.getStudentId();
//                         if (studentId != null) {
//                           // Navigator.pushNamed(
//                           //   context,
//                           //   QRScreen.routeName,
//                           //   arguments: studentId,
//                           // );
//                         } else {
//                           Navigator.pushNamed(
//                             context,
//                             UnverifiedScreen.routeName,
//                           );
//                         }
//                       },
//                       child: Container(
//                         width: 20 * fem,
//                         height: 20 * hem,
//                         child: SvgPicture.asset(
//                           'assets/icons/qr-unbean-icon.svg',
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 body: bottomNavScreen.elementAt(state.tabIndex),
//                 backgroundColor: klighGreyColor,
//                 extendBody: true,
//                 bottomNavigationBar: CusNavBar(),
//               ),
//             ),
//           );
//         } else if (state.tabIndex == 2) {
//           return DefaultTabController(
//             length: 3,
//             child: SafeArea(
//               child: Scaffold(
//                 appBar: _buildAppbar(state.tabIndex, hem, fem, ffem),
//                 floatingActionButtonLocation:
//                     FloatingActionButtonLocation.centerDocked,
//                 floatingActionButton: Container(
//                   width: 52.5 * fem,
//                   height: 52.5 * hem,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(50 * fem),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Color.fromARGB(
//                           255,
//                           186,
//                           186,
//                           186,
//                         ).withOpacity(0.35),
//                         spreadRadius: 8,
//                         blurRadius: 8,
//                         offset: const Offset(0, 1),
//                       ),
//                     ],
//                   ),
//                   margin: EdgeInsets.only(top: 10 * hem),
//                   child: FittedBox(
//                     child: FloatingActionButton(
//                       backgroundColor: kPrimaryColor,
//                       elevation: 5 * fem,
//                       shape: const CircleBorder(),
//                       onPressed: () async {
//                         final studentId =
//                             await AuthenLocalDataSource.getStudentId();
//                         if (studentId != null) {
//                           // Navigator.pushNamed(
//                           //   context,
//                           //   QRScreen.routeName,
//                           //   arguments: studentId,
//                           // );
//                         } else {
//                           Navigator.pushNamed(
//                             context,
//                             UnverifiedScreen.routeName,
//                           );
//                         }
//                       },
//                       child: Container(
//                         width: 20 * fem,
//                         height: 20 * hem,
//                         child: SvgPicture.asset(
//                           'assets/icons/qr-unbean-icon.svg',
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 body: bottomNavScreen.elementAt(state.tabIndex),
//                 backgroundColor: klighGreyColor,
//                 extendBody: true,
//                 bottomNavigationBar: CusNavBar(),
//               ),
//             ),
//           );
//         } else {
//           return SafeArea(
//             child: Scaffold(
//               floatingActionButtonLocation:
//                   FloatingActionButtonLocation.centerDocked,
//               floatingActionButton: Container(
//                 width: 52.5 * fem,
//                 height: 52.5 * hem,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(50 * fem),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color.fromARGB(
//                         255,
//                         186,
//                         186,
//                         186,
//                       ).withOpacity(0.35),
//                       spreadRadius: 8,
//                       blurRadius: 8,
//                       offset: const Offset(0, 1),
//                     ),
//                   ],
//                 ),
//                 margin: EdgeInsets.only(top: 10 * hem),
//                 child: FittedBox(
//                   child: FloatingActionButton(
//                     backgroundColor: kPrimaryColor,
//                     elevation: 5 * fem,
//                     shape: const CircleBorder(),
//                     onPressed: () async {
//                       final studentId =
//                           await AuthenLocalDataSource.getStudentId();
//                       if (studentId != null) {
//                         // Navigator.pushNamed(
//                         //   context,
//                         //   QRScreen.routeName,
//                         //   arguments: studentId,
//                         // );
//                       } else {
//                         Navigator.pushNamed(
//                           context,
//                           UnverifiedScreen.routeName,
//                         );
//                       }
//                     },
//                     child: Container(
//                       width: 20 * fem,
//                       height: 20 * hem,
//                       child: SvgPicture.asset(
//                         'assets/icons/qr-unbean-icon.svg',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               body: bottomNavScreen.elementAt(state.tabIndex),
//               backgroundColor: klighGreyColor,
//               extendBody: true,
//               bottomNavigationBar: CusNavBar(),
//             ),
//           );
//         }
//       },
//     );
//   }
// }

List<Widget> bottomNavScreen = [
  // CampaignScreen(),
  // VoucherScreen(),
  // ChallengeScreen(),
  ProfileScreen(),
];

PreferredSizeWidget? _buildAppbar(
  int tabIndex,
  double hem,
  double fem,
  double ffem,
) {
  if (tabIndex == 0) {
    return AppBarCampaign(hem: hem, ffem: ffem, fem: fem);
  } else
    return null;
}
