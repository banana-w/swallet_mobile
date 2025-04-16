import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/blocs/challenge/challenge_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/internet/internet_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/notification/notification_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/screens/student_features/challenge_daily/challenge_daily_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/notification/notification_list_screen.dart';
import '../../../../widgets/unverified_screen.dart';
import 'in_process/in_process_challenge.dart';
import 'is_claimed/is_claimed_challenge.dart';
import 'is_completed/is_completed_challenge.dart';

class ChallengeBody extends StatefulWidget {
  const ChallengeBody({super.key});

  @override
  State<ChallengeBody> createState() => _BodyState();
}

class _BodyState extends State<ChallengeBody> {
  // Không cần TabController vì đã có DefaultTabController ở widget cha

  // Định nghĩa danh sách Tab
  List<Widget> _buildTabList() {
    return [
      Tab(text: 'Đang thực hiện'),
      BlocBuilder<ChallengeBloc, ChallengeState>(
        builder: (context, state) {
          if (state is ChallengesLoaded) {
            final challenges =
                state.challenge
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
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ],
              );
            }
          }
          return Tab(text: 'Nhận thưởng');
        },
      ),
      Tab(text: 'Đã hoàn thành'),
    ];
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
            ..showSnackBar(
              SnackBar(
                elevation: 0,
                duration: const Duration(milliseconds: 2000),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Đã kết nối internet',
                  message: 'Đã kết nối internet!',
                  contentType: ContentType.success,
                ),
              ),
            );
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
                      final stateInternet = context.read<InternetBloc>().state;
                      if (stateInternet is Connected) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Đồng ý'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Column(
        children: [
          // AppBar phần tử cố định
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_splash.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                // AppBar content
                SizedBox(
                  height: 40 * hem,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left icon
                      Padding(
                        padding: EdgeInsets.only(left: 20 * fem),
                        child: BlocBuilder<ChallengeBloc, ChallengeState>(
                          builder: (context, state) {
                            return IconButton(
                              icon: Icon(
                                Icons.task, 
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
                                    ChallengeDailyScreen.routeName,
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ),
                      
                      // Title
                      Padding(
                        padding: EdgeInsets.only(top: 10 * hem),
                        child: Text(
                          'Swallet',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 22 * ffem,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      
                      // Right icon
                      Padding(
                        padding: EdgeInsets.only(top: 5 * fem, right: 20 * fem),
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
                ),
                
                // TabBar - Sử dụng DefaultTabController từ parent
                TabBar(
                  indicatorColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 3,
                  labelColor: Colors.white,
                  labelStyle: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: 12 * ffem,
                      height: 1.3625 * ffem / fem,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  unselectedLabelColor: Colors.white60,
                  unselectedLabelStyle: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: 12 * ffem,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  tabs: _buildTabList(),
                ),
              ],
            ),
          ),
          
          // TabBarView - Phần nội dung tab
          Expanded(
            child: TabBarView(
              children: [
                //In process Challenge
                InProcessChallenge(),
                
                //Is Completed Challenge (chưa claim)
                IsCompletedChallenge(),
                
                //Is Claimed Challenge (đã claim)
                IsClaimedChallenge(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}