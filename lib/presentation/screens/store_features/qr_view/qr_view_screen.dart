import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'components/body.dart';

class QrViewScreen extends StatefulWidget {
  static const String routeName = '/qr-view';
  static Route route({required String storeId}) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => QrViewScreen(storeId: storeId),
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

  QrViewScreen({super.key, required this.storeId});
  final String storeId;

  @override
  State<QrViewScreen> createState() => _QrViewScreenState();
}

class _QrViewScreenState extends State<QrViewScreen> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(child: Scaffold(body: Body(id: widget.storeId))),
    );
  }
}
