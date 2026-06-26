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
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // 1. Sử dụng BlocConsumer để cô lập phần giao diện thay đổi theo AuthState
          BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) async {
              // Di chuyển TOÀN BỘ logic điều hướng (Side-effect) về đây
              if (state is AuthenticationSuccess) {
                context.read<RoleAppBloc>().add(RoleAppStart());
                context.read<LandingScreenBloc>().add(TabChange(tabIndex: 0));
                Navigator.pushNamedAndRemoveUntil(context, '/landing-screen', (route) => false);
              } 
              else if (state is AuthenticationStoreSuccess) {
                context.read<RoleAppBloc>().add(RoleAppStart());
                context.read<StoreBloc>().add(LoadStoreCampaignVouchers());
                context.read<LandingScreenBloc>().add(TabChange(tabIndex: 0));
                Navigator.pushNamedAndRemoveUntil(context, '/landing-screen-store', (route) => false);
              } 
              else if (state is AuthenticationLectureSuccess) {
                context.read<RoleAppBloc>().add(RoleAppStart());
                context.read<LandingScreenBloc>().add(TabChange(tabIndex: 0));
                Navigator.pushNamedAndRemoveUntil(context, '/landing-screen-lecture', (route) => false);
              } 
              else if (state is AuthenticationSuccessButNotVerified) {
                final authenData = await AuthenLocalDataSource.getAuthen();
                if (authenData == null) return;
                
                // Chặn lỗi Async Gap bảo vệ BuildContext trước khi điều hướng
                if (!context.mounted) return;
                Navigator.pushNamed(context, VerifyCodeScreen.routeName, arguments: authenData.email);
              }
            },
            builder: (context, state) {
              // Chỉ vẽ lại Widget giao diện Form nhập liệu cụ thể dựa trên State hiện tại
              return switch (state) {
                AuthenticationFailed(error: final error) => _buildAuthFailed(
                    userNameController, passwordController, error, widget.fem, widget.hem, widget.ffem,
                  ),
                // Tất cả các trạng thái còn lại dùng chung giao diện khởi tạo ban đầu
                _ => _buildAuthIntial(
                    userNameController, passwordController, widget.fem, widget.hem, widget.ffem,
                  ),
              };
            },
          ),
          
          SizedBox(height: 25 * widget.hem),
          
          // 2. Nút bấm Login (Bên trong nút bấm này đã tự có BlocBuilder để đổi UI xoay tròn rồi)
          ButtonLogin(
            widget: widget,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<AuthenticationBloc>().add(
                  LoginAccount(
                    userName: userNameController.text.trim(),
                    password: passwordController.text,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
Widget _buildAuthIntial(
  TextEditingController userNameController,
  TextEditingController passwordController,
  double fem,
  double hem,
  double ffem,
) {
  return Container(
    width: 318 * fem,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15 * fem),
      boxShadow: [
        BoxShadow(
          color: Color(0x0c000000),
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Tài khoản không được bỏ trống';
            }
            return null;
          },
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Mật khẩu không được bỏ trống';
            }
            return null;
          },
          textController: passwordController,
        ),
        SizedBox(height: 30 * hem),
      ],
    ),
  );
}

Widget _buildAuthFailed(
  TextEditingController userNameController,
  TextEditingController passwordController,
  String error,
  double fem,
  double hem,
  double ffem,
) {
  return Container(
    width: 318 * fem,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15 * fem),
      boxShadow: [
        BoxShadow(
          color: Color(0x0c000000),
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
          labelText: 'TÀI KHOẢN',
          hintText: 'Nhập tài khoản của bạn',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Tài khoản không được bỏ trống';
            }
            return null;
          },
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Mật khẩu không được bỏ trống';
            }
            return null;
          },
          textController: passwordController,
        ),
        Padding(
          padding: EdgeInsets.only(top: 5 * hem),
          child: Text(
            error,
            style: GoogleFonts.openSans(color: Colors.red, fontSize: 12 * ffem),
          ),
        ),
        SizedBox(height: 20 * hem),
      ],
    ),
  );
}
