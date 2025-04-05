import 'package:flutter/material.dart';
import 'package:swallet_mobile/data/models/lecture_features/qr_response.dart';

class SuccessScanLectureQRScreen extends StatelessWidget {
  static const String routeName = '/success-scan-voucher';

  const SuccessScanLectureQRScreen({super.key, required this.response});
  final ScanQRResponse response;

  static Route route({required ScanQRResponse response}) {
    return MaterialPageRoute(
      builder: (_) => SuccessScanLectureQRScreen(response: response),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Thành Công')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Chúc mừng bạn đã nhận điểm thành công!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text('Mã sinh viên: ${response.studentId}'),
            Text('Điểm nhận được: ${response.pointsTransferred}'),
            Text('Số dư mới: ${response.newBalance}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Quay lại màn hình trước đó
              },
              child: const Text('Quay lại'),
            ),
          ],
        ),
      ),
    );
  }
}
