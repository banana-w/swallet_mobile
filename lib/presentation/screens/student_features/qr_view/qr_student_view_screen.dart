import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'components/body.dart';

class QrStudentViewScreen extends StatefulWidget {
  static const String routeName = '/qr-student-view';
  static Route route({required String studentId}) {
    return PageRouteBuilder(
      pageBuilder: (_, _, _) => QrStudentViewScreen(studentId: studentId),
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

  const QrStudentViewScreen({super.key, required this.studentId});
  final String studentId;

  @override
  State<QrStudentViewScreen> createState() => _QrStudentViewScreenState();
}

class _QrStudentViewScreenState extends State<QrStudentViewScreen> {
  final MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  /// Camera của tab check-in. Trước đây được tạo trong `build()` của Body nên
  /// không ai đóng; giờ vòng đời gắn với màn hình như camera của tab kia.
  final MobileScannerController checkInCameraController =
      MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates);

  @override
  void dispose() {
    cameraController.dispose();
    checkInCameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // DefaultTabController chỉ khai báo ở đây; trước đây Body khai báo thêm
    // một cái nữa bọc chính TabBar/TabBarView của nó, khiến cái ở ngoài này
    // không điều khiển gì cả.
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          body: Body(
            cameraController: cameraController,
            checkInCameraController: checkInCameraController,
            studentId: widget.studentId,
          ),
        ),
      ),
    );
  }
}
