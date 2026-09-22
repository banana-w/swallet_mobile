import 'package:flutter/material.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/signup_step_scaffold.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/step_5/body6.dart';

class SignUp5Screen extends StatelessWidget {
  static const String routeName = '/signup_5';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const SignUp5Screen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const SignUp5Screen({super.key});

  @override
  Widget build(BuildContext context) =>
      const SignUpStepScaffold(step: 5, body: Body6());
}
