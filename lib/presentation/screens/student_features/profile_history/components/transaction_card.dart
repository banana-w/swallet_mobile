import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:swallet_mobile/data/models/student_features/transaction_model.dart';
import '../../../../config/constants.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
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
        height: 100 * hem,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100 * hem,
              margin: EdgeInsets.only(right: 15 * fem, left: 15 * fem),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10 * fem),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x0c000000),
                        offset: Offset(0 * fem, 10 * fem),
                        blurRadius: 5 * fem)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10 * fem),
                    child: Text(
                      '${transaction.voucherName}',
                      style: GoogleFonts.openSans(
                          fontSize: 17 * ffem,
                          fontWeight: FontWeight.bold,
                          height: 1.3625 * ffem / fem,
                          color: kPrimaryColor),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10 * fem),
                    width: 200 * fem,
                    child: Text('${transaction.description}',
                        maxLines: 2,
                        style: GoogleFonts.openSans(
                            fontSize: 15 * ffem,
                            fontWeight: FontWeight.w500,
                            height: 1.3625 * ffem / fem,
                            color: Colors.black)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10 * fem, top: 5 * hem),
                    child: Text(_formatDatetime(transaction.createdAt),
                        style: GoogleFonts.openSans(
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.3625 * ffem / fem,
                            color: kLowTextColor)),
                  ),
                ],
              ),
            ),
            Positioned(
                right: 25 * fem,
                top: 10 * hem,
                child: _buildAmount(fem, hem, ffem, transaction))
          ],
        ));
  }
}

Widget _buildAmount(
    double fem, double hem, double ffem, TransactionModel transaction) {
  if ("transaction.walletTypeId" == "transaction.walletTypeId" && transaction.amount > 0) {
    return Container(
      height: 40 * hem,
      width: 125 * fem,
      padding: EdgeInsets.only(left: 10 * fem, right: 10 * fem),
      decoration: BoxDecoration(
          border: Border.all(color: kPrimaryColor, width: 1),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8 * fem)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '+${formatter.format(transaction.amount)}',
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
                textStyle: TextStyle(
              fontSize: 16 * ffem,
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            )),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: 6 * fem, top: 2 * hem, bottom: 2 * hem),
            child: SvgPicture.asset(
              'assets/icons/coin.svg',
              width: 22 * fem,
              height: 22 * fem,
            ),
          )
        ],
      ),
    );
  } 
  // else if (transaction.walletTypeId == 2 && transaction.amount > 0) {
  //   return Container(
  //     height: 40 * hem,
  //     width: 125 * fem,
  //     padding: EdgeInsets.only(left: 10 * fem, right: 10 * fem),
  //     decoration: BoxDecoration(
  //         border: Border.all(color: kPrimaryColor, width: 1),
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(8 * fem)),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Text(
  //           '${formatter.format(transaction.amount)}',
  //           style: GoogleFonts.openSans(
  //               textStyle: TextStyle(
  //             fontSize: 16 * ffem,
  //             color: kPrimaryColor,
  //             fontWeight: FontWeight.bold,
  //           )),
  //         ),
  //         Padding(
  //           padding:
  //               EdgeInsets.only(left: 5 * fem, top: 4 * hem, bottom: 2 * hem),
  //           child: SvgPicture.asset(
  //             'assets/icons/red-bean-icon.svg',
  //             width: 22 * fem,
  //             height: 20 * fem,
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // } 
  else if ("transaction.walletTypeId" == "transaction.walletTypeId" && transaction.amount < 0) {
    return Container(
      height: 40 * hem,
      width: 125 * fem,
      padding: EdgeInsets.only(left: 10 * fem, right: 10 * fem),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 1),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8 * fem)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${formatter.format(transaction.amount)}',
            style: GoogleFonts.openSans(
                textStyle: TextStyle(
              fontSize: 16 * ffem,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            )),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: 6 * fem, top: 2 * hem, bottom: 2 * hem),
            child: SvgPicture.asset(
              'assets/icons/coin.svg',
              width: 22 * fem,
              height: 22 * fem,
            ),
          )
        ],
      ),
    );
  } else {
    return Container(
      height: 40 * hem,
      width: 125 * fem,
      padding: EdgeInsets.only(left: 10 * fem, right: 10 * fem),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 1),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8 * fem)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${formatter.format(transaction.amount)}',
            style: GoogleFonts.openSans(
                textStyle: TextStyle(
              fontSize: 16 * ffem,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            )),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: 5 * fem, top: 4 * hem, bottom: 2 * hem),
            child: SvgPicture.asset(
              'assets/icons/coin.svg',
              width: 22 * fem,
              height: 20 * fem,
            ),
          )
        ],
      ),
    );
  }
}

String _formatDatetime(String date) {
  DateTime dateTime = DateTime.parse(date).add(Duration(hours: 7));

  String formattedDatetime = DateFormat("HH:mm - dd/MM/yyyy").format(dateTime);
  return formattedDatetime;
}
