import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/step_1/body1.dart';
import 'package:swallet_mobile/presentation/widgets/internet_listener.dart';

class SignUp1Screen extends StatefulWidget {
  static const String routeName = '/signup_1';

  static Route route({required bool register}) {
    return MaterialPageRoute(
      builder: (_) => SignUp1Screen(register: register),
      settings: const RouteSettings(arguments: routeName),
    );
  }

  final bool register;

  /// Luồng đăng ký đầy đủ (9 bước) hay rút gọn (8 bước).
  ///
  /// Trước đây khai báo `late` nên vào thẳng một bước bất kỳ mà chưa qua màn
  /// này là ném `LateInitializationError`. Mặc định false cho an toàn.
  static bool defaultRegister = false;

  const SignUp1Screen({required this.register, super.key});

  @override
  State<SignUp1Screen> createState() => _SignUp1ScreenState();
}

class _SignUp1ScreenState extends State<SignUp1Screen> {
  late final String title;

  @override
  void initState() {
    super.initState();
    SignUp1Screen.defaultRegister = widget.register;
    title = widget.register ? 'Bước 2/9' : 'Bước 1/8';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final hem = size.height / 812;
    final ffem = fem * 0.97;

    return InternetListener(
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            toolbarHeight: 120 * hem,
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            leading: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.arrow_back),
            ),
            title: Text(
              title,
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 15 * ffem,
                  fontWeight: FontWeight.w900,
                  height: 1.3625 * ffem / fem,
                  color: kLowTextColor,
                ),
              ),
            ),
          ),
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          body: const Body1(),
        ),
      ),
    );
  }
}
