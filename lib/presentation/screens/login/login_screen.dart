import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:swallet_mobile/presentation/config/app_injection.dart';
import 'package:swallet_mobile/presentation/screens/login/components/body.dart';
import 'package:swallet_mobile/presentation/widgets/internet_listener.dart';

@Preview(
  name: 'Login Screen - Connected',
  size: Size(
    375,
    812,
  ), // Định cấu hình kích thước chuẩn điện thoại giống QR Screen
)
Widget anyScreenPreview() {
  return const AppInjection(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(), // Đổi tên trang bạn muốn xem vào đây là xong
    ),
  );
}

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';
  static Route route() {
    return PageRouteBuilder(
      pageBuilder: (_, _, _) => const LoginScreen(),
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (_, animation, _, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
      settings: const RouteSettings(name: routeName),
    );
  }

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InternetListener(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
          resizeToAvoidBottomInset: true,
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          body: const Body(),
        ),
      ),
    );
  }
}
