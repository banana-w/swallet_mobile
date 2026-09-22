import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/student_repository.dart';
import 'package:swallet_mobile/presentation/blocs/internet/internet_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/student/student_bloc.dart';
import 'package:swallet_mobile/presentation/screens/student_features/check_in/check_in_screen.dart';
import 'package:swallet_mobile/presentation/widgets/internet_listener.dart';
import 'package:swallet_mobile/presentation/widgets/scanner_app_bar.dart';

import 'tab_scan_voucher.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.studentId,
    required this.cameraController,
    required this.checkInCameraController,
  });

  final String studentId;

  /// Camera của tab quét QR giảng viên.
  final MobileScannerController cameraController;

  /// Camera của tab check-in.
  ///
  /// Trước đây controller này được `new` ngay trong `build()`: mỗi lần dựng
  /// lại màn hình là thêm một camera mới không ai đóng, còn cái cũ thì giữ
  /// nguyên tài nguyên camera của hệ thống.
  final MobileScannerController checkInCameraController;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    return InternetListener(
      child: BlocBuilder<InternetBloc, InternetState>(
        builder: (context, state) {
          if (state is! Connected) {
            return const Center(
              child: Text(
                'Không có kết nối Internet',
                style: TextStyle(fontSize: 18),
              ),
            );
          }
          return Column(
            children: [
              ScannerAppBar(
                title: 'Quét mã QR',
                fem: fem,
                hem: hem,
                ffem: ffem,
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 2,
                  labelColor: Colors.white,
                  labelStyle: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: 12 * ffem,
                      height: 1.3625 * ffem / fem,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  unselectedLabelColor: Colors.white60,
                  unselectedLabelStyle: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: 12 * ffem,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  tabs: const [
                    Tab(text: 'Lecture QR'),
                    Tab(text: 'Check-in QR'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    BlocProvider(
                      create:
                          (context) => StudentBloc(
                            studentRepository:
                                context.read<StudentRepository>(),
                          ),
                      child: TabScanLectureQR(
                        cameraController: cameraController,
                        studentId: studentId,
                      ),
                    ),
                    CheckInQRScanner(cameraController: checkInCameraController),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
