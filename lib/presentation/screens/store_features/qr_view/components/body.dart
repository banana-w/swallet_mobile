import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:swallet_mobile/data/interface_repositories/store_features/store_repository.dart';
import 'package:swallet_mobile/presentation/blocs/internet/internet_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/store/store_bloc.dart';
import 'package:swallet_mobile/presentation/widgets/internet_listener.dart';

import 'tab_scan_voucher.dart';

class Body extends StatefulWidget {
  const Body({super.key, required this.storeId});

  final String storeId;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  /// Controller phải sống cùng State: bản cũ tạo mới trong `build`, nên mỗi
  /// lần dựng lại lại mở thêm một phiên camera và không bao giờ đóng cái cũ.
  late final MobileScannerController _cameraController;

  @override
  void initState() {
    super.initState();
    _cameraController = MobileScannerController(
      detectionTimeoutMs: 1000,
      detectionSpeed: DetectionSpeed.noDuplicates,
      facing: CameraFacing.back,
      torchEnabled: false,
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    return InternetListener(
      child: BlocBuilder<InternetBloc, InternetState>(
        builder: (context, state) {
          return NestedScrollView(
            headerSliverBuilder:
                (context, innerBoxIsScrolled) => [
                  _ScannerAppBar(fem: fem, ffem: ffem, hem: hem),
                ],
            // Mất mạng thì chỉ giữ lại khung tiêu đề, không bật camera.
            body:
                state is Connected
                    ? TabBarView(
                      children: [
                        BlocProvider(
                          create:
                              (context) => StoreBloc(
                                storeRepository:
                                    context.read<StoreRepository>(),
                              ),
                          child: TabScanVoucher(
                            cameraController: _cameraController,
                            storeId: widget.storeId,
                          ),
                        ),
                      ],
                    )
                    : const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

class _ScannerAppBar extends StatelessWidget {
  const _ScannerAppBar({
    required this.fem,
    required this.ffem,
    required this.hem,
  });

  final double fem;
  final double ffem;
  final double hem;

  @override
  Widget build(BuildContext context) {
    final tabLabelStyle = GoogleFonts.openSans(
      textStyle: TextStyle(fontSize: 13 * ffem, fontWeight: FontWeight.w700),
    );

    return SliverAppBar(
      pinned: true,
      floating: true,
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_splash.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      toolbarHeight: 40 * hem,
      centerTitle: true,
      title: Padding(
        padding: EdgeInsets.only(top: 10 * hem),
        child: Text(
          'Swallet',
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontSize: 22 * ffem,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
      ),
      leading: Padding(
        padding: EdgeInsets.only(top: 10 * hem),
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30 * fem,
          ),
        ),
      ),
      bottom: TabBar(
        automaticIndicatorColorAdjustment: false,
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 3,
        indicatorPadding: EdgeInsets.only(bottom: 1 * fem),
        labelColor: Colors.white,
        labelStyle: tabLabelStyle,
        unselectedLabelColor: Colors.white60,
        unselectedLabelStyle: tabLabelStyle,
        tabs: const [Tab(text: 'Quét ưu đãi')],
      ),
    );
  }
}
