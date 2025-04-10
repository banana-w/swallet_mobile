import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/models/student_features/student_model.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/student_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/validation_repository.dart';
import 'package:swallet_mobile/presentation/blocs/student/student_bloc.dart';
import 'package:swallet_mobile/presentation/cubits/validation/validation_cubit.dart';

import '../../../../config/constants.dart';
import 'form_verification.dart';

class BodyVerification extends StatelessWidget {
  const BodyVerification({super.key, required this.studentModel});

  final StudentModel studentModel;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/bg_signup_1.png'),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 120 * hem),
                    MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create:
                              (context) => ValidationCubit(
                                context.read<ValidationRepository>(),
                              ),
                        ),
                        BlocProvider(
                          create:
                              (context) => StudentBloc(
                                studentRepository:
                                    context.read<StudentRepository>(),
                              ),
                        ),
                      ],
                      child: FormVerification(
                        fem: fem,
                        hem: hem,
                        ffem: ffem,
                        studentModel: studentModel,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget checkVerification(
    StudentModel studentModel,
    double fem,
    double hem,
    double ffem,
  ) {
    if (studentModel.status && studentModel.state == 1) {
      return Container(
        padding: EdgeInsets.only(right: 5 * fem, left: 5 * fem),
        height: 30 * hem,
        width: 100 * fem,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Color(0xfffb7eb8f)),
          color: Color(0xffff6ffed),
        ),
        child: Center(
          child: Text(
            'Đã xác minh',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 13 * ffem,
                height: 1.3625 * ffem / fem,
                fontWeight: FontWeight.w600,
                color: kPrimaryColor,
              ),
            ),
          ),
        ),
      );
    } else if (studentModel.status && studentModel.state == 2) {
      return Container(
        padding: EdgeInsets.only(right: 5 * fem, left: 5 * fem),
        height: 30 * hem,
        width: 120 * fem,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Color(0xfffffe58f)),
          color: kbgYellow,
        ),
        child: Center(
          child: Text(
            'Đang chờ duyệt',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 13 * ffem,
                height: 1.3625 * ffem / fem,
                fontWeight: FontWeight.w600,
                color: kYellow,
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(right: 5 * fem, left: 5 * fem),
        height: 30 * hem,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Color(0xfffffe58f)),
          color: kbgYellow,
        ),
        child: Center(
          child: Text(
            'Xác minh thất bại',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 13 * ffem,
                height: 1.3625 * ffem / fem,
                fontWeight: FontWeight.w600,
                color: kYellow,
              ),
            ),
          ),
        ),
      );
    }
  }
}
