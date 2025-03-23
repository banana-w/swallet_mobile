import 'package:flutter/material.dart';

import 'components/body.dart';

class OnBoardingScreen extends StatelessWidget {
  static const String routeName = '/onboarding';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const OnBoardingScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: const Body(),
    );
  }
}
