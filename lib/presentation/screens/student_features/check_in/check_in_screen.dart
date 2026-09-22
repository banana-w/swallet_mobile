import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/check_in_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/wheel_repository.dart';
import 'package:swallet_mobile/presentation/blocs/internet/internet_bloc.dart';
import 'package:swallet_mobile/presentation/screens/student_features/check_in/check_in_failed.dart';
import 'package:swallet_mobile/presentation/screens/student_features/check_in/check_in_success.dart';
import 'package:swallet_mobile/presentation/screens/student_features/qr_view/components/qr_scanner_overlay.dart';
import 'package:swallet_mobile/presentation/widgets/internet_listener.dart';
import 'package:swallet_mobile/presentation/widgets/scanner_app_bar.dart';

class CheckInScreen extends StatefulWidget {
  static const String routeName = '/check-in';

  const CheckInScreen({super.key});

  static Route route() {
    return PageRouteBuilder(
      pageBuilder: (_, _, _) => const CheckInScreen(),
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (_, animation, _, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        return SlideTransition(position: animation.drive(tween), child: child);
      },
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  final MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: CheckInBody(cameraController: cameraController)),
    );
  }
}

class CheckInBody extends StatelessWidget {
  const CheckInBody({super.key, required this.cameraController});

  final MobileScannerController cameraController;

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
                title: 'Check-in bằng QR',
                fem: fem,
                hem: hem,
                ffem: ffem,
              ),
              Expanded(
                child: CheckInQRScanner(cameraController: cameraController),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CheckInQRScanner extends StatefulWidget {
  const CheckInQRScanner({super.key, required this.cameraController});

  final MobileScannerController cameraController;

  @override
  State<CheckInQRScanner> createState() => _CheckInQRScannerState();
}

class _CheckInQRScannerState extends State<CheckInQRScanner> {
  bool _hasScanned = false;

  Future<Position> _determinePosition() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      _showLocationSnackBar(
        'Dịch vụ định vị bị tắt. Vui lòng bật định vị.',
        onSettings: Geolocator.openLocationSettings,
      );
      throw const CheckInException('Dịch vụ định vị bị tắt.');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showLocationSnackBar('Quyền định vị bị từ chối.');
        throw const CheckInException('Quyền định vị bị từ chối.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showLocationSnackBar(
        'Quyền định vị bị từ chối vĩnh viễn. Vui lòng cấp quyền trong cài đặt.',
        onSettings: Geolocator.openAppSettings,
      );
      throw const CheckInException('Quyền định vị bị từ chối vĩnh viễn.');
    }

    return Geolocator.getCurrentPosition();
  }

  /// Mọi lời gọi ở đây đều nằm sau một `await`, nên phải kiểm tra `mounted`
  /// trước khi chạm vào `context`.
  void _showLocationSnackBar(String message, {VoidCallback? onSettings}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          action:
              onSettings == null
                  ? null
                  : SnackBarAction(label: 'Mở cài đặt', onPressed: onSettings),
        ),
      );
  }

  Future<void> _checkInWithQR(String qrCode) async {
    try {
      final student = await AuthenLocalDataSource.getStudent();
      if (student == null) {
        // Trước đây dùng `studentId!` ở đây: hết phiên đăng nhập là văng lỗi
        // null thay vì báo cho người dùng biết.
        throw const CheckInException(
          'Không tìm thấy thông tin sinh viên, vui lòng đăng nhập lại',
        );
      }
      if (!mounted) return;

      final position = await _determinePosition();
      if (!mounted) return;

      final pointsAwarded = await context
          .read<CheckInRepository>()
          .checkInWithQr(
            studentId: student.id,
            qrCode: qrCode,
            latitude: position.latitude,
            longitude: position.longitude,
          );
      if (!mounted) return;

      await context.read<SpinHistoryRepository>().incrementBonusSpins(
        student.id,
        DateTime.now(),
      );
      if (!mounted) return;

      await Navigator.push(
        context,
        CheckInSuccessScreen.route(pointsAwarded: pointsAwarded),
      );
    } catch (e) {
      if (!mounted) return;
      // Ba nhánh if/else cũ đều gán đúng chuỗi mà chúng vừa so khớp, nên rút
      // gọn lại còn một dòng.
      await Navigator.push(
        context,
        CheckInFailedScreen.route(
          failedReason: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _hasScanned = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MobileScanner(
          controller: widget.cameraController,
          onDetect: (capture) {
            if (_hasScanned) return;
            for (final barcode in capture.barcodes) {
              final rawValue = barcode.rawValue;
              if (rawValue != null) {
                setState(() => _hasScanned = true);
                _checkInWithQR(rawValue);
                break;
              }
            }
          },
        ),
        Positioned.fill(
          child: Container(
            decoration: ShapeDecoration(
              shape: QrScannerOverlayShape(
                borderColor: Colors.blue,
                borderRadius: 10,
                borderLength: 20,
                borderWidth: 5,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 50,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              'Quét mã QR tại địa điểm để check-in!',
              style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
