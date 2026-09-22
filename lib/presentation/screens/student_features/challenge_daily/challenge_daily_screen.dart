import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/location/location_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/screens/student_features/challenge_daily/components/body.dart';
import 'package:swallet_mobile/presentation/screens/student_features/challenge_shared/challenge_mode.dart';
import 'package:swallet_mobile/presentation/screens/student_features/challenge_shared/challenge_role_gate.dart';

import '../../../config/constants.dart';

class ChallengeDailyScreen extends StatefulWidget {
  static const String routeName = '/challenge-daily-student';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const ChallengeDailyScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const ChallengeDailyScreen({super.key});

  @override
  State<ChallengeDailyScreen> createState() => _ChallengeDailyScreenState();
}

class _ChallengeDailyScreenState extends State<ChallengeDailyScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RoleAppBloc>().add(RoleAppStart());
    context.read<LocationBloc>().add(AddLocation());
    context.read<LocationBloc>().add(LoadLocation());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: klighGreyColor,
        body: const ChallengeRoleGate(
          mode: ChallengeMode.daily,
          body: ChallengeDailyBody(),
        ),
      ),
    );
  }
}
