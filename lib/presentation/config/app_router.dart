import 'package:flutter/material.dart';
import 'package:swallet_mobile/data/models/lecture_features/lecture_model.dart';
import 'package:swallet_mobile/data/models/lecture_features/qr_response.dart';
import 'package:swallet_mobile/data/models/store_features/store_model.dart';
import 'package:swallet_mobile/data/models/student_features/student_model.dart';
import 'package:swallet_mobile/presentation/screens/lecture_features/landing_screen/landing_lecture_screen.dart';
import 'package:swallet_mobile/presentation/screens/lecture_features/profile_update_detail/profile_update_detail_screen.dart';
import 'package:swallet_mobile/presentation/screens/lecture_features/qr_generate/qr_generate_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/brand/brand_detail_store_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/campaign_detail/campaign_detail_store_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/campaign_voucher_detail/campaign_voucher_detail_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/failed_scan_voucher/failed_scan_voucher_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/landing_screen/landing_store_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/profile_update_detail/profile_update_detail_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/qr_view/qr_view_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/transact/transact_screen.dart';
import 'package:swallet_mobile/presentation/screens/login/login_screen.dart';
import 'package:swallet_mobile/presentation/screens/splash/onboarding_screen.dart';
import 'package:swallet_mobile/presentation/screens/splash/splash_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/voucher_history/voucher_history.dart';
import 'package:swallet_mobile/presentation/screens/student_features/brand_detail/brand_detail_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/brand_list/brand_list_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/buy_failed/buy_failed_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/campaign/campaign_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/campaign_detail/campaign_detail_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/campaign_voucher/campaign_voucher_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/challenge/challenge_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/challenge_daily/challenge_daily_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/check_in/check_in_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/landing/landing_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/location_checkin/location_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/lucky_wheel/lucky_wheel_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/notification/notification_list_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/notification/notification_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/profile_detail/profile_detail_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/profile_history/profile_trans_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/profile_update_detail/profile_update_detail_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/profile_verification/profile_verification_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/profile_verification/update_verification_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/qr/qr_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/qr/qr_voucher_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/qr_view/qr_student_view_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/qr_view/success-scren.dart';
import 'package:swallet_mobile/presentation/screens/student_features/redeem_voucher/redeem_voucher_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_1_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_2_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_3_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_4_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_5_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_6_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_7_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_9_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/store_list/store_list_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/success_redeem_voucher/success_redeem_voucher_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/verify_studentMail/screens/verifycode_student_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/voucher/voucher_list_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/voucher/voucher_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/verify_email/screens/verifycode_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/voucher_history/voucher_history.dart';
import 'package:swallet_mobile/presentation/screens/student_features/voucher_item_detail/voucher_item_detail_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/welcome/welcome_screen.dart';
import 'package:swallet_mobile/presentation/screens/success_scan_voucher/success_scan_voucher_screen.dart';
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

      case QRGenerateScreen.routeName: // '/qr-generate'
        return QRGenerateScreen.route(lectureId: settings.arguments as String);

      case WelcomeScreen.routeName:
        return WelcomeScreen.route();

      case CheckInScreen.routeName:
        return CheckInScreen.route();

      case LoginScreen.routeName:
        return LoginScreen.route();

      case VerifyCodeScreen.routeName:
        return VerifyCodeScreen.route(email: settings.arguments as String);

      case VerifyCodeStudentScreen.routeName:
        return VerifyCodeStudentScreen.route(
          email: settings.arguments as String,
        );

      case SuccessScanLectureQRScreen.routeName:
        return SuccessScanLectureQRScreen.route(
          response: settings.arguments as ScanQRResponse,
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
        return NotificationScreen.route(data: settings.arguments as dynamic);

      case NotificationListScreen.routeName:
        return NotificationListScreen.route();

      case StoreListScreen.routeName:
        List<dynamic> args = settings.arguments as List<dynamic>;
        return StoreListScreen.route(
          brandId: args[0],
          campaignDetailModel: args[1],
        );

      case QRScreen.routeName:
        return QRScreen.route(id: settings.arguments as String);

      case ChallengeScreen.routeName:
        return ChallengeScreen.route();
      
      case ChallengeDailyScreen.routeName:
        return ChallengeDailyScreen.route();

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
      case CampaignVoucherDetailStoreScreen.routeName:
        List<dynamic> args = settings.arguments as List<dynamic>;
        return CampaignVoucherDetailStoreScreen.route(
          campaignId: args[0],
          campaignVoucherId: args[1],
        );
      case VoucherScreen.routeName:
        return VoucherScreen.route();
      
      case LocationListScreen.routeName:
        return LocationListScreen.route();

      case VoucherListScreen.routeName:
        List<dynamic> args = settings.arguments as List<dynamic>;
        return VoucherListScreen.route(
          search: args[0],
          studentId: args[1],
        );  

      case VoucherItemDetailScreen.routeName:
        final args = settings.arguments as Map<String, String>;
        return VoucherItemDetailScreen.route(
          campaignId: args['campaignId']!,
          voucherId: args['voucherId']!,
        );
        
      case VoucherHistoryScreen.routeName:
        return VoucherHistoryScreen.route(
          studentId: settings.arguments as String,
        );

      case VoucherHistoryScreenStore.routeName:
        return VoucherHistoryScreenStore.route();
          
      case RedeemVoucherScreen.routeName:
        List<dynamic> args = settings.arguments as List<dynamic>;

        return RedeemVoucherScreen.route(
          campignId: args[0],
          campaignDetailId: args[1],
          studentId: args[2],
          quantity: args[3],
          description: args[4],
          campaignName: args[5],
          total: args[6],
          voucherName: args[7],
          priceVoucher: args[8],
        );

      case SuccessRedeemVoucherScreen.routeName:
        List<dynamic> args = settings.arguments as List<dynamic>;
        return SuccessRedeemVoucherScreen.route(
          voucherName: args[0],
          total: args[1],
        );

      case FailedBuyScreen.routeName:
        return FailedBuyScreen.route(failed: settings.arguments as String);

      case ProfileDetailScreen.routeName:
        return ProfileDetailScreen.route(
          studentModel: settings.arguments as StudentModel,
        );

      case ProfileUpdateDetailLectureScreen.routeName:
        return ProfileUpdateDetailLectureScreen.route(
          lectureModel: settings.arguments as LectureModel,
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

      case ProfileTransactionHistoryScreen.routeName:
        return ProfileTransactionHistoryScreen.route(
          studentId: settings.arguments as String,
        );

      case QRVoucherScreen.routeName:
        return QRVoucherScreen.route(id: settings.arguments as String);

      case QrViewScreen.routeName:
        return QrViewScreen.route(storeId: settings.arguments as String);

      case QrStudentViewScreen.routeName:
        return QrStudentViewScreen.route(
          studentId: settings.arguments as String,
        );

      case ProfileUpdateDetailStoreScreen.routeName:
        return ProfileUpdateDetailStoreScreen.route(
          storeModel: settings.arguments as StoreModel,
        );

      case BrandDetailScreen.routeName:
        return BrandDetailScreen.route(id: settings.arguments as String);

      case BrandListScreen.routeName:
        return BrandListScreen.route();

      case BrandDetailStoreScreen.routeName:
        return BrandDetailStoreScreen.route(id: settings.arguments as String);

      case TransactScreen.routeName:
        List<dynamic> args = settings.arguments as List<dynamic>;
        return TransactScreen.route(studentModel: args[0], brandId: args[1]);

      // case CampaignVoucherInformationScreen.routeName:
      //   return CampaignVoucherInformationScreen.route(
      //     campaginVoucherInformation:
      //         settings.arguments as CampaignVoucherInformationModel,
      //   );
      case SuccessScanVoucherScreen.routeName:
        return SuccessScanVoucherScreen.route(
          success: settings.arguments as String,
        );

      case FailedScanVoucherScreen.routeName:
        return FailedScanVoucherScreen.route(
          failed: settings.arguments as String,
        );
        
      case CampaignVoucherScreen.routeName:
        List<dynamic> args = settings.arguments as List<dynamic>;

        return CampaignVoucherScreen.route(
          campaignDetail: args[0],
          campaignVoucher: args[1],
          accountId: args[2],
        );
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
