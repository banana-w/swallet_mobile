import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_model.dart';

import '../../../../config/constants.dart';
import '../../../../widgets/shimmer_widget.dart';

class CampaignListCard extends StatelessWidget {
  const CampaignListCard({
    super.key,
    required this.fem,
    required this.hem,
    required this.ffem,
    required this.campaignModel,
    required this.onTap,
  });

  final double fem;
  final double hem;
  final double ffem;
  final CampaignModel campaignModel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 15 * fem,
            right: 15 * fem,
            bottom: 15 * hem,
          ),
          width: double.infinity,
          height: 130 * hem,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15 * fem),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0xFF757575).withOpacity(0.3),
                blurRadius: 10.0, // soften the shadow
                spreadRadius: 1.0, //extend the shadow
                offset: const Offset(5.0, 5.0),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 5 * hem,
                  left: 5 * fem,
                  bottom: 5 * hem,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10 * fem),
                  child: SizedBox(
                    width: 120 * fem,
                    height: 150 * hem,
                    child: Image.network(
                      campaignModel.image,
                      fit: BoxFit.fill,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return ShimmerWidget.rectangular(height: 160 * hem);
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset('assets/images/image-404.jpg');
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10 * fem),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 5 * hem),
                    child: Text(
                      campaignModel.brandName,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 13 * ffem,
                          color: klowTextGrey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200 * fem,
                    // height: 45*hem,
                    child: Text(
                      campaignModel.campaignName,
                      maxLines: 1,
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
                  SizedBox(height: 2 * hem),
                  SizedBox(
                    width: 200 * fem,
                    child: Text(
                      'Thời gian tham gia chiến dịch:',
                      softWrap: true,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 13 * ffem,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200 * fem,
                    child: Text(
                      '${changeFormateDate(campaignModel.startOn)} - ${changeFormateDate(campaignModel.endOn)}',
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
          bottom: 25 * hem,
          right: 22 * fem,
          child: InkWell(
            onTap: onTap,
            child: Container(
              width: 60 * fem,
              height: 25 * hem,
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
                      fontSize: 10 * ffem,
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
    );
  }
}
