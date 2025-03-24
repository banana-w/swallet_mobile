import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:swallet_mobile/domain/interface_repositories/student_features/student_repository.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/student/student_bloc.dart';
import 'package:swallet_mobile/presentation/widgets/card_for_unverified.dart';
import 'package:swallet_mobile/presentation/screens/student_features/voucher/components/body.dart';

import '../../../config/constants.dart';
import '../../../widgets/app_bar_campaign.dart';

class VoucherScreen extends StatelessWidget {
  static const String routeName = '/voucher-student';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const VoucherScreen(),
      settings: const RouteSettings(arguments: routeName),
    );
  }

  const VoucherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    final roleState = context.watch<RoleAppBloc>().state;

    return authenScreen(roleState, fem, hem, ffem, context);
  }

  Widget authenScreen(roleState, fem, hem, ffem, context) {
    if (roleState is Unverified) {
      return _buildUnverified(fem, hem, ffem);
    } else if (roleState is Verified) {
      return BlocProvider(
        create:
            (context) => StudentBloc(
              studentRepository: context.read<StudentRepository>(),
            )..add(
              LoadStudentVouchers(id: roleState.studentModel.id, isUsed: false),
            ),
        child: _buildVerifiedStudent(fem, hem, ffem, roleState.studentModel.id),
      );
    }
    return Center(
      child: Container(
        child: Lottie.asset('assets/animations/loading-screen.json'),
      ),
    );
  }

  Widget _buildUnverified(double fem, double hem, double ffem) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: klighGreyColor,
        appBar: AppBarCampaign(hem: hem, ffem: ffem, fem: fem),
        body: Container(
          color: klighGreyColor,
          child: Center(
            child: CardForUnVerified(fem: fem, hem: hem, ffem: ffem),
          ),
        ),
      ),
    );
  }

  Widget _buildVerifiedStudent(
    double fem,
    double hem,
    double ffem,
    String studentId,
  ) {
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        if (state is StudentVouchersLoaded) {
          return Body(studentId: studentId);
        } else if (state is StudentVoucherLoading) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: klighGreyColor,
              appBar: AppBarCampaign(hem: hem, ffem: ffem, fem: fem),
              body: Center(
                child: Lottie.asset('assets/animations/loading-screen.json'),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
