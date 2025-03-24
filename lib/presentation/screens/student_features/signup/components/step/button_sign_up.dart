import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/cubits/validation/validation_cubit.dart';
import 'package:swallet_mobile/presentation/screens/student_features/signup/components/step/form_0.dart';
// import 'package:unibean_app/presentation/screens/signup/screens/signup_1_screen.dart';

class ButtonSignUp extends StatelessWidget {
  const ButtonSignUp({super.key, required this.widget, required this.onPress});

  final FormBody widget;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      child: Container(
        width: 220 * widget.fem,
        height: 45 * widget.hem,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(23 * widget.fem),
        ),
        child: BlocBuilder<ValidationCubit, ValidationState>(
          builder: (context, state) {
            if (state is ValidationInProcess) {
              return Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }
            return Center(
              child: Text(
                'Tiếp tục',
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: 17 * widget.ffem,
                    fontWeight: FontWeight.w600,
                    height: 1.3625 * widget.ffem / widget.fem,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
