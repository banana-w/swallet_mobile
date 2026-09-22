import 'package:flutter/material.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/signup_step_scaffold.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/step_6/body_5.dart';

class SignUp6Screen extends StatelessWidget {
  static const String routeName = '/signup_6';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const SignUp6Screen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const SignUp6Screen({super.key});

  @override
  Widget build(BuildContext context) =>
      const SignUpStepScaffold(step: 6, body: Body5());
}
