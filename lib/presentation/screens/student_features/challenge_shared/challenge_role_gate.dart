import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/challenge_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/student_repository.dart';
import 'package:swallet_mobile/presentation/blocs/challenge/challenge_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/widgets/card_for_unverified.dart';

import '../../../config/constants.dart';
import 'challenge_mode.dart';

/// Chỉ dựng danh sách thử thách khi tài khoản đã được xác thực.
///
/// Hai màn thử thách trước đây chép lại y hệt khối điều kiện này.
class ChallengeRoleGate extends StatelessWidget {
  const ChallengeRoleGate({super.key, required this.mode, required this.body});

  final ChallengeMode mode;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    return BlocBuilder<RoleAppBloc, RoleAppState>(
      builder: (context, roleState) {
        if (roleState is RoleAppLoading) {
          return Center(
            child: Lottie.asset('assets/animations/loading-screen.json'),
          );
        }

        if (roleState is! Verified) {
          return Center(
            child: CardForUnVerified(fem: fem, hem: hem, ffem: ffem),
          );
        }

        return BlocProvider(
          create:
              (context) => ChallengeBloc(
                challengeRepository: context.read<ChallengeRepository>(),
                studentRepository: context.read<StudentRepository>(),
              )..add(mode.reloadEvent),
          child: DefaultTabController(
            length: 3,
            child: Scaffold(backgroundColor: klighGreyColor, body: body),
          ),
        );
      },
    );
  }
}
