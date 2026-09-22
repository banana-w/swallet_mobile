import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/screens/student_features/challenge/components/body.dart';
import 'package:swallet_mobile/presentation/screens/student_features/challenge_shared/challenge_mode.dart';
import 'package:swallet_mobile/presentation/screens/student_features/challenge_shared/challenge_role_gate.dart';

import '../../../config/constants.dart';

class ChallengeScreen extends StatefulWidget {
  static const String routeName = '/challenge-student';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const ChallengeScreen(),
      // Trước đây truyền routeName vào `arguments` thay vì `name`, nên route
      // này không có tên và mọi logic dựa trên tên route đều trượt.
      settings: const RouteSettings(name: routeName),
    );
  }

  const ChallengeScreen({super.key});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RoleAppBloc>().add(RoleAppStart());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: klighGreyColor,
        body: const ChallengeRoleGate(
          mode: ChallengeMode.achievement,
          body: ChallengeBody(),
        ),
      ),
    );
  }
}
