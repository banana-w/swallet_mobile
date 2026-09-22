import 'package:flutter/material.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/widgets/result_screen_scaffold.dart';
import 'package:swallet_mobile/presentation/widgets/transaction_detail_row.dart';

class CheckInSuccessScreen extends StatefulWidget {
  static const String routeName = '/check-in-success';

  static Route route({required int pointsAwarded}) {
    return PageRouteBuilder(
      pageBuilder:
          (_, _, _) => CheckInSuccessScreen(pointsAwarded: pointsAwarded),
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

  const CheckInSuccessScreen({super.key, required this.pointsAwarded});

  final int pointsAwarded;

  @override
  State<CheckInSuccessScreen> createState() => _CheckInSuccessScreenState();
}

class _CheckInSuccessScreenState extends State<CheckInSuccessScreen> {
  /// Chốt mốc thời gian một lần thay vì gọi `DateTime.now()` trong `build()`.
  late final String _checkedInAt = ResultScreenScaffold.formatNow();

  @override
  Widget build(BuildContext context) {
    return ResultScreenScaffold(
      appBarTitle: 'Kết quả check-in',
      animationAsset: 'assets/animations/success-animation.json',
      headline: 'CHECK-IN THÀNH CÔNG!',
      cardBorderColor: kPrimaryColor,
      cardHeight: 250,
      rows:
          (fem, hem, ffem) => [
            TransactionDetailRow(
              height: 50 * hem,
              label: 'Thời gian thực hiện',
              labelStyle: resultLabelStyle(ffem),
              value: Text(_checkedInAt, style: resultValueStyle(ffem)),
            ),
            TransactionDetailRow(
              height: 80 * hem,
              label: 'Phần thưởng',
              labelStyle: resultLabelStyle(ffem),
              value: SizedBox(
                width: 200 * fem,
                child: Text(
                  '${widget.pointsAwarded} xu',
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  style: resultValueStyle(ffem),
                ),
              ),
            ),
            TransactionDetailRow(
              height: 80 * hem,
              label: 'Lượt quay Lucky Wheel',
              labelStyle: resultLabelStyle(ffem),
              value: SizedBox(
                width: 100 * fem,
                child: Text(
                  '1 lượt',
                  textAlign: TextAlign.end,
                  maxLines: 2,
                  style: resultValueStyle(ffem),
                ),
              ),
            ),
          ],
    );
  }
}
