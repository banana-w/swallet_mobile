import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
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
    _hasScanned = false;
    _checkLocationPermission(); // Kiểm tra quyền vị trí khi khởi tạo
  }

  Future<void> _checkLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showErrorSnackBar('Dịch vụ định vị chưa được bật');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
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
      return;
    }
  }

  Future<Position> _getCurrentPosition() async {
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      _showErrorSnackBar('Không thể lấy vị trí: $e');
      rethrow;
    }
  }

  void _showErrorSnackBar(String message) {
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<StudentBloc, StudentState>(
      listener: (context, state) {
        if (state is QRScanFailed) {
          setState(() {
            _hasScanned = false; // Cho phép quét lại nếu thất bại
          });
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                elevation: 0,
                duration: const Duration(milliseconds: 2000),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Thất bại!',
                  message: 'Mã QR đã được sử dụng trước đó hoặc đã quá hạn!',
                  contentType: ContentType.failure,
                ),
              ),
            );
        } else if (state is QRScanSuccess) {
          setState(() {
            _hasScanned = false; // Cho phép quét lại sau khi thành công
          });
          Navigator.push(
            context,
            SuccessScanLectureQRScreen.route(response: state.response),
          );
        }
      },
      child: Stack(
        children: [
          MobileScanner(
            startDelay: true,
            overlay: Lottie.asset('assets/animations/scanning.json'),
            controller: widget.cameraController,
            onDetect: (capture) async {
              if (_hasScanned) return;
              final barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (barcode.rawValue != null) {
                  print('Raw QR Code Data: ${barcode.rawValue}');
                  try {
                    jsonDecode(barcode.rawValue!); // Kiểm tra JSON hợp lệ
                    setState(() {
                      _hasScanned = true;
                    });

                    // Lấy vị trí hiện tại
                    final position = await _getCurrentPosition();

                    context.read<StudentBloc>().add(
                      ScanLectureQR(
                        qrCode: barcode.rawValue!,
                        studentId: widget.studentId,
                        longitude: position.longitude,
                        latitude: position.latitude,
                      ),
                    );
                  } catch (e) {
                    setState(() {
                      _hasScanned = false; // Cho phép quét lại nếu lỗi
                    });
                    _showErrorSnackBar(
                      'Định dạng QR code không hợp lệ hoặc lỗi vị trí: $e',
                    );
                  }
                  break;
                }
              }
            },
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
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
