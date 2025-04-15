import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/student_repository.dart';
import 'package:swallet_mobile/presentation/blocs/challenge/challenge_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/internet/internet_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/notification/notification_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/student/student_bloc.dart';
import 'package:swallet_mobile/presentation/screens/student_features/challenge_daily/challenge_daily_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/notification/notification_list_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/voucher/components/tab_isused_voucher.dart';
import 'package:swallet_mobile/presentation/screens/student_features/voucher/components/tab_voucher.dart';
import 'package:swallet_mobile/presentation/screens/student_features/voucher_history/components/body_voucher_history.dart';
import 'package:swallet_mobile/presentation/widgets/unverified_screen.dart';

class Body extends StatefulWidget {
  const Body({super.key, required this.studentId});
  final String studentId;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  late TabController _controller;
  // ignore: unused_field
  int _selectedIndex = 0;

  List<Widget> list = [Tab(text: 'Sẵn có'), Tab(text: 'Đã sử dụng')];

  @override
  void initState() {
    _controller = TabController(length: list.length, vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
        // context.read<StoreBloc>().add(
        //     LoadStoreTransactions(typeIds: _selectedIndex, id: widget.storeId));
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                      } else {}
                    },
                    child: const Text('Đồng ý'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: NestedScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                elevation: 0,
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
                    'Swallet',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontSize: 22 * ffem,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
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
                actions: [
                  Padding(
                    padding: EdgeInsets.only(top: 5 * hem, right: 20 * fem),
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
                bottom: TabBar(
                  controller: _controller,
                  indicatorColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 2,
                  // indicatorPadding: EdgeInsets.only(bottom: 1 * fem),
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
                  tabs: list,
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _controller,
            children: [
              BlocProvider(
                create:
                    (context) => StudentBloc(
                      studentRepository: context.read<StudentRepository>(),
                    )..add(
                      LoadStudentVouchers(id: widget.studentId, isUsed: false),
                    ),
                child: TabVoucher(studentId: widget.studentId),
              ),
              BlocProvider(
                create:
                    (context) => StudentBloc(
                      studentRepository: context.read<StudentRepository>(),
                    ),
                child: BodyVoucherHistory(studentId: widget.studentId),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
