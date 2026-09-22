import 'package:flutter/material.dart';
import 'package:swallet_mobile/presentation/widgets/transaction_detail_row.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

/// Hoá đơn tĩnh của một lần đổi voucher: chỉ hiển thị, không giữ state nào.
class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.quantity,
    required this.voucherName,
    required this.campaignName,
    required this.total,
    required this.priceVoucher,
  });

  final int quantity;
  final String voucherName;
  final String campaignName;
  final double total;
  final double priceVoucher;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final hem = size.height / 812;
    final ffem = fem * 0.97;

    // Dựng một lần rồi dùng lại cho cả 5 dòng, thay vì gọi GoogleFonts 12 lần.
    final labelStyle = GoogleFonts.openSans(
      textStyle: TextStyle(
        fontSize: 15 * ffem,
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ),
    );
    final totalLabelStyle = GoogleFonts.openSans(
      textStyle: TextStyle(
        fontSize: 15 * ffem,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
    final valueStyle = GoogleFonts.openSans(
      textStyle: TextStyle(
        fontSize: 16 * ffem,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
    final priceStyle = GoogleFonts.openSans(
      textStyle: TextStyle(
        fontSize: 16 * ffem,
        fontWeight: FontWeight.bold,
        color: kPrimaryColor,
      ),
    );
    final totalStyle = GoogleFonts.openSans(
      textStyle: TextStyle(
        fontSize: 25 * ffem,
        fontWeight: FontWeight.bold,
        color: kPrimaryColor,
      ),
    );

    return SingleChildScrollView(
      // Không ép chiều cao bằng cả màn hình nữa: trước đây phần thân luôn cao
      // hơn vùng hiển thị (đã trừ app bar + thanh thanh toán) nên màn hình lúc
      // nào cũng cuộn được dù nội dung ngắn.
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15 * fem),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15 * hem),
            Text(
              'CHI TIẾT GIAO DỊCH',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 18 * ffem,
                  fontWeight: FontWeight.bold,
                  height: 1.3625 * ffem / fem,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 15 * hem),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 15 * fem,
                vertical: 5 * hem,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kPrimaryColor),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF757575).withValues(alpha: .3),
                    blurRadius: 10.0,
                    spreadRadius: 1.0,
                    offset: const Offset(5.0, 5.0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TransactionDetailRow(
                    height: 50 * hem,
                    label: 'Nội dung',
                    labelStyle: labelStyle,
                    value: SizedBox(
                      width: 200 * fem,
                      child: Text(
                        voucherName,
                        textAlign: TextAlign.end,
                        maxLines: 2,
                        softWrap: true,
                        style: valueStyle,
                      ),
                    ),
                  ),
                  TransactionDetailRow(
                    height: 50 * hem,
                    label: 'Chiến dịch',
                    labelStyle: labelStyle,
                    value: SizedBox(
                      width: 120 * fem,
                      child: Text(
                        campaignName,
                        textAlign: TextAlign.end,
                        maxLines: 2,
                        softWrap: true,
                        style: valueStyle,
                      ),
                    ),
                  ),
                  TransactionDetailRow(
                    height: 50 * hem,
                    label: 'Số coin',
                    labelStyle: labelStyle,
                    value: CoinAmount(
                      amount: priceVoucher,
                      style: priceStyle,
                      iconSize: 20 * fem,
                      iconPadding: EdgeInsets.only(
                        left: 2 * fem,
                        top: 4 * hem,
                        bottom: 2 * hem,
                      ),
                    ),
                  ),
                  TransactionDetailRow(
                    height: 50 * hem,
                    label: 'Số lượng',
                    labelStyle: labelStyle,
                    value: Text('$quantity', style: valueStyle),
                  ),
                  const SizedBox(width: double.infinity, child: Divider()),
                  TransactionDetailRow(
                    height: 50 * hem,
                    label: 'TỔNG COIN',
                    labelStyle: totalLabelStyle,
                    value: CoinAmount(
                      amount: total,
                      style: totalStyle,
                      iconSize: 27 * fem,
                      iconPadding: EdgeInsets.only(
                        left: 4 * fem,
                        top: 2 * hem,
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
