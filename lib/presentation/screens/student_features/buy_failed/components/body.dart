import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/widgets/transaction_detail_row.dart';

final _dateTimeFormat = DateFormat('HH:mm - dd/MM/yyyy');

class Body extends StatefulWidget {
  const Body({super.key, required this.failed});

  final String failed;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // Chốt mốc thời gian một lần khi vào màn, thay vì gọi DateTime.now() trong
  // build (mỗi lần dựng lại là "thời gian thực hiện" lại nhảy).
  late final String _failedAt = _dateTimeFormat.format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final hem = size.height / 812;
    final ffem = fem * 0.97;

    final labelStyle = GoogleFonts.openSans(
      textStyle: TextStyle(
        fontSize: 14 * ffem,
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ),
    );
    final valueStyle = GoogleFonts.openSans(
      textStyle: TextStyle(
        fontSize: 15 * ffem,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );

    return SingleChildScrollView(
      child: SizedBox(
        width: size.width,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 150 * hem,
              child: Lottie.asset(
                'assets/animations/failed-animation.json',
                repeat: false,
              ),
            ),
            Text(
              'GIAO DỊCH THẤT BẠI!\n Vui lòng thử lại!',
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 18 * ffem,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 30 * hem),
            Container(
              width: double.infinity,
              height: 200 * hem,
              margin: EdgeInsets.symmetric(horizontal: 15 * fem),
              padding: EdgeInsets.symmetric(
                horizontal: 15 * fem,
                vertical: 5 * hem,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kErrorTextColor),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TransactionDetailRow(
                    height: 50 * hem,
                    label: 'Thời gian thực hiện',
                    labelStyle: labelStyle,
                    value: Text(_failedAt, style: valueStyle),
                  ),
                  TransactionDetailRow(
                    height: 80 * hem,
                    label: 'Nội dung',
                    labelStyle: labelStyle,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    value: SizedBox(
                      width: 200 * fem,
                      child: Text(
                        widget.failed,
                        textAlign: TextAlign.start,
                        maxLines: 6,
                        softWrap: true,
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
