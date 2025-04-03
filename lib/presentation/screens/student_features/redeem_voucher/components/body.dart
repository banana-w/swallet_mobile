import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.campignId,
    required this.campaignDetailId,
    required this.studentId,
    required this.quantity,
    required this.description,
    required this.voucherName,
    required this.campaignName,
    required this.total,
    required this.priceVoucher,
  });

  final String campignId;
  final String campaignDetailId;
  final String studentId;
  final int quantity;
  final String description;
  final String voucherName;
  final String campaignName;
  final double total;
  final double priceVoucher;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double baseHeight = 812;
    double ffem = fem * 0.97;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(left: 15 * fem, right: 15 * fem),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF757575).withValues(alpha: .3),
                    blurRadius: 10.0, // soften the shadow
                    spreadRadius: 1.0, //extend the shadow
                    offset: const Offset(
                      5.0, // Move to right 5  horizontally
                      5.0, // Move to bottom 5 Vertically
                    ),
                  ),
                ],
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
                          'Nội dung',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 15 * ffem,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 200 * fem,
                          child: Text(
                            '$voucherName',
                            textAlign: TextAlign.end,
                            maxLines: 2,
                            softWrap: true,
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
                          'Chiến dịch',
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
                            '$campaignName',
                            textAlign: TextAlign.end,
                            maxLines: 2,
                            softWrap: true,
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
                          'Số coin',
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
                              '${formatter.format(priceVoucher)}',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  fontSize: 16 * ffem,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 2 * fem,
                                top: 4 * hem,
                                bottom: 2 * hem,
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/coin.svg',
                                width: 20 * fem,
                                height: 20 * fem,
                              ),
                            ),
                          ],
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
                          'Số lượng',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 15 * ffem,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Text(
                          '$quantity',
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
                  SizedBox(width: double.infinity, child: Divider()),
                  SizedBox(
                    height: 50 * hem,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'TỔNG COIN',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 15 * ffem,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10 * fem),
                              child: Text(
                                '${formatter.format(total)}',
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    fontSize: 25 * ffem,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 4 * fem,
                                top: 2 * hem,
                                bottom: 2 * hem,
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/coin.svg',
                                width: 27 * fem,
                                height: 27 * fem,
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
