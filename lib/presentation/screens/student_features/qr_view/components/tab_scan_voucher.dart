import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:swallet_mobile/presentation/blocs/student/student_bloc.dart';
import 'package:swallet_mobile/presentation/screens/store_features/failed_scan_voucher/failed_scan_voucher_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/qr_view/success-scren.dart';

import '../../../../config/constants.dart';
import 'qr_scanner_overlay.dart';

class TabScanLectureQR extends StatefulWidget {
  // Chuyển thành Stateful để quản lý trạng thái
  const TabScanLectureQR({
    super.key,
    required this.cameraController,
    required this.studentId,
  });

  final MobileScannerController cameraController;
  final String studentId;

  @override
  State<TabScanLectureQR> createState() => _TabScanVoucherState();
}

class _TabScanVoucherState extends State<TabScanLectureQR> {
  bool _hasScanned = false; // Biến flag để kiểm soát trạng thái quét

  @override
  void initState() {
    super.initState();
    _hasScanned = false; // Khởi tạo trạng thái
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StudentBloc, StudentState>(
      listener: (context, state) {
        if (state is QRScanFailed) {
          setState(() {
            _hasScanned = false; // Cho phép quét lại nếu thất bại
          });
          // Navigator.pushNamed(
          //   context,
          //   FailedScanVoucherScreen.routeName,
          //   arguments: state.error,
          // );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                elevation: 0,
                duration: const Duration(milliseconds: 2000),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Thất bại!',
                  message:
                      'Mã QR đã được sử dụng trước đó hoặc đã quá hạn!',
                  contentType: ContentType.success,
                ),
              ),
            );
        } else if (state is QRScanSuccess) {
          // Navigator.pushNamed(
          //   context,
          //   SuccessScanLectureQRScreen.routeName,
          //   arguments: state.response,
          // );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                elevation: 0,
                duration: const Duration(milliseconds: 2000),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Thành công!',
                  message:
                      'Đã thêm ${state.response.pointsTransferred} Xu vào ví của bạn',
                  contentType: ContentType.success,
                ),
              ),
            );
        }
      },
      child: Stack(
        children: [
          MobileScanner(
            controller: widget.cameraController,
            onDetect: (capture) {
              if (_hasScanned) return; // Nếu đã quét, không xử lý tiếp
              final barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (barcode.rawValue != null) {
                  print('Raw QR Code Data: ${barcode.rawValue}');
                  try {
                    jsonDecode(barcode.rawValue!); // Kiểm tra JSON hợp lệ
                    setState(() {
                      _hasScanned = true; // Đánh dấu đã quét
                    });
                    context.read<StudentBloc>().add(
                      ScanLectureQR(
                        qrCode: barcode.rawValue!,
                        studentId: widget.studentId,
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Định dạng QR code không hợp lệ: $e'),
                      ),
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
                'Quét mã từ Giảng viên để nhận xu!',
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
