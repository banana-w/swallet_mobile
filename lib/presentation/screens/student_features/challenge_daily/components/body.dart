import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/blocs/challenge/challenge_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/internet/internet_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/notification/notification_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/screens/student_features/notification/notification_list_screen.dart';
import '../../../../widgets/unverified_screen.dart';
import 'in_process/in_process_challenge.dart';
import 'is_claimed/is_claimed_challenge.dart';
import 'is_completed/is_completed_challenge.dart';

class ChallengeDailyBody extends StatelessWidget {
  const ChallengeDailyBody({super.key});

  List<Widget> _buildTabs() {
    return [
      const Tab(text: 'Đang thực hiện'),
      BlocBuilder<ChallengeBloc, ChallengeState>(
        builder: (context, state) {
          if (state is ChallengesLoaded) {
            final hasUnclaimedCompletedChallenges = state.challenge
                .any((c) => c.isCompleted && !c.isClaimed);

            if (hasUnclaimedCompletedChallenges) {
              return Stack(
                children: [
                  const Tab(text: 'Nhận thưởng'),
                  Positioned(
                    top: 10,
                    right: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  )
                ],
              );
            }
          }
          return const Tab(text: 'Nhận thưởng');
        },
      ),
      const Tab(text: 'Đã hoàn thành'),
    ];
  }

  Widget _buildAppBar(BuildContext context, {
    required double hem,
    required double fem,
    required double ffem,
  }) {
    final roleState = context.read<RoleAppBloc>().state;
    
    return SliverAppBar(
      pinned: true,
      floating: true,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_splash.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      toolbarHeight: 40 * hem,
      centerTitle: true,
      title: Padding(
        padding: EdgeInsets.only(top: 10 * hem),
        child: Text(
          'Nhiệm vụ ngày',
          style: GoogleFonts.openSans(
            fontSize: 22 * ffem,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(top: 5 * fem, right: 20 * fem),
          child: _buildNotificationButton(context, fem, roleState),
        ),
      ],
      bottom: TabBar(
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 3,
        labelColor: Colors.white,
        labelStyle: GoogleFonts.openSans(
          fontSize: 12 * ffem,
          height: 1.3625 * ffem / fem,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelColor: Colors.white60,
        unselectedLabelStyle: GoogleFonts.openSans(
          fontSize: 12 * ffem,
          fontWeight: FontWeight.w700,
        ),
        tabs: _buildTabs(),
      ),
    );
  }

  Widget _buildNotificationButton(BuildContext context, double fem, RoleAppState roleState) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        final bool isNewNotification = state is NewNotification;
        return IconButton(
          icon: Icon(
            isNewNotification ? Icons.notifications_active_rounded : Icons.notifications,
            color: isNewNotification ? Colors.yellow : Colors.white,
            size: 25 * fem,
          ),
          onPressed: () => _handleNotificationPress(context, roleState, isNewNotification),
        );
      },
    );
  }

  void _handleNotificationPress(BuildContext context, RoleAppState roleState, bool isNewNotification) {
    if (roleState is Unverified) {
      Navigator.pushNamed(context, UnverifiedScreen.routeName);
    } else {
      if (isNewNotification) {
        context.read<NotificationBloc>().add(LoadNotification());
      }
      Navigator.pushNamed(context, NotificationListScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;

    return BlocListener<InternetBloc, InternetState>(
      listener: _handleInternetState,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          _buildAppBar(context, hem: hem, fem: fem, ffem: ffem),
        ],
        body: TabBarView(
          children: const [
            InProcessChallenge(),
            IsCompletedChallenge(),
            IsClaimedChallenge(),
          ],
        ),
      ),
    );
  }

  void _handleInternetState(BuildContext context, InternetState state) {
    if (state is Connected) {
      _showConnectedSnackBar(context);
    } else if (state is NotConnected) {
      _showNoInternetDialog(context);
    }
  }

  void _showConnectedSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        elevation: 0,
        duration: const Duration(milliseconds: 2000),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Đã kết nối internet',
          message: 'Đã kết nối internet!',
          contentType: ContentType.success,
        ),
      ));
  }

  void _showNoInternetDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Không kết nối Internet'),
        content: const Text('Vui lòng kết nối Internet'),
        actions: [
          TextButton(
            onPressed: () {
              final stateInternet = context.read<InternetBloc>().state;
              if (stateInternet is Connected) {
                Navigator.pop(context);
              }
            },
            child: const Text('Đồng ý'),
          ),
        ],
      ),
    );
  }
}
