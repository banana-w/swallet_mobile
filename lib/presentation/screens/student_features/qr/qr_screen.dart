import 'package:flutter/material.dart';
import 'package:swallet_mobile/presentation/widgets/qr_code_card.dart';

class QRScreen extends StatelessWidget {
  static const String routeName = '/qr-student';

  static Route route({required String id}) {
    return MaterialPageRoute(
      builder: (_) => QRScreen(id: id),
      settings: const RouteSettings(name: routeName),
    );
  }

  const QRScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return QrCodeCardScreen(
      id: id,
      appBarTitle: 'QR của bạn',
      caption: 'Mã QR của bạn',
    );
  }
}
