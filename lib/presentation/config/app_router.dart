import 'package:flutter/material.dart';
import 'package:swallet_mobile/data/models.dart';
import 'package:swallet_mobile/data/models/student_features/student_model.dart';
import 'package:swallet_mobile/presentation/screens/profile_detail/profile_detail_screen.dart';
import 'package:swallet_mobile/presentation/widgets/unverified_screen.dart';
import '../screens/screens.dart';

class AppRouter {
  // static final LandingScreenBloc landingScreenBloc = LandingScreenBloc();
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/landing-screen':
        return MaterialPageRoute(builder: (_) => const LandingScreen());
      case SplashScreen.routeName:
        return SplashScreen.route();

      case OnBoardingScreen.routeName:
        return OnBoardingScreen.route();

      case WelcomeScreen.routeName:
        return WelcomeScreen.route();

      case LoginScreen.routeName:
        return LoginScreen.route();
        
       case ProfileDetailScreen.routeName:
        return ProfileDetailScreen.route(
            studentModel: settings.arguments as StudentModel);
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(appBar: AppBar(title: const Text('Error'))),
      settings: const RouteSettings(name: '/'),
    );
  }

  // void dispose() {
  //   landingScreenBloc.close();
  // }
}
