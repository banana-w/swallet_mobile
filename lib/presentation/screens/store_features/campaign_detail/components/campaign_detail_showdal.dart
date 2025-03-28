import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_detail_model.dart';
import '../../../../../data/models.dart';
import '../../../../config/constants.dart';

class CampaignDetailShowdal extends StatelessWidget {
  const CampaignDetailShowdal({
    super.key,
    required this.fem,
    required this.hem,
    required this.ffem,
    required this.onTap,
    required this.campaignDetailModel,
  });

  final double fem;
  final double hem;
  final double ffem;
  final VoidCallback onTap;
  final CampaignDetailModel campaignDetailModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      // onTap: () {
      //   checkLength(campaignDetailModel.condition);
      // },
      child: Container(
        margin: EdgeInsets.only(right: 15 * fem, left: 15 * fem),
        padding: EdgeInsets.only(
          right: 10 * fem,
          left: 10 * fem,
          top: 15 * hem,
          bottom: 15 * hem,
        ),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 0 * fem),
              child: Text(
                'Thể lệ chiến dịch',
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: 15 * ffem,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 5 * fem, top: 5 * hem),
              // height: campaignDetailModel.condition.length >= 200 ? 75 : 35,
              child: HtmlWidget(
                '${campaignDetailModel.condition}',
                textStyle: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: 14 * ffem,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10 * hem),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Xem thêm',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: 14 * ffem,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3 * fem, top: 2 * hem),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
