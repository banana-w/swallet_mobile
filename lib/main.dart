import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:swallet_mobile/data/firebase/notification_service.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/check_in_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/wishlist_repository.dart';
import 'package:swallet_mobile/data/repositories/authen_repository_imp.dart';
import 'package:swallet_mobile/data/repositories/lecture_features/lecture_repository_imp.dart';
import 'package:swallet_mobile/data/repositories/store_features/store_repository_imp.dart';
import 'package:swallet_mobile/data/repositories/student_features/brand_repository_imp.dart';
import 'package:swallet_mobile/data/repositories/student_features/campaign_repository_imp.dart';
import 'package:swallet_mobile/data/repositories/student_features/campus_repository.dart';
import 'package:swallet_mobile/data/repositories/student_features/challenge_repository_imp.dart';
import 'package:swallet_mobile/data/repositories/student_features/check_in_repository_imp.dart';
import 'package:swallet_mobile/data/repositories/student_features/lucky_prize_repository.dart';
import 'package:swallet_mobile/data/repositories/student_features/student_repository_imp.dart';
import 'package:swallet_mobile/data/repositories/student_features/validation_repository_imp.dart';
import 'package:swallet_mobile/data/repositories/student_features/verification_repository_imp.dart';
import 'package:swallet_mobile/data/repositories/student_features/wheel_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/authentication_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/lecture_features/lecture_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/store_features/store_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/brand_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/campaign_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/campus_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/challenge_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/student_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/validation_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/verification_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/wheel_repository.dart';
import 'package:swallet_mobile/data/repositories/student_features/wishlist_repository.dart';
import 'package:swallet_mobile/firebase_options.dart';
import 'package:swallet_mobile/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/brand/brand_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/campaign/campaign_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/campus/campus_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/challenge/challenge_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/checkin_bloc/check_in_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/internet/internet_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/landing_screen/landing_screen_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/lecture/lecture_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/location/location_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/notification/notification_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/ranking/ranking_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/store/store_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/wishlist/wishlist_bloc.dart';
import 'package:swallet_mobile/presentation/config/app_router.dart';
import 'package:swallet_mobile/presentation/cubits/validation/validation_cubit.dart';
import 'package:swallet_mobile/presentation/cubits/verification/verification_cubit.dart';
import 'package:swallet_mobile/presentation/screens/lecture_features/landing_screen/components/cus_nav_bar_lecture.dart';
import 'package:swallet_mobile/presentation/screens/splash/splash_screen.dart';
import 'package:swallet_mobile/simple_bloc_observer.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final notificationBloc = NotificationBloc();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await NotificationService.instance.initialize();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor:
          Colors.transparent, // Trong suốt để hiển thị nội dung phía sau
      statusBarIconBrightness: Brightness.dark, // Biểu tượng màu tối (đen)
      statusBarBrightness: Brightness.light, // Dành cho iOS
    ),
  );
  await Future.delayed(const Duration(seconds: 2));

  try {
    await Hive.initFlutter();
    // Mở box và lưu trữ tham chiếu
    await Hive.openBox('myBox');
  } catch (e) {
    // Xử lý lỗi nếu Hive không khởi tạo được
    print('Error initializing Hive: $e');
  }
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp()); // Removed const
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (_) => AuthenticationRepositoryImp(),
        ),
        RepositoryProvider<StudentRepository>(
          create: (_) => StudentRepositoryImp(),
        ),
        RepositoryProvider<StoreRepository>(
          create: (_) => StoreRepositoryImp(),
        ),
        RepositoryProvider<CampusRepository>(
          create: (_) => CampusRepositoryImp(),
        ),
        RepositoryProvider<ValidationRepository>(
          create: (_) => ValidationRepositoryImp(),
        ),
        RepositoryProvider<CampaignRepository>(
          create: (_) => CampaignRepositoryImp(),
        ),
        RepositoryProvider<LuckyPrizeRepository>(
          create: (_) => LuckyPrizeRepository(),
        ),
        RepositoryProvider<VerificationRepository>(
          create: (_) => VerificationRepositoryImp(),
        ),
        RepositoryProvider<StoreRepository>(
          create: (_) => StoreRepositoryImp(),
        ),
        RepositoryProvider<BrandRepository>(
          create: (_) => BrandRepositoryImp(),
        ),
        RepositoryProvider<ChallengeRepository>(
          create: (_) => ChallengeRepositoryImp(),
        ),
        RepositoryProvider<LectureRepository>(
          create: (_) => LectureRepositoryImp(),
        ),
        RepositoryProvider<BrandRepository>(
          create: (_) => BrandRepositoryImp(),
        ),
        RepositoryProvider<SpinHistoryRepository>(
          create: (_) => SpinHistoryRepositoryImpl(),
        ),
        RepositoryProvider<CheckInRepository>(
          create: (_) => CheckInRepositoryImpl(),
        ),
        RepositoryProvider<WishListRepository>(
          create: (_) => WishListRepositoryImp(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => InternetBloc()),
          BlocProvider(
            create: (context) => notificationBloc..add(LoadNotification()),
          ),
          BlocProvider(create: (context) => LandingScreenBloc()),
          BlocProvider(
            create:
                (context) => RoleAppBloc(
                  StudentRepositoryImp(),
                  StoreRepositoryImp(),
                  LectureRepositoryImp(),
                )..add(RoleAppStart()),
          ),
          BlocProvider(
            create:
                (context) => AuthenticationBloc(
                  authenticationRepository: AuthenticationRepositoryImp(),
                )..add(StartAuthen()),
          ),
          BlocProvider(
            create:
                (context) =>
                    ValidationCubit(ValidationRepositoryImp())
                      ..loadingValidation(),
          ),
          BlocProvider(
            create:
                (context) =>
                    VerificationCubit(VerificationRepositoryImp())
                      ..loadingVerification(),
          ),
          BlocProvider(
            create:
                (context) => ChallengeBloc(
                  challengeRepository: ChallengeRepositoryImp(),
                  studentRepository: StudentRepositoryImp(),
                ),
          ),
          BlocProvider(
            create:
                (context) =>
                    CampusBloc(CampusRepositoryImp())
                      ..add(LoadCampus(searchName: '')),
          ),
          BlocProvider(
            create:
                (context) => RoleAppBloc(
                  StudentRepositoryImp(),
                  StoreRepositoryImp(),
                  LectureRepositoryImp(),
                )..add(RoleAppStart()),
          ),
          BlocProvider(
            create:
                (context) =>
                    StoreBloc(storeRepository: StoreRepositoryImp())
                      ..add(LoadStoreCampaignVouchers()),
          ),
          BlocProvider(
            create:
                (context) =>
                    RankingBloc(storeRepository: StoreRepositoryImp())
                      ..add(LoadCampaignRanking()),
          ),

          BlocProvider(
            create:
                (context) =>
                    LectureBloc(lectureRepository: LectureRepositoryImp()),
          ),
          BlocProvider(
            create:
                (context) =>
                    BrandBloc(brandRepository: BrandRepositoryImp())
                      ..add(LoadBrands(page: 1, size: 10)),
          ),
          BlocProvider(
            create:
                (context) =>
                    CampaignBloc(campaignRepository: CampaignRepositoryImp())
                      ..add(LoadCampaigns()),
          ),
          BlocProvider(
            create:
                (context) =>
                    LocationBloc(ChallengeRepositoryImp())..add(AddLocation()),
          ),
          BlocProvider(
            create: (context) => CheckInBloc(CheckInRepositoryImpl()),
          ),
          BlocProvider(
            create: (context) => LandingScreenBloc(),
            child: CusNavLectureBar(),
          ),
          BlocProvider(
            create:
                (context) => WishlistBloc(
                  studentRepository: StudentRepositoryImp(),
                  wishListRepository: WishListRepositoryImp(),
                )..add(LoadWishListByStudentId()),
          ),
        ],
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'SWallet',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
          ),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: SplashScreen.routeName,
        ),
      ),
    );
  }
}
