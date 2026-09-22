import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/campaign/campaign_bloc.dart';

import '../widgets/store_app_bar.dart';
import '../widgets/store_bottom_button.dart';
import 'components/body.dart';

class FailedScanVoucherScreen extends StatelessWidget {
  static const String routeName = '/failed-scan-voucher-store';

  static Route route({required String failed}) {
    return PageRouteBuilder(
      pageBuilder: (_, _, _) => FailedScanVoucherScreen(failed: failed),
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (_, animation, _, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        final offsetAnimation = animation.drive(Tween(begin: begin, end: end));

        return SlideTransition(position: offsetAnimation, child: child);
      },
      settings: const RouteSettings(name: routeName),
    );
  }

  const FailedScanVoucherScreen({super.key, required this.failed});

  final String failed;

  void _goHome(BuildContext context) {
    context.read<CampaignBloc>().add(const LoadCampaigns());
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/landing-screen-store',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: StoreAppBar(
          title: 'Kết quả giao dịch',
          fem: fem,
          ffem: ffem,
          hem: hem,
          onHome: () => _goHome(context),
        ),
        bottomNavigationBar: StoreBottomButton(
          label: 'Trang chủ',
          fem: fem,
          ffem: ffem,
          hem: hem,
          onTap: () => _goHome(context),
        ),
        body: Body(failed: failed),
      ),
    );
  }
}
