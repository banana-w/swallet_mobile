import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:swallet_mobile/presentation/config/app_injection.dart';
import 'package:swallet_mobile/presentation/widgets/qr_code_card.dart';

@Preview(
  name: 'QR Screen - Connected',
  size: Size(
    375,
    812,
  ), // Định cấu hình kích thước chuẩn điện thoại giống QR Screen
)
Widget anyScreenPreview() {
  return const AppInjection(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QRVoucherScreen(
        id: '1234567890', // Đổi tên trang bạn muốn xem vào đây là xong
      ),
    ),
  );
}

class QRVoucherScreen extends StatelessWidget {
  static const String routeName = '/qr-voucher-student';

  static Route route({required String id}) {
    return MaterialPageRoute(
      builder: (_) => QRVoucherScreen(id: id),
      settings: const RouteSettings(name: routeName),
    );
  }

  const QRVoucherScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return QrCodeCardScreen(
      id: id,
      appBarTitle: 'QR ưu đãi',
      caption: 'Đưa mã này để sử dụng ưu đãi',
    );
  }
}
