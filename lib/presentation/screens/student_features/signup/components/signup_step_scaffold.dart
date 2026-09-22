import 'package:flutter/material.dart';

import '../../../../widgets/app_bar_signup.dart';
import '../../../../widgets/internet_listener.dart';
import '../screens/signup_1_screen.dart';

/// Khung chung cho các bước đăng ký.
///
/// Bảy màn `signup_2` … `signup_7` trước đây là bảy bản sao gần như từng ký tự
/// của nhau (~100 dòng mỗi màn), khác đúng ba chỗ: số thứ tự bước, widget thân
/// màn và tên route. Mỗi bản sao còn mang theo một bản sao của khối lắng nghe
/// mạng — nghĩa là bảy lần lặp lại cùng một lỗi hộp thoại không đóng được.
class SignUpStepScaffold extends StatelessWidget {
  const SignUpStepScaffold({super.key, required this.step, required this.body});

  /// Số thứ tự bước trong luồng đăng ký rút gọn (8 bước).
  ///
  /// Luồng đầy đủ có thêm một bước ở đầu nên nhãn hiển thị là `step + 1` trên
  /// tổng 9.
  final int step;

  final Widget body;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final hem = size.height / 812;
    final ffem = fem * 0.97;
    final title =
        SignUp1Screen.defaultRegister ? 'Bước ${step + 1}/9' : 'Bước $step/8';

    return InternetListener(
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBarSignUp(hem: hem, ffem: ffem, fem: fem, text: title),
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          body: body,
        ),
      ),
    );
  }
}
