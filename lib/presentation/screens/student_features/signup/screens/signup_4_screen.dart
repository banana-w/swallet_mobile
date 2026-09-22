import 'package:flutter/material.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/signup_step_scaffold.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/step_4/body_4.dart';

class SignUp4Screen extends StatelessWidget {
  static const String routeName = '/signup_4';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const SignUp4Screen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const SignUp4Screen({super.key});

  @override
  Widget build(BuildContext context) =>
      const SignUpStepScaffold(step: 4, body: Body4());
}
