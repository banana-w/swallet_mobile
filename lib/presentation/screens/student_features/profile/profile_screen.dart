import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:swallet_mobile/presentation/blocs/challenge/challenge_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/notification/notification_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/student_features/challenge_daily/challenge_daily_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/profile/components/body.dart';
import 'package:swallet_mobile/presentation/screens/student_features/notification/notification_list_screen.dart';
import 'package:swallet_mobile/presentation/widgets/app_bar_campaign.dart';
import 'package:swallet_mobile/presentation/widgets/unverified_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;

    final roleState = context.watch<RoleAppBloc>().state;

    /// get state from RoleAppBloc

    return authenScreen(roleState, fem, hem, ffem, context);
  }

  Widget authenScreen(roleState, fem, hem, ffem, context) {
    if (roleState is Unverified) {
      return _buildVerifiedStudent(fem, hem, ffem, '', roleState);
    } else if (roleState is Verified) {
      return _buildVerifiedStudent(
        fem,
        hem,
        ffem,
        roleState.studentModel.accountId,
        roleState,
      );
    }
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

  Widget _buildVerifiedStudent(
    double fem,
    double hem,
    double ffem,
    String accountId,
    roleState,
  ) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 80 * hem,
          centerTitle: true,
          title: Text(
            'SWallet',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 22 * ffem,
                fontWeight: FontWeight.w900,
                height: 1.3625 * ffem / fem,
                color: Colors.white,
              ),
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.only(left: 20 * fem),
            child: BlocBuilder<ChallengeBloc, ChallengeState>(
              builder: (context, state) {
                // if (state is NewChallenge) {
                //   return IconButton(
                //     icon: Icon(
                //       Icons
                //           .task_alt_rounded, // Icon nhiệm vụ khi có nhiệm vụ mới
                //       color: Colors.yellow,
                //       size: 25 * fem,
                //     ),
                //     onPressed: () {
                //       if (roleState is Unverified) {
                //         Navigator.pushNamed(
                //           context,
                //           UnverifiedScreen.routeName,
                //         );
                //       } else {
                //         context.read<ChallengeBloc>().add(LoadChallenges());
                //         Navigator.pushNamed(
                //           context,
                //           ChallengeDailyScreen.routeName,
                //         );
                //       }
                //     },
                //   );
                // }
                return IconButton(
                  icon: Icon(
                    Icons.task, // Icon nhiệm vụ mặc định
                    color: Colors.white,
                    size: 25 * fem,
                  ),
                  onPressed: () {
                    if (roleState is Unverified) {
                      Navigator.pushNamed(context, UnverifiedScreen.routeName);
                    } else {
                      Navigator.pushNamed(
                        context,
                        ChallengeDailyScreen.routeName,
                      );
                    }
                  },
                );
              },
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20 * fem),
              child: BlocBuilder<NotificationBloc, NotificationState>(
                builder: (context, state) {
                  if (state is NewNotification) {
                    return IconButton(
                      icon: Icon(
                        Icons.notifications_active_rounded,
                        color: Colors.yellow,
                        size: 25 * fem,
                      ),
                      onPressed: () {
                        if (roleState is Unverified) {
                          Navigator.pushNamed(
                            context,
                            UnverifiedScreen.routeName,
                          );
                        } else {
                          context.read<NotificationBloc>().add(
                            LoadNotification(),
                          );
                          Navigator.pushNamed(
                            context,
                            NotificationListScreen.routeName,
                          );
                        }
                      },
                    );
                  }
                  return IconButton(
                    icon: Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: 25 * fem,
                    ),
                    onPressed: () {
                      if (roleState is Unverified) {
                        Navigator.pushNamed(
                          context,
                          UnverifiedScreen.routeName,
                        );
                      } else {
                        Navigator.pushNamed(
                          context,
                          NotificationListScreen.routeName,
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: Body(accountId: accountId),
      ),
    );
  }
}
