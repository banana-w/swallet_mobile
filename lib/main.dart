import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:swallet_mobile/data/repositories/authen_repository_imp.dart';
import 'package:swallet_mobile/data/repositories/store_features/store_repository_imp.dart';
import 'package:swallet_mobile/data/repositories/student_features/campus_repository.dart';
import 'package:swallet_mobile/data/repositories/student_features/student_repository_imp.dart';
import 'package:swallet_mobile/data/repositories/student_features/validation_repository_imp.dart';
import 'package:swallet_mobile/data/repositories/student_features/verification_repository_imp.dart';
import 'package:swallet_mobile/domain/interface_repositories/authentication_repository.dart';
import 'package:swallet_mobile/domain/interface_repositories/store_features/store_repository.dart';
import 'package:swallet_mobile/domain/interface_repositories/student_features/campus_repository.dart';
import 'package:swallet_mobile/domain/interface_repositories/student_features/student_repository.dart';
import 'package:swallet_mobile/domain/interface_repositories/student_features/validation_repository.dart';
import 'package:swallet_mobile/domain/interface_repositories/student_features/verification_repository.dart';
import 'package:swallet_mobile/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/campus/campus_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/internet/internet_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/landing_screen/landing_screen_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/config/app_router.dart';
import 'package:swallet_mobile/presentation/cubits/validation/validation_cubit.dart';
import 'package:swallet_mobile/presentation/cubits/verification/verification_cubit.dart';
import 'package:swallet_mobile/presentation/screens/splash/splash_screen.dart';
import 'package:swallet_mobile/simple_bloc_observer.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
        RepositoryProvider<VerificationRepository>(
          create: (_) => VerificationRepositoryImp(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => InternetBloc()),
          BlocProvider(create: (context) => LandingScreenBloc()),
          BlocProvider(
            create:
                (context) =>
                    RoleAppBloc(StudentRepositoryImp(), StoreRepositoryImp())
                      ..add(RoleAppStart()),
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
                (context) =>
                    CampusBloc(CampusRepositoryImp())
                      ..add(LoadCampus(searchName: '')),
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
