import 'package:flutter/material.dart';
import 'package:swallet_mobile/data/models/student_features/student_model.dart';
import 'package:swallet_mobile/presentation/screens/student_features/campaign/campaign_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/challenge/challenge_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/lucky_wheel/lucky_wheel_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/profile_detail/profile_detail_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/profile_update_detail/profile_update_detail_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/profile_verification/profile_verification_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/qr/qr_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_1_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_2_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_3_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_4_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_5_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_6_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_7_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_9_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/voucher/voucher_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/verify_email/screens/verifycode_screen.dart';
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

      case VerifyCodeScreen.routeName:
        return VerifyCodeScreen.route(email: settings.arguments as String);

      case SignUpScreen.routeName:
        return SignUpScreen.route();

      case SignUp1Screen.routeName:
        return SignUp1Screen.route(register: settings.arguments as bool);

      case SignUp2Screen.routeName:
        return SignUp2Screen.route();

      case SignUp3Screen.routeName:
        return SignUp3Screen.route();

      case SignUp4Screen.routeName:
        return SignUp4Screen.route();

      case SignUp5Screen.routeName:
        return SignUp5Screen.route();

      case SignUp6Screen.routeName:
        return SignUp6Screen.route();

      case SignUp7Screen.routeName:
        return SignUp7Screen.route();

      case SignUp9Screen.routeName:
        return SignUp9Screen.route();

      case LuckyWheelScreen.routeName:
        return LuckyWheelScreen.route();

      case UnverifiedScreen.routeName:
        return UnverifiedScreen.route();

      case QRScreen.routeName:
        return QRScreen.route(id: settings.arguments as String);

      case ChallengeScreen.routeName:
        return ChallengeScreen.route();

      case CampaignScreen.routeName:
        return CampaignScreen.route();

      case VoucherScreen.routeName:
        return VoucherScreen.route();

      case ProfileDetailScreen.routeName:
        return ProfileDetailScreen.route(
          studentModel: settings.arguments as StudentModel,
        );

      case ProfileVerificationScreen.routeName:
        return ProfileVerificationScreen.route(
          studentModel: settings.arguments as StudentModel,
        );

      case ProfileUpdateDetailScreen.routeName:
        return ProfileUpdateDetailScreen.route(
          studentModel: settings.arguments as StudentModel,
        );

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
