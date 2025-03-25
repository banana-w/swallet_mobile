import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/store_features/campaign_voucher_store_model.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/store_features/campaign_voucher_detail/campaign_voucher_detail_screen.dart';

import '../../../../../data/models.dart';

class VoucherCardList extends StatelessWidget {
  const VoucherCardList({
    super.key,
    required this.hem,
    required this.fem,
    required this.voucher,
    required this.ffem,
  });

  final double hem;
  final double fem;
  final CampaignVoucherStoreModel voucher;
  final double ffem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final storeId = await AuthenLocalDataSource.getStoreId();
        Navigator.pushNamed(
          context,
          CampaignVoucherDetailScreen.routeName,
          arguments: <dynamic>[storeId, voucher.id],
        );
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 10 * hem,
              left: 10 * fem,
              right: 10 * fem,
            ),
            constraints: BoxConstraints(
              maxHeight: 140 * hem,
              minWidth: 340 * fem,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15 * fem),
              color: Colors.white,
              border: Border.all(color: klighGreyColor),
              boxShadow: [
                BoxShadow(
                  color: Color(0x0c000000),
                  offset: Offset(0 * fem, 0 * fem),
                  blurRadius: 5 * fem,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: 120 * fem,
                      height: 140 * hem,
                      child: Image.network(
                        voucher.voucherImage,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/images/image-404.jpg');
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8 * fem),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5 * hem),
                    SizedBox(
                      width: 200 * fem,
                      child: Text(
                        voucher.voucherName,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 14 * ffem,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5 * hem),
                    SizedBox(
                      width: 200 * fem,
                      child: Text(
                        'Còn lại: ${voucher.quantityInStock}',
                        softWrap: true,
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 12 * ffem,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 12 * hem,
            right: 20 * fem,
            child: InkWell(
              onTap: () async {
                final storeId = await AuthenLocalDataSource.getStoreId();
                Navigator.pushNamed(
                  context,
                  CampaignVoucherDetailScreen.routeName,
                  arguments: <dynamic>[storeId, voucher.id],
                );
              },
              child: Container(
                width: 85 * fem,
                height: 32 * hem,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: kPrimaryColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'Xem ngay',
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
