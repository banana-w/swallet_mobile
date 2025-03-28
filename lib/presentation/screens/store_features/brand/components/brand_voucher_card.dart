import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:swallet_mobile/data/models/student_features/voucher_model.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

class BrandVoucherCard extends StatelessWidget {
  const BrandVoucherCard({
    super.key,
    required this.fem,
    required this.hem,
    required this.ffem,
    required this.voucherModel,
  });

  final double fem;
  final double hem;
  final double ffem;
  final VoucherModel voucherModel;

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('###,000');
    return Stack(
      children: [
        InkWell(
          child: Container(
            width: 172 * fem,
            margin: EdgeInsets.only(left: 20 * fem),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15 * fem),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 5 * hem,
                    right: 5 * fem,
                    left: 5 * fem,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10 * fem),
                      topRight: Radius.circular(10 * fem),
                    ),
                    child: Container(
                      height: 150 * hem,
                      width: 180 * fem,
                      child: Image.network(
                        voucherModel.image,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 170 * fem,
                            height: 180 * hem,
                            child: Icon(
                              Icons.error_sharp,
                              size: 50 * fem,
                              color: kPrimaryColor,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 10 * fem,
                    right: 10 * fem,
                    top: 5 * hem,
                  ),
                  child: Text(
                    voucherModel.voucherName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontSize: 13 * ffem,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 10 * fem,
          bottom: 5 * hem,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10 * fem),
                    child: Text(
                      '${formatter.format(voucherModel.price)}',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 14 * ffem,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w500,
                        ),
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
                      'assets/icons/green-bean-icon.svg',
                      width: 24 * fem,
                      height: 22 * fem,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
