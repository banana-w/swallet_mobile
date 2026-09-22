import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/blocs/campaign/campaign_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

import 'components/body.dart';

class SuccessRedeemVoucherScreen extends StatefulWidget {
  static const String routeName = '/success-redeemo-voucher';

  static Route route({required String voucherName, required double total}) {
    return PageRouteBuilder(
      pageBuilder:
          (_, _, _) => SuccessRedeemVoucherScreen(
            voucherName: voucherName,
            total: total,
          ),
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

  const SuccessRedeemVoucherScreen({
    super.key,
    required this.voucherName,
    required this.total,
  });

  final String voucherName;
  final double total;

  @override
  State<SuccessRedeemVoucherScreen> createState() =>
      _SuccessRedeemVoucherScreenState();
}

class _SuccessRedeemVoucherScreenState
    extends State<SuccessRedeemVoucherScreen> {
  @override
  void initState() {
    super.initState();
    // Giao dịch vừa trừ coin của sinh viên, nhưng RoleAppBloc vẫn giữ bản ghi
    // cũ nên thẻ thành viên ở trang chủ hiển thị số dư sai cho tới lần refresh
    // sau. Nạp lại ngay để về trang chủ là số dư đã đúng.
    context.read<RoleAppBloc>().add(const RoleAppStart());
  }

  void _goHome() {
    context.read<CampaignBloc>().add(const LoadCampaigns());
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/landing-screen',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final hem = size.height / 812;
    final ffem = fem * 0.97;

    return PopScope(
      // Stack điều hướng đã bị xoá sạch trước khi vào đây, nên nút back của hệ
      // thống sẽ thoát app. Đưa về trang chủ thay vì đóng ứng dụng.
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _goHome();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background_splash.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            toolbarHeight: 50 * hem,
            centerTitle: true,
            title: Text(
              'Kết quả giao dịch',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 20 * ffem,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 20 * fem),
                child: IconButton(
                  icon: Icon(Icons.home, color: Colors.white, size: 30 * fem),
                  onPressed: _goHome,
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            color: kPrimaryColor,
            height: 80 * hem,
            elevation: 5,
            child: Center(
              child: GestureDetector(
                onTap: _goHome,
                child: Container(
                  width: 270 * fem,
                  height: 45 * hem,
                  decoration: BoxDecoration(
                    color: klightPrimaryColor,
                    borderRadius: BorderRadius.circular(10 * fem),
                  ),
                  child: Center(
                    child: Text(
                      'Trang chủ',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 17 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.3625 * ffem / fem,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: Body(voucherName: widget.voucherName, total: widget.total),
        ),
      ),
    );
  }
}
