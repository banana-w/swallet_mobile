import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/internet/internet_bloc.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/step_6/body_5.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/screens/signup_1_screen.dart';
import 'package:swallet_mobile/presentation/widgets/app_bar_signup.dart';

class SignUp6Screen extends StatefulWidget {
  static const String routeName = '/signup_6';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => SignUp6Screen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const SignUp6Screen({super.key});

  @override
  State<SignUp6Screen> createState() => _SignUp6ScreenState();
}

class _SignUp6ScreenState extends State<SignUp6Screen> {
  late String title;

  @override
  void initState() {
    if (SignUp1Screen.defaultRegister == true) {
      title = 'Bước 7/9';
    } else {
      title = 'Bước 6/8';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    return BlocListener<InternetBloc, InternetState>(
      listener: (context, state) {
        if (state is Connected) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                elevation: 0,
                duration: const Duration(milliseconds: 2000),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Đã kết nối internet',
                  message: 'Đã kết nối internet!',
                  contentType: ContentType.success,
                ),
              ),
            );
        } else if (state is NotConnected) {
          showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: const Text('Không kết nối Internet'),
                content: Text('Vui lòng kết nối Internet'),
                actions: [
                  TextButton(
                    onPressed: () {
                      final stateInternet = context.read<InternetBloc>().state;
                      if (stateInternet is Connected) {
                        Navigator.pop(context);
                      } else {}
                    },
                    child: const Text('Đồng ý'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBarSignUp(hem: hem, ffem: ffem, fem: fem, text: title),
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          body: const Body5(),
        ),
      ),
    );
  }
}
