import 'package:flutter/material.dart';
import 'package:swallet_mobile/data/models/lecture_features/qr_response.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/widgets/result_screen_scaffold.dart';
import 'package:swallet_mobile/presentation/widgets/transaction_detail_row.dart';

class SuccessScanLectureQRScreen extends StatefulWidget {
  static const String routeName = '/success-scan-lecture-qr';

  const SuccessScanLectureQRScreen({super.key, required this.response});

  final ScanQRResponse response;

  static Route route({required ScanQRResponse response}) {
    return PageRouteBuilder(
      pageBuilder: (_, _, _) => SuccessScanLectureQRScreen(response: response),
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
  State<SuccessScanLectureQRScreen> createState() =>
      _SuccessScanLectureQRScreenState();
}

class _SuccessScanLectureQRScreenState
    extends State<SuccessScanLectureQRScreen> {
  /// Chốt mốc thời gian một lần thay vì gọi `DateTime.now()` trong `build()`.
  late final String _scannedAt = ResultScreenScaffold.formatNow();

  @override
  Widget build(BuildContext context) {
    final response = widget.response;

    return ResultScreenScaffold(
      appBarTitle: 'Kết quả quét mã QR',
      animationAsset: 'assets/animations/success-animation.json',
      headline: 'QUÉT MÃ QR THÀNH CÔNG!',
      cardBorderColor: kPrimaryColor,
      cardHeight: 250,
      rows:
          (fem, hem, ffem) => [
            TransactionDetailRow(
              height: 50 * hem,
              label: 'Thời gian thực hiện',
              labelStyle: resultLabelStyle(ffem),
              value: Text(_scannedAt, style: resultValueStyle(ffem)),
            ),
            TransactionDetailRow(
              height: 30 * hem,
              label: 'Điểm nhận được',
              labelStyle: resultLabelStyle(ffem),
              value: SizedBox(
                width: 200 * fem,
                child: Text(
                  '${response.pointsTransferred} xu',
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  style: resultValueStyle(ffem, color: Colors.green),
                ),
              ),
            ),
            TransactionDetailRow(
              height: 40 * hem,
              label: 'Số dư mới',
              labelStyle: resultLabelStyle(ffem),
              value: SizedBox(
                width: 200 * fem,
                child: Text(
                  '${response.newBalance} xu',
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  style: resultValueStyle(ffem),
                ),
              ),
            ),
          ],
    );
  }
}
