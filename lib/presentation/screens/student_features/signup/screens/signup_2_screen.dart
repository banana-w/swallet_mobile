import 'package:flutter/material.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/signup_step_scaffold.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/step_2/body_3.dart';

class SignUp2Screen extends StatelessWidget {
  static const String routeName = '/signup_2';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const SignUp2Screen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const SignUp2Screen({super.key});

  @override
  Widget build(BuildContext context) =>
      SignUpStepScaffold(step: 2, body: Body3());
}
