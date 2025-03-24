import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/data/models/student_features/student_model.dart';
import 'package:swallet_mobile/presentation/blocs/authentication/authentication_bloc.dart';

import '../../../../data/models.dart';
import '../../../blocs/blocs.dart';
import '../../../widgets/app_bar_signup.dart';
import '../../screens.dart';
import 'components/body_verification.dart';

class UpdateVerificationScreen extends StatelessWidget {
  static const String routeName = '/update-verification-student';
  static Route route({required StudentModel studentModel}) {
    return MaterialPageRoute(
      builder:
          (_) => BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationFailed)
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  LoginScreen.routeName,
                  (Route<dynamic> route) => false,
                );
            },
            child: UpdateVerificationScreen(studentModel: studentModel),
          ),
      settings: const RouteSettings(name: routeName),
    );
  }

  final StudentModel studentModel;
  const UpdateVerificationScreen({super.key, required this.studentModel});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBarSignUp(hem: hem, ffem: ffem, fem: fem, text: 'Xác minh'),
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: BodyVerification(studentModel: studentModel),
      ),
    );
  }
}
