import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
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
    // Load dữ liệu challenge khi màn hình được khởi tạo
    context.read<ChallengeBloc>().add(LoadDailyChallenge());
    context.read<RoleAppBloc>().add(RefreshStudentData());
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
          return BlocBuilder<ChallengeBloc, ChallengeState>(
            builder: (context, challengeState) {
              if (challengeState is ChallengeLoading) {
                return Center(
                  child: Lottie.asset('assets/animations/loading-screen.json'),
                );
              }

              if (challengeState is ChallengesLoaded) {
                return ChallengeDailyBody();
              }
              return ChallengeDailyBody();
            },
          );
        }
        return Center(child: CardForUnVerified(fem: fem, hem: hem, ffem: ffem));
      },
    );
  }
}
