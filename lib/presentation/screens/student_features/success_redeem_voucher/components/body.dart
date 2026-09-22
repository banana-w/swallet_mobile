import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/widgets/transaction_detail_row.dart';

final _dateTimeFormat = DateFormat('HH:mm - dd/MM/yyyy');

class Body extends StatefulWidget {
  const Body({super.key, required this.voucherName, required this.total});

  final String voucherName;
  final double total;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // Chốt mốc thời gian một lần khi vào màn. Trước đây gọi DateTime.now() ngay
  // trong build nên mỗi lần dựng lại (xoay máy, đổi kích thước...) là "thời
  // gian thanh toán" lại nhảy sang thời điểm hiện tại.
  late final String _paidAt = _dateTimeFormat.format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final hem = size.height / 812;
    final ffem = fem * 0.97;

    final labelStyle = GoogleFonts.openSans(
      textStyle: TextStyle(
        fontSize: 15 * ffem,
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ),
    );
    final valueStyle = GoogleFonts.openSans(
      textStyle: TextStyle(
        fontSize: 16 * ffem,
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
              color: klighGreyColor,
              height: 150 * hem,
              child: Lottie.asset(
                'assets/animations/success-animation.json',
                repeat: false,
              ),
            ),
            Text(
              'Giao dịch thành công',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 22 * ffem,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 30 * hem),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15 * fem),
              padding: EdgeInsets.symmetric(
                horizontal: 15 * fem,
                vertical: 5 * hem,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kPrimaryColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TransactionDetailRow(
                    height: 50 * hem,
                    label: 'Thời gian thanh toán',
                    labelStyle: labelStyle,
                    value: Text(_paidAt, style: valueStyle),
                  ),
                  TransactionDetailRow(
                    height: 50 * hem,
                    label: 'Ưu đãi',
                    labelStyle: labelStyle,
                    value: SizedBox(
                      width: 120 * fem,
                      child: Text(
                        widget.voucherName,
                        maxLines: 2,
                        softWrap: true,
                        textAlign: TextAlign.end,
                        style: valueStyle,
                      ),
                    ),
                  ),
                  TransactionDetailRow(
                    height: 50 * hem,
                    label: 'Tổng coin',
                    labelStyle: labelStyle,
                    value: CoinAmount(
                      amount: widget.total,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 22 * ffem,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      ),
                      iconSize: 26 * fem,
                      iconPadding: EdgeInsets.only(
                        left: 5 * fem,
                        top: 4 * hem,
                        bottom: 2 * hem,
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
