import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/challenge_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/student_repository.dart';
import 'package:swallet_mobile/presentation/blocs/challenge/challenge_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/screens/student_features/challenge_daily/components/body.dart';
import 'package:swallet_mobile/presentation/widgets/card_for_unverified.dart';

import '../../../config/constants.dart';

class ChallengeDailyScreen extends StatefulWidget {
  static const String routeName = '/challenge-daily-student';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const ChallengeDailyScreen(),
      settings: const RouteSettings(
        name: routeName,
      ), // Sửa arguments thành name
    );
  }

  const ChallengeDailyScreen({super.key});

  @override
  State<ChallengeDailyScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeDailyScreen> {
  late double fem;
  late double ffem;
  late double hem;

  @override
  void initState() {
    super.initState();
    context.read<RoleAppBloc>().add(RoleAppStart());
  }

  @override
  Widget build(BuildContext context) {
    // Tính toán các giá trị responsive
    double baseWidth = 375;
    fem = MediaQuery.of(context).size.width / baseWidth;
    ffem = fem * 0.97;
    double baseHeight = 812;
    hem = MediaQuery.of(context).size.height / baseHeight;

    return SafeArea(
      child: Scaffold(
        backgroundColor: klighGreyColor,
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<RoleAppBloc, RoleAppState>(
      builder: (context, roleState) {
        if (roleState is RoleAppLoading) {
          return Center(
            child: Lottie.asset('assets/animations/loading-screen.json'),
          );
        }

        if (roleState is Unverified) {
          return Center(
            child: CardForUnVerified(fem: fem, hem: hem, ffem: ffem),
          );
        }

        if (roleState is Verified) {
          return BlocProvider(
            create:
                (context) => ChallengeBloc(challengeRepository: context.read<ChallengeRepository>(), studentRepository: context.read<StudentRepository>())
                ..add(LoadDailyChallenge()),
            child: SafeArea(
              child: DefaultTabController(
                length: 3,
                child: Scaffold(
                  backgroundColor: klighGreyColor,
                  body: ChallengeDailyBody(),
                ),
              ),
            ),
          );
        }
        return Center(child: CardForUnVerified(fem: fem, hem: hem, ffem: ffem));
      },
    );
  }
}
