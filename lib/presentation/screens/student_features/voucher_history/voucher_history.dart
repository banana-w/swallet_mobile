import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/student_repository.dart';
import 'package:swallet_mobile/presentation/blocs/student/student_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

import 'components/body_voucher_history.dart';

class VoucherHistoryScreen extends StatelessWidget {
  static const String routeName = '/voucher-history-student';

  static Route route({required String studentId}) {
    return MaterialPageRoute(
      builder: (_) => VoucherHistoryScreen(studentId: studentId),
      settings: RouteSettings(arguments: studentId),
    );
  }

  const VoucherHistoryScreen({super.key, required this.studentId});

  final String studentId;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double baseHeight = 812;
    double ffem = fem * 0.97;
    double hem = MediaQuery.of(context).size.height / baseHeight;

    return BlocProvider(
      create: (context) => StudentBloc(studentRepository: context.read<StudentRepository>()),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: klighGreyColor,
          appBar: AppBar(
            elevation: 0,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background_splash.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            leading: InkWell(
              onTap: () {
                // Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/landing-screen',
                      (Route<dynamic> route) => false,
                    );
              },
              child: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 25 * fem,
              ),
            ),
            toolbarHeight: 50 * hem,
            centerTitle: true,
            title: Text(
              'Chi tiết sử dụng ưu đãi',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 18 * ffem,
                  fontWeight: FontWeight.w900,
                  height: 1.3625 * ffem / fem,
                  color: Colors.white,
                ),
              ),
            ),
            // actions: [
            //   Padding(
            //     padding: EdgeInsets.only(right: 20 * fem),
            //     child: IconButton(
            //       icon: Icon(Icons.home, color: Colors.white, size: 25 * fem),
            //       onPressed: () {
            //         Navigator.pushNamedAndRemoveUntil(
            //           context,
            //           '/landing-screen',
            //           (Route<dynamic> route) => false,
            //         );
            //       },
            //     ),
            //   ),
            // ],
          ),
          body: BodyVoucherHistory(studentId: studentId),
        ),
      ),
    );
  }
}
