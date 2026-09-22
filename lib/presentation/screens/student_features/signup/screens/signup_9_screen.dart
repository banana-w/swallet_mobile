import 'package:flutter/material.dart';

import '../../../../widgets/internet_listener.dart';
import '../components/step_9/body_9.dart';

class SignUp9Screen extends StatelessWidget {
  static const String routeName = '/signup_9';
  static Route route() {
    return PageRouteBuilder(
      pageBuilder: (_, _, _) => const SignUp9Screen(),
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (_, animation, _, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
      settings: const RouteSettings(name: routeName),
    );
  }

  const SignUp9Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InternetListener(
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          body: Body9(),
        ),
      ),
    );
  }
}
