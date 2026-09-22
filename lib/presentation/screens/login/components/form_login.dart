import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/landing_screen/landing_screen_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/store/store_bloc.dart';
import 'package:swallet_mobile/presentation/screens/login/components/button_login.dart';
import 'package:swallet_mobile/presentation/screens/student_features/verify_email/screens/verifycode_screen.dart';
import 'package:swallet_mobile/presentation/widgets/text_form_field_default.dart';
import 'package:swallet_mobile/presentation/widgets/text_form_field_password.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({
    super.key,
    required this.fem,
    required this.hem,
    required this.ffem,
  });

  final double fem;
  final double hem;
  final double ffem;

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // AuthenticationBloc sống ở cấp app nên state của lần trước vẫn còn: quay
    // lại đây sau một lần đăng nhập hoặc đăng ký hỏng là form hiện sẵn lỗi cũ
    // dù người dùng chưa gõ gì. Đưa bloc về trạng thái ban đầu.
    context.read<AuthenticationBloc>().add(StartAuthen());
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthenticationBloc>().add(
        LoginAccount(
          userName: userNameController.text.trim(),
          password: passwordController.text,
        ),
      );
    }
  }

  /// Toàn bộ điều hướng sau đăng nhập nằm ở đây, không nằm trong `builder`.
  Future<void> _handleAuthState(
    BuildContext context,
    AuthenticationState state,
  ) async {
    switch (state) {
      case AuthenticationSuccess():
        context.read<RoleAppBloc>().add(const RoleAppStart());
        context.read<LandingScreenBloc>().add(TabChange(tabIndex: 0));
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/landing-screen',
          (route) => false,
        );
      case AuthenticationStoreSuccess():
        context.read<RoleAppBloc>().add(const RoleAppStart());
        context.read<StoreBloc>().add(LoadStoreCampaignVouchers());
        context.read<LandingScreenBloc>().add(TabChange(tabIndex: 0));
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/landing-screen-store',
          (route) => false,
        );
      case AuthenticationLectureSuccess():
        context.read<RoleAppBloc>().add(const RoleAppStart());
        context.read<LandingScreenBloc>().add(TabChange(tabIndex: 0));
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/landing-screen-lecture',
          (route) => false,
        );
      case AuthenticationSuccessButNotVerified():
        final authenData = await AuthenLocalDataSource.getAuthen();
        if (authenData == null) return;
        // Chặn lỗi Async Gap bảo vệ BuildContext trước khi điều hướng.
        if (!context.mounted) return;
        Navigator.pushNamed(
          context,
          VerifyCodeScreen.routeName,
          arguments: authenData.email,
        );
      case AuthenticationInitial():
      case AuthenticationInProcess():
      case AuthenticationFailed():
      case RegistrationSuccess():
        // RegistrationSuccess là của luồng đăng ký; màn đăng nhập vẫn còn
        // trong stack nên phải bỏ qua, nếu không nó sẽ nhảy vào trang chủ
        // ngay giữa các bước đăng ký.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listenWhen:
            (previous, current) =>
                current is AuthenticationSuccess ||
                current is AuthenticationStoreSuccess ||
                current is AuthenticationLectureSuccess ||
                current is AuthenticationSuccessButNotVerified,
        listener: _handleAuthState,
        builder: (context, state) {
          final isLoading = state is AuthenticationInProcess;
          return Column(
            children: [
              _LoginCard(
                fem: widget.fem,
                hem: widget.hem,
                ffem: widget.ffem,
                userNameController: userNameController,
                passwordController: passwordController,
                error: state is AuthenticationFailed ? state.error : null,
              ),
              SizedBox(height: 25 * widget.hem),
              ButtonLogin(
                fem: widget.fem,
                hem: widget.hem,
                ffem: widget.ffem,
                isLoading: isLoading,
                // Đang gọi API thì khoá nút, tránh bắn nhiều request đăng nhập.
                onPressed: isLoading ? null : _submit,
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Khung trắng chứa hai ô nhập và dòng lỗi (nếu có).
///
/// Trước đây đây là hai hàm `_buildAuthIntial` / `_buildAuthFailed` chép gần
/// như nguyên văn của nhau — khác mỗi dòng lỗi, khoảng cách đáy, và nhãn ô tài
/// khoản bị rụng mất dấu `*` ở bản lỗi.
class _LoginCard extends StatelessWidget {
  const _LoginCard({
    required this.fem,
    required this.hem,
    required this.ffem,
    required this.userNameController,
    required this.passwordController,
    required this.error,
  });

  final double fem;
  final double hem;
  final double ffem;
  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final String? error;

  String? _required(String? value, String message) {
    if (value == null || value.isEmpty) return message;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 318 * fem,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15 * fem),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0c000000),
            offset: Offset(0 * fem, 4 * fem),
            blurRadius: 2.5 * fem,
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 30 * hem),
          TextFormFieldDefault(
            hem: hem,
            fem: fem,
            ffem: ffem,
            labelText: 'TÀI KHOẢN *',
            hintText: 'Nhập tài khoản của bạn',
            validator:
                (value) => _required(value, 'Tài khoản không được bỏ trống'),
            textController: userNameController,
          ),
          SizedBox(height: 25 * hem),
          TextFormFieldPassword(
            hem: hem,
            fem: fem,
            ffem: ffem,
            labelText: 'MẬT KHẨU *',
            hintText: '******',
            isPassword: true,
            validator:
                (value) => _required(value, 'Mật khẩu không được bỏ trống'),
            textController: passwordController,
          ),
          if (error != null)
            Padding(
              padding: EdgeInsets.only(top: 5 * hem),
              child: Text(
                error!,
                style: GoogleFonts.openSans(
                  color: Colors.red,
                  fontSize: 12 * ffem,
                ),
              ),
            ),
          SizedBox(height: (error != null ? 20 : 30) * hem),
        ],
      ),
    );
  }
}
