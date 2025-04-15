import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:swallet_mobile/data/models/student_features/transaction_model.dart';
import '../../../../config/constants.dart';

class VoucherHistoryTransactionCard extends StatelessWidget {
  const VoucherHistoryTransactionCard({
    super.key,
    required this.fem,
    required this.hem,
    required this.ffem,
    required this.transaction,
  });

  final double fem;
  final double hem;
  final double ffem;
  final TransactionModel transaction;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 15 * hem),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0 * fem, vertical: 0),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15 * fem),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10 * fem),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x0c000000),
                offset: Offset(0 * fem, 10 * fem),
                blurRadius: 5 * fem,
              ),
            ],
          ),
          padding: EdgeInsets.all(
            10 * fem,
          ), // thêm padding để text không dính sát viền
          child: Column(
            mainAxisSize: MainAxisSize.min, // cho tự co chiều cao
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${transaction.voucherName}',
                style: GoogleFonts.openSans(
                  fontSize: 17 * ffem,
                  fontWeight: FontWeight.bold,
                  height: 1.3625 * ffem / fem,
                  color: kPrimaryColor,
                ),
              ),
              SizedBox(height: 5 * hem),
              Text(
                transaction.description.replaceAll(r'\n', '\n'),
                maxLines: 3,
                overflow: TextOverflow.ellipsis, // hoặc TextOverflow.fade
                style: GoogleFonts.openSans(
                  fontSize: 15 * ffem,
                  fontWeight: FontWeight.w500,
                  height: 1.3625 * ffem / fem,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5 * hem),
              Text(
                _formatDatetime(transaction.createdAt),
                style: GoogleFonts.openSans(
                  fontSize: 14 * ffem,
                  fontWeight: FontWeight.w600,
                  height: 1.3625 * ffem / fem,
                  color: kLowTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _formatDatetime(String date) {
  DateTime dateTime = DateTime.parse(date).add(Duration(hours: 7));

  String formattedDatetime = DateFormat("HH:mm - dd/MM/yyyy").format(dateTime);
  return formattedDatetime;
}
