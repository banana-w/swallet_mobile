import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/blocs/campaign/campaign_bloc.dart';
import 'components/body.dart';

import '../../../config/constants.dart';

class FailedBuyScreen extends StatelessWidget {
  static const String routeName = '/failed-student';

  static Route route({required String failed}) {
    return PageRouteBuilder(
      pageBuilder: (_, _, _) => FailedBuyScreen(failed: failed),
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

  const FailedBuyScreen({super.key, required this.failed});

  final String failed;

  void _goHome(BuildContext context) {
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
        if (!didPop) _goHome(context);
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
                  height: 1.3625 * ffem / fem,
                  color: Colors.white,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 20 * fem),
                child: IconButton(
                  icon: Icon(Icons.home, color: Colors.white, size: 30 * fem),
                  onPressed: () => _goHome(context),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            color: klighGreyColor,
            height: 80 * hem,
            elevation: 5,
            child: Center(
              child: GestureDetector(
                onTap: () => _goHome(context),
                child: Container(
                  width: 320 * fem,
                  height: 45 * hem,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
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
          body: Body(failed: failed),
        ),
      ),
    );
  }
}
