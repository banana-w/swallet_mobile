import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/presentation/blocs/landing_screen/landing_screen_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/cubits/verification/verification_cubit.dart';


class OTPForm extends StatefulWidget {
  const OTPForm({
    super.key,
    required this.fem,
    required this.hem,
    required this.defaultPinTheme,
    required this.ffem,
    required this.email,
  });

  final double fem;
  final double hem;
  final PinTheme defaultPinTheme;
  final double ffem;
  final String email;

  @override
  State<OTPForm> createState() => _OTPFormState();
}

class _OTPFormState extends State<OTPForm> {
  final _formKey = GlobalKey<FormState>();
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  String? errorString;
  late DateTime _endTime; // Add property to store end time
  bool isTimerExpired = false;

  @override
  void initState() {
    super.initState();
    // Initialize end time only once
    _endTime = DateTime.now().add(Duration(seconds: 10));
  }

  @override
  Widget build(BuildContext context) {
    Widget buttonWidget = _buildButton();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            width: 350 * widget.fem,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15 * widget.fem),
              boxShadow: [
                BoxShadow(
                  color: Color(0x0c000000),
                  offset: Offset(0 * widget.fem, 4 * widget.fem),
                  blurRadius: 2.5 * widget.fem,
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(height: 22 * widget.hem),
                Pinput(
                  controller: pinController,
                  focusNode: focusNode,
                  length: 6,
                  defaultPinTheme: widget.defaultPinTheme,
                  focusedPinTheme: widget.defaultPinTheme,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mã xác nhận';
                    }
                    return null;
                  },
                ),
                errorString != null
                    ? Padding(
                      padding: EdgeInsets.only(
                        top: 5 * widget.hem,
                        left: 5 * widget.fem,
                      ),
                      child: SizedBox(
                        width: 270 * widget.fem,
                        child: Text(
                          errorString.toString(),
                          style: GoogleFonts.openSans(
                            fontSize: 13 * widget.ffem,
                            fontWeight: FontWeight.normal,
                            height: 1.3625 * widget.ffem / widget.fem,
                            color: kErrorTextColor,
                          ),
                        ),
                      ),
                    )
                    : SizedBox(height: 5 * widget.hem),
                SizedBox(height: 20 * widget.hem),
              ],
            ),
          ),
          SizedBox(height: 20 * widget.hem),
          TimerCountdown(
            // Removed the key parameter as it is not defined
            spacerWidth: 5,
            colonsTextStyle: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 13 * widget.ffem,
                color: Colors.green,
                fontWeight: FontWeight.w800,
              ),
            ),
            timeTextStyle: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 15 * widget.ffem,
                color: Colors.green,
                fontWeight: FontWeight.w800,
              ),
            ),
            format: CountDownTimerFormat.secondsOnly,
            enableDescriptions: false,
            endTime: _endTime,
            onEnd: () {
              setState(() {
                isTimerExpired = true; // Cập nhật trạng thái khi hết thời gian
              });
              // if (Navigator.canPop(context)) {
              //   Navigator.pop(context);
              // }
            },
          ),
          SizedBox(height: 10 * widget.hem),
          if (isTimerExpired) // Hiển thị nút gửi lại khi hết thời gian
            TextButton(
              onPressed: () {
                _resendEmail(context); // Gọi hàm gửi lại email
              },
              child: Text(
                'Gửi lại email',
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: 14 * widget.ffem,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
          SizedBox(height: 10 * widget.hem),
          buttonWidget,
          SizedBox(height: 50 * widget.hem),
        ],
      ),
    );
  }

Widget _buildButton() {
    return BlocConsumer<VerificationCubit, VerificationState>(
      builder: (context, state) {
        return TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _submitForm(context, pinController);
            }
          },
          child: Container(
            width: 220 * widget.fem,
            height: 45 * widget.hem,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(23 * widget.fem),
            ),
            child: Center(
              child: Text(
                state is VerificationLoading ? 'Đang xác thực' : 'Xác nhận',
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: 17 * widget.ffem,
                    fontWeight: FontWeight.w600,
                    height: 1.3625 * widget.ffem / widget.fem,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) async {
        if (state is OTPVerificationFailed) {
          setState(() {
            errorString = state.error;
          });
        } else if (state is OTPVerificationSuccess) {
          await AuthenLocalDataSource.saveIsVerified(true);
          context.read<RoleAppBloc>().add(RoleAppStart());
          // context.read<ChallengeBloc>().add(LoadChallenge());
          // PushNotification().initNotifications();
          // PushNotification().localNotiInit();
          context.read<LandingScreenBloc>().add(TabChange(tabIndex: 0));
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/landing-screen',
            (Route<dynamic> route) => false,
          );
        }
      },
    );
  }
  void _submitForm(BuildContext context, TextEditingController pinController) {
    context.read<VerificationCubit>().verifyEmailCode(widget.email, pinController.text);
  }
  void _resendEmail(BuildContext context) {
    setState(() {
      _endTime = DateTime.now().add(Duration(seconds: 60)); // Reset thời gian
    });
    context.read<VerificationCubit>().resendVerificationEmail(widget.email);
  }
}
