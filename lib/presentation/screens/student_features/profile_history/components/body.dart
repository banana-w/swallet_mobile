import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/domain/interface_repositories/student_features/student_repository.dart';
import 'package:swallet_mobile/presentation/blocs/internet/internet_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/notification/notification_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/student/student_bloc.dart';
import 'package:swallet_mobile/presentation/screens/student_features/notification/notification_list_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/profile_history/components/activity_transaction.dart';

import 'all_transaction.dart';
import 'challenge_transaction.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.studentId});
  final String studentId;
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;

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
                toolbarHeight: 50 * hem,
                leading: InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(context,
                        '/landing-screen', (Route<dynamic> route) => false);
                  },
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 30 * fem,
                  ),
                ),
                centerTitle: true,
                title: Padding(
                  padding: EdgeInsets.only(top: 10 * hem),
                  child: Text(
                    'Swallet',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 25 * ffem,
                            fontWeight: FontWeight.w900,
                            color: Colors.white)),
                  ),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(top: 10 * hem, right: 20 * fem),
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
                              context
                                  .read<NotificationBloc>()
                                  .add(LoadNotification());
                              Navigator.pushNamed(
                                  context, NotificationListScreen.routeName);
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
                            Navigator.pushNamed(
                                context, NotificationListScreen.routeName);
                          },
                        );
                      },
                    ),
                  ),
                ],
                bottom: TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  automaticIndicatorColorAdjustment: false,
                  indicatorColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 3,
                  indicatorPadding: EdgeInsets.only(bottom: 1 * fem),
                  labelColor: Colors.white,
                  labelStyle: GoogleFonts.openSans(
                      textStyle: TextStyle(
                    fontSize: 13 * ffem,
                    fontWeight: FontWeight.w700,
                  )),
                  unselectedLabelColor: Colors.white60,
                  unselectedLabelStyle: GoogleFonts.openSans(
                      textStyle: TextStyle(
                    fontSize: 13 * ffem,
                    fontWeight: FontWeight.w700,
                  )),
                  tabs: [
                    Tab(
                      text: 'Tất cả',
                    ),
                    Tab(
                      text: 'Hoạt động',
                    ),
                    // Tab(
                    //   text: 'Đổi quà',
                    // ),
                    // Tab(
                    //   text: 'Thử thách',
                    // ),
                    // Tab(
                    //   text: 'Điểm thưởng',
                    // ),
                  ],
                ),
              )
            ];
          },
          body: TabBarView(
            children: [
              AllTransaction(
                hem: hem,
                fem: fem,
                ffem: ffem,
                studentId: studentId,
              ),
              BlocProvider(
                create: (context) => StudentBloc(
                    studentRepository: context.read<StudentRepository>())
                  ..add(LoadStudentTransactions(id: studentId, typeIds: 1)),
                child: ActivityTransaction(
                  hem: hem,
                  fem: fem,
                  ffem: ffem,
                  studentId: studentId,
                ),
              ),
              // BlocProvider(
              //   create: (context) => StudentBloc(
              //       studentRepository: context.read<StudentRepository>())
              //     ..add(LoadStudentTransactions(id: studentId, typeIds: 2)),
              //   // child: OrderTransaction(
              //   //   hem: hem,
              //   //   fem: fem,
              //   //   ffem: ffem,
              //   //   studentId: studentId,
              //   // ),
              // ),
              // BlocProvider(
              //   create: (context) => StudentBloc(
              //       studentRepository: context.read<StudentRepository>())
              //     ..add(LoadStudentTransactions(id: studentId, typeIds: 3)),
              //   child: ChallengeTransaction(
              //     hem: hem,
              //     fem: fem,
              //     ffem: ffem,
              //     studentId: studentId,
              //   ),
              // ),
              // BlocProvider(
              //   create: (context) => StudentBloc(
              //       studentRepository: context.read<StudentRepository>())
              //     ..add(LoadStudentTransactions(id: studentId, typeIds: 4)),
              //   // child: BonusTransaction(
              //   //   hem: hem,
              //   //   fem: fem,
              //   //   ffem: ffem,
              //   //   studentId: studentId,
              //   // ),
              // ),
            ],
          )),
    );
  }
}
