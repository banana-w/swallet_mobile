import 'package:flutter/material.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/signup_step_scaffold.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/step_3/body_2.dart';

class SignUp3Screen extends StatelessWidget {
  static const String routeName = '/signup_3';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const SignUp3Screen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const SignUp3Screen({super.key});

  @override
  Widget build(BuildContext context) =>
      const SignUpStepScaffold(step: 3, body: Body2());
}
