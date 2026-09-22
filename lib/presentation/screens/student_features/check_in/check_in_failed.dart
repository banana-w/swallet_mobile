import 'package:flutter/material.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/widgets/result_screen_scaffold.dart';
import 'package:swallet_mobile/presentation/widgets/transaction_detail_row.dart';

class CheckInFailedScreen extends StatefulWidget {
  static const String routeName = '/check-in-failed';

  static Route route({required String failedReason}) {
    return PageRouteBuilder(
      pageBuilder: (_, _, _) => CheckInFailedScreen(failedReason: failedReason),
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

  const CheckInFailedScreen({super.key, required this.failedReason});

  final String failedReason;

  @override
  State<CheckInFailedScreen> createState() => _CheckInFailedScreenState();
}

class _CheckInFailedScreenState extends State<CheckInFailedScreen> {
  /// Chốt mốc thời gian một lần thay vì gọi `DateTime.now()` trong `build()`.
  late final String _failedAt = ResultScreenScaffold.formatNow();

  @override
  Widget build(BuildContext context) {
    return ResultScreenScaffold(
      appBarTitle: 'Kết quả check-in',
      animationAsset: 'assets/animations/failed-animation.json',
      headline: 'CHECK-IN THẤT BẠI!',
      cardBorderColor: kErrorTextColor,
      cardHeight: 200,
      rows:
          (fem, hem, ffem) => [
            TransactionDetailRow(
              height: 50 * hem,
              label: 'Thời gian thực hiện',
              labelStyle: resultLabelStyle(ffem),
              value: Text(_failedAt, style: resultValueStyle(ffem)),
            ),
            TransactionDetailRow(
              height: 80 * hem,
              label: 'Lý do thất bại',
              labelStyle: resultLabelStyle(ffem),
              value: SizedBox(
                width: 200 * fem,
                child: Text(
                  widget.failedReason,
                  textAlign: TextAlign.end,
                  maxLines: 3,
                  softWrap: true,
                  style: resultValueStyle(ffem),
                ),
              ),
            ),
          ],
    );
  }
}
