import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:swallet_mobile/data/firebase/notification_service.dart';
import 'package:swallet_mobile/firebase_options.dart';
import 'package:swallet_mobile/presentation/blocs/notification/notification_bloc.dart';
import 'package:swallet_mobile/presentation/config/app_injection.dart';
import 'package:swallet_mobile/presentation/config/app_router.dart';
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

  @override
  Widget build(BuildContext context) {
    return AppInjection(
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
    );
  }
}