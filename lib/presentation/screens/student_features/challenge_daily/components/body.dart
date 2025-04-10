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

class ChallengeDailyBody extends StatefulWidget {
  const ChallengeDailyBody({super.key});

  @override
  State<ChallengeDailyBody> createState() => _BodyState();
}

class _BodyState extends State<ChallengeDailyBody> with SingleTickerProviderStateMixin {
  late TabController _controller;

  List<Widget> list = [
    Tab(
      text: 'Đang thực hiện',
    ),
    BlocBuilder<ChallengeBloc, ChallengeState>(
      builder: (context, state) {
        if (state is ChallengesLoaded) {
          final challenges = state.challenge
              .where((c) => (c.isCompleted && !c.isClaimed))
              .toList();
          if (challenges.isNotEmpty) {
            return Stack(
              children: [
                Tab(text: 'Nhận thưởng'),
                Positioned(
                  top: 10,
                  right: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                )
              ],
            );
          } else {
            return Tab(text: 'Nhận thưởng');
          }
        }
        return Tab(text: 'Nhận thưởng');
      },
    ),
    Tab(text: 'Đã hoàn thành'),
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: list.length, vsync: this);

    _controller.addListener(() {
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    final roleState = context.read<RoleAppBloc>().state;
    return BlocListener<InternetBloc, InternetState>(
      listener: (context, state) {
        if (state is Connected) {
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
        } else if (state is NotConnected) {
          showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: const Text('Không kết nối Internet'),
                content: Text('Vui lòng kết nối Internet'),
                actions: [
                  TextButton(
                      onPressed: () {
                        final stateInternet =
                            context.read<InternetBloc>().state;
                        if (stateInternet is Connected) {
                          Navigator.pop(context);
                        } else {}
                      },
                      child: const Text('Đồng ý'))
                ],
              );
            },
          );
        }
      },
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
             SliverAppBar(
              pinned: true,
              floating: true,
              elevation: 0,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage('assets/images/background_splash.png'),
                        fit: BoxFit.cover)),
              ),
              toolbarHeight: 40 * hem,
              centerTitle: true,
              title: Padding(
                padding: EdgeInsets.only(top: 10 * hem),
                child: Text(
                  'Nhiệm vụ ngày',
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          fontSize: 22 * ffem,
                          fontWeight: FontWeight.w900,
                          color: Colors.white)),
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(top: 5*fem, right: 20 * fem),
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
                                  context, UnverifiedScreen.routeName);
                            } else {
                              context
                                  .read<NotificationBloc>()
                                  .add(LoadNotification());
                              Navigator.pushNamed(
                                  context, NotificationListScreen.routeName);
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
                                context, UnverifiedScreen.routeName);
                          } else {
                            Navigator.pushNamed(
                                context, NotificationListScreen.routeName);
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
              bottom: TabBar(
                  controller: _controller,
                  indicatorColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 3,
                  // indicatorPadding: EdgeInsets.only(bottom: 1 * fem),
                  labelColor: Colors.white,
                  labelStyle: GoogleFonts.openSans(
                      textStyle: TextStyle(
                    fontSize: 12 * ffem,
                    height: 1.3625 * ffem / fem,
                    fontWeight: FontWeight.w700,
                  )),
                  unselectedLabelColor: Colors.white60,
                  unselectedLabelStyle: GoogleFonts.openSans(
                      textStyle: TextStyle(
                    fontSize: 12 * ffem,
                    fontWeight: FontWeight.w700,
                  )),
                  tabs: list),
            )
          ];
        },
        body: TabBarView(
          controller: _controller,
          children: [
            //In process Challenge
            InProcessChallenge(),

            //complete Challenge
            IsCompletedChallenge(),

            //completed Challenge
            IsClaimedChallenge()
          ],
        ),
      ),
    );
  }
}
