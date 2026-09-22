import 'package:flutter/material.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/step/body.dart';
import 'package:swallet_mobile/presentation/widgets/app_bar_signup.dart';
import 'package:swallet_mobile/presentation/widgets/internet_listener.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = '/signup';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const SignUpScreen(),
      settings: const RouteSettings(arguments: SignUpScreen.routeName),
    );
  }

  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final hem = size.height / 812;
    final ffem = fem * 0.97;

    return InternetListener(
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBarSignUp(
            hem: hem,
            ffem: ffem,
            fem: fem,
            text: 'Bước 1/9',
          ),
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          body: const Body(),
        ),
      ),
    );
  }
}
