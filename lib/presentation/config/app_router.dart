import 'package:flutter/material.dart';
import 'package:swallet_mobile/data/models/store_features/campaign_voucher_information_model.dart';
import 'package:swallet_mobile/data/models/store_features/store_model.dart';
import 'package:swallet_mobile/data/models/student_features/student_model.dart';
import 'package:swallet_mobile/presentation/screens/lecture_features/landing_screen/landing_lecture_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/brand/brand_detail_store_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/campaign_detail/campaign_detail_store_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/campaign_voucher_information/campaign_vouher_information_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/landing_screen/landing_store_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/profile_update_detail/profile_update_detail_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/qr_view/qr_view_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/transact/transact_screen.dart';
import 'package:swallet_mobile/presentation/screens/login/login_screen.dart';
import 'package:swallet_mobile/presentation/screens/splash/onboarding_screen.dart';
import 'package:swallet_mobile/presentation/screens/splash/splash_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/campaign/campaign_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/campaign_detail/campaign_detail_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/challenge/challenge_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/landing/landing_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/lucky_wheel/lucky_wheel_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/notification/notification_list_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/notification/notification_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/profile_detail/profile_detail_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/profile_update_detail/profile_update_detail_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/profile_verification/profile_verification_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/profile_verification/update_verification_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/qr/qr_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/qr/qr_voucher_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_1_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_2_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_3_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_4_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_5_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_6_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_7_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_9_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/verify_studentMail/screens/verifycode_student_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/voucher/voucher_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/verify_email/screens/verifycode_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/welcome/welcome_screen.dart';
import 'package:swallet_mobile/presentation/widgets/unverified_screen.dart';

class AppRouter {
  // static final LandingScreenBloc landingScreenBloc = LandingScreenBloc();
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/landing-screen':
        return MaterialPageRoute(builder: (_) => const LandingScreen());
      case SplashScreen.routeName:
        return SplashScreen.route();

      case '/landing-screen-store':
        return MaterialPageRoute(builder: (_) => const LandingStoreScreen());

      case '/landing-screen-lecture':
        return MaterialPageRoute(builder: (_) => const LandingLectureScreen());

      case OnBoardingScreen.routeName:
        return OnBoardingScreen.route();

      case WelcomeScreen.routeName:
        return WelcomeScreen.route();

      case LoginScreen.routeName:
        return LoginScreen.route();

      case VerifyCodeScreen.routeName:
        return VerifyCodeScreen.route(email: settings.arguments as String);

      case VerifyCodeStudentScreen.routeName:
        return VerifyCodeStudentScreen.route(
          email: settings.arguments as String,
        );

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

      case NotificationScreen.routeName:
        return NotificationScreen.route(data: null);

      case NotificationListScreen.routeName:
        return NotificationListScreen.route();

      case QRScreen.routeName:
        return QRScreen.route(id: settings.arguments as String);

      case ChallengeScreen.routeName:
        return ChallengeScreen.route();

      case CampaignScreen.routeName:
        return CampaignScreen.route();

      case CampaignDetailStoreScreen.routeName:
        return CampaignDetailStoreScreen.route(
          campaignId: settings.arguments as String,
        );
      case CampaignDetailStudentScreen.routeName:
        return CampaignDetailStudentScreen.route(
          campaignId: settings.arguments as String,
        );

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

      case UpdateVerificationScreen.routeName:
        return UpdateVerificationScreen.route(
          studentModel: settings.arguments as StudentModel,
        );

      case ProfileUpdateDetailScreen.routeName:
        return ProfileUpdateDetailScreen.route(
          studentModel: settings.arguments as StudentModel,
        );
      case QRVoucherScreen.routeName:
        return QRVoucherScreen.route(id: settings.arguments as String);

      case QrViewScreen.routeName:
        return QrViewScreen.route(storeId: settings.arguments as String);

      case ProfileUpdateDetailStoreScreen.routeName:
        return ProfileUpdateDetailStoreScreen.route(
          storeModel: settings.arguments as StoreModel,
        );

      // case BrandDetailScreen.routeName:
      //   return BrandDetailScreen.route(id: settings.arguments as String);

      // case BrandListScreen.routeName:
      //   return BrandListScreen.route();

      case BrandDetailStoreScreen.routeName:
        return BrandDetailStoreScreen.route(id: settings.arguments as String);

      //store
      // case TransactionStoreScreen.routeName:
      //   return TransactionStoreScreen.route();

      case TransactScreen.routeName:
        List<dynamic> args = settings.arguments as List<dynamic>;
        return TransactScreen.route(studentModel: args[0], brandId: args[1]);

      case CampaignVoucherInformationScreen.routeName:
        return CampaignVoucherInformationScreen.route(
          campaginVoucherInformation:
              settings.arguments as CampaignVoucherInformationModel,
        );

      // case BonusScreen.routeName:
      //   return BonusScreen.route(storeModel: settings.arguments as StoreModel);

      // case BonusDetailScreen.routeName:
      //   return BonusDetailScreen.route(bonusId: settings.arguments as String);

      // case CampaignDetailStoreScreen.routeName:
      //   return CampaignDetailStoreScreen.route(
      //       campaignId: settings.arguments as String);
      default:
        return _errorRoute();

      //store
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
