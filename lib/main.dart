import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:swallet_mobile/data/datasource/api_client.dart';
import 'package:swallet_mobile/data/firebase/notification_service.dart';
import 'package:swallet_mobile/firebase_options.dart';
import 'package:swallet_mobile/presentation/blocs/notification/notification_bloc.dart';
import 'package:swallet_mobile/presentation/config/app_injection.dart';
import 'package:swallet_mobile/presentation/config/app_router.dart';
import 'package:swallet_mobile/presentation/screens/login/login_screen.dart';
import 'package:swallet_mobile/presentation/screens/splash/splash_screen.dart';
import 'package:swallet_mobile/simple_bloc_observer.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription<void>? _sessionExpiredSubscription;
  bool _handlingSessionExpiry = false;

  @override
  void initState() {
    super.initState();
    // Bất kỳ request đã xác thực nào nhận 401, ApiClient đã xoá session; ở đây
    // chỉ còn việc đưa người dùng về màn đăng nhập kèm thông báo, thay vì để
    // app kẹt ở màn loading như trước.
    _sessionExpiredSubscription = ApiClient.onSessionExpired.listen((_) {
      if (_handlingSessionExpiry) return;
      final navigator = navigatorKey.currentState;
      if (navigator == null) return;

      _handlingSessionExpiry = true;
      navigator.pushNamedAndRemoveUntil(
        LoginScreen.routeName,
        (route) => false,
      );
      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(
          content: Text('Phiên đăng nhập đã hết hạn, vui lòng đăng nhập lại.'),
        ),
      );
      _handlingSessionExpiry = false;
    });
  }

  @override
  void dispose() {
    _sessionExpiredSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppInjection(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: scaffoldMessengerKey,
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