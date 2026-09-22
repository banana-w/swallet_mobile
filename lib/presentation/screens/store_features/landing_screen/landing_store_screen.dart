import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/presentation/blocs/landing_screen/landing_screen_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/store_features/campaign/campaign_store_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/dashboard/dashboard_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/profile/profile_store_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/qr_view/qr_view_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/voucher_history/voucher_history.dart';
import 'package:swallet_mobile/presentation/widgets/app_bar_store.dart';
import 'components/cus_nav_bar_strore.dart';

/// Các tab của thanh điều hướng dưới cùng, theo đúng thứ tự của
/// `NavItemStore.navItems`.
const List<Widget> bottomNavScreen = [
  CampaignStoreScreen(),
  DashboardScreen(),
  VoucherHistoryScreenStore(),
  ProfileStoreScreen(),
];

class LandingStoreScreen extends StatelessWidget {
  const LandingStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    return BlocBuilder<LandingScreenBloc, LandingScreenState>(
      builder: (context, state) {
        final tabIndex = state.tabIndex;

        // Chỉ hai tab đầu dùng thanh tiêu đề chung; tab lịch sử và tab hồ sơ
        // tự dựng tiêu đề của riêng chúng.
        final showAppBar = tabIndex == 0 || tabIndex == 1;

        final scaffold = SafeArea(
          child: Scaffold(
            appBar:
                showAppBar ? AppBarStore(hem: hem, ffem: ffem, fem: fem) : null,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: _ScanButton(
              fem: fem,
              hem: hem,
              // Nút ở hai tab đầu to hơn, giữ nguyên như bản cũ.
              iconSize: showAppBar ? 30 : 20,
            ),
            body: bottomNavScreen.elementAt(tabIndex),
            backgroundColor: klighGreyColor,
            extendBody: true,
            bottomNavigationBar: const CusNavStoreBar(),
          ),
        );

        // Tab lịch sử ưu đãi dùng TabBar bên trong nên cần controller bao ngoài.
        return tabIndex == 2
            ? DefaultTabController(length: 3, child: scaffold)
            : scaffold;
      },
    );
  }
}

/// Nút quét QR nổi ở giữa thanh điều hướng.
class _ScanButton extends StatelessWidget {
  const _ScanButton({
    required this.fem,
    required this.hem,
    required this.iconSize,
  });

  final double fem;
  final double hem;
  final double iconSize;

  Future<void> _openScanner(BuildContext context) async {
    final store = await AuthenLocalDataSource.getStore();
    if (!context.mounted) return;
    Navigator.pushNamed(context, QrViewScreen.routeName, arguments: store?.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52.5 * fem,
      height: 52.5 * hem,
      margin: EdgeInsets.only(top: 10 * hem),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50 * fem),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(
              255,
              186,
              186,
              186,
            ).withValues(alpha: .35),
            spreadRadius: 8,
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          elevation: 5 * fem,
          shape: const CircleBorder(),
          onPressed: () => _openScanner(context),
          child: SizedBox(
            width: iconSize * fem,
            height: iconSize * hem,
            child: Icon(
              Icons.qr_code_scanner,
              color: Colors.white,
              size: iconSize * fem,
            ),
          ),
        ),
      ),
    );
  }
}
