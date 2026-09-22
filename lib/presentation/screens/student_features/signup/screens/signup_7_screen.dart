import 'package:flutter/material.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/signup_step_scaffold.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/step_7/body_7.dart';

class SignUp7Screen extends StatelessWidget {
  static const String routeName = '/signup_7';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const SignUp7Screen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const SignUp7Screen({super.key});

  @override
  Widget build(BuildContext context) =>
      SignUpStepScaffold(step: 7, body: Body7());
}
