import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:swallet_mobile/presentation/blocs/student/student_bloc.dart';
import 'package:swallet_mobile/presentation/screens/student_features/qr_view/success-scren.dart';
import '../../../../config/constants.dart';
import 'qr_scanner_overlay.dart';

class TabScanLectureQR extends StatefulWidget {
  const TabScanLectureQR({
    super.key,
    required this.cameraController,
    required this.studentId,
  });

  final MobileScannerController cameraController;
  final String studentId;

  @override
  State<TabScanLectureQR> createState() => _TabScanLectureQRState();
}

class _TabScanLectureQRState extends State<TabScanLectureQR> {
  bool _hasScanned = false;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission(); // Kiểm tra quyền vị trí khi khởi tạo
  }

  Future<void> _checkLocationPermission() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      _showErrorSnackBar('Dịch vụ định vị chưa được bật');
      return;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showErrorSnackBar('Quyền truy cập vị trí bị từ chối');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showErrorSnackBar(
        'Quyền truy cập vị trí bị từ chối vĩnh viễn. Vui lòng bật trong cài đặt.',
      );
    }
  }

  /// Mọi lời gọi đều nằm sau một `await` nên phải kiểm tra `mounted` trước khi
  /// chạm vào `context`.
  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          elevation: 0,
          duration: const Duration(milliseconds: 2000),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Lỗi',
            message: message,
            contentType: ContentType.failure,
          ),
        ),
      );
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_hasScanned) return;

    final rawValue =
        capture.barcodes
            .firstWhere(
              (b) => b.rawValue != null,
              orElse: () => const Barcode(),
            )
            .rawValue;
    if (rawValue == null) return;

    // Không log nội dung mã QR: đây là dữ liệu giao dịch của giảng viên.
    setState(() => _hasScanned = true);
    try {
      jsonDecode(rawValue); // Kiểm tra JSON hợp lệ

      final position = await Geolocator.getCurrentPosition();
      if (!mounted) return;

      context.read<StudentBloc>().add(
        ScanLectureQR(
          qrCode: rawValue,
          studentId: widget.studentId,
          longitude: position.longitude,
          latitude: position.latitude,
        ),
      );
    } catch (e) {
      // Trước đây lỗi vị trí báo hai lần: hàm lấy toạ độ hiện một snackbar rồi
      // `rethrow`, và nhánh catch ở đây hiện thêm một cái nữa.
      if (!mounted) return;
      setState(() => _hasScanned = false); // Cho phép quét lại nếu lỗi
      _showErrorSnackBar(
        'Định dạng QR không hợp lệ hoặc không lấy được vị trí',
      );
    }
  }

  void _onStudentState(BuildContext context, StudentState state) {
    if (state is QRScanFailed) {
      setState(() => _hasScanned = false); // Cho phép quét lại nếu thất bại
      _showErrorSnackBar('Mã QR đã được sử dụng trước đó hoặc đã quá hạn!');
    } else if (state is QRScanSuccess) {
      setState(() => _hasScanned = false); // Cho phép quét lại sau khi xong
      Navigator.push(
        context,
        SuccessScanLectureQRScreen.route(response: state.response),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StudentBloc, StudentState>(
      listenWhen:
          (previous, current) =>
              current is QRScanFailed || current is QRScanSuccess,
      listener: _onStudentState,
      child: Stack(
        children: [
          MobileScanner(
            controller: widget.cameraController,
            onDetect: _onDetect,
          ),
          Positioned.fill(
            child: Container(
              decoration: ShapeDecoration(
                shape: QrScannerOverlayShape(
                  borderColor: kPrimaryColor,
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
                'Quét mã từ Giảng viên để nhận xu!',
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
      ),
    );
  }
}
