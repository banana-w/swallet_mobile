import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'components/body.dart';

class QrStudentViewScreen extends StatefulWidget {
  static const String routeName = '/qr-student-view';
  static Route route({required String studentId}) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => QrStudentViewScreen(studentId: studentId),
      transitionDuration: Duration(milliseconds: 400),
      transitionsBuilder: (_, animation, __, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
      settings: const RouteSettings(name: routeName),
    );
  }

  QrStudentViewScreen({super.key, required this.studentId});
  final String studentId;

  @override
  State<QrStudentViewScreen> createState() => _QrStudentViewScreenState();
}

class _QrStudentViewScreenState extends State<QrStudentViewScreen> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Body(
          studentId: widget.studentId,
          cameraController: cameraController,
        ),
      ),
    );
  }
}
