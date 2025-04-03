import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.voucherName, required this.total});

  final String voucherName;
  final double total;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double baseHeight = 812;
    double ffem = fem * 0.97;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  color: klighGreyColor,
                  height: 150 * hem,
                  // width: ,
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
              ],
            ),
            SizedBox(height: 30 * hem),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 15 * fem, right: 15 * fem),
              padding: EdgeInsets.only(
                left: 15 * fem,
                right: 15 * fem,
                top: 5 * hem,
                bottom: 5 * hem,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kPrimaryColor),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50 * hem,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Thời gian thanh toán',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 15 * ffem,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Text(
                          '${_formatDateTime(DateTime.now())}',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50 * hem,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ưu đãi',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 15 * ffem,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 120 * fem,
                          child: Text(
                            '$voucherName',
                            maxLines: 2,
                            softWrap: true,
                            textAlign: TextAlign.end,
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                fontSize: 16 * ffem,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50 * hem,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tổng coin',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 15 * ffem,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${formatter.format(total)}',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  fontSize: 22 * ffem,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 5 * fem,
                                top: 4 * hem,
                                bottom: 2 * hem,
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/coin.svg',
                                width: 26 * fem,
                                height: 26 * fem,
                              ),
                            ),
                          ],
                        ),
                      ],
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

String _formatDateTime(DateTime datetime) {
  String formattedDatetime = DateFormat("HH:mm - dd/MM/yyyy").format(datetime);
  return formattedDatetime;
}
