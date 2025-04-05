import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_detail_model.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';


class BrandInformationCard extends StatelessWidget {
  const BrandInformationCard({
    super.key,
    required this.hem,
    required this.fem,
    required this.ffem,
    required this.campaignDetail,
  });

  final double hem;
  final double fem;
  final double ffem;
  final CampaignDetailModel campaignDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.only(top: 15 * hem, bottom: 15 * hem),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15 * fem),
            child: Text(
              'THƯƠNG HIỆU CUNG CẤP',
              style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                fontSize: 15 * ffem,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              )),
            ),
          ),
          SizedBox(
            height: 10*hem,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: 5 * hem, left: 15 * fem, bottom: 5 * hem),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey
                  )
                ),
                child: ClipRRect(
                  child: SizedBox(
                    width: 50 * fem,
                    height: 50 * hem,
                    child: Image.network(
                      campaignDetail.brandLogo,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/image-404.jpg',
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10 * fem,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 5 * hem),
                    child: Text(campaignDetail.brandName.toUpperCase(),
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                          fontSize: 16 * ffem,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ))),
                  ),
                  SizedBox(
                    width: 200 * fem,
                    // height: 45*hem,
                    child: Text(campaignDetail.brandAcronym,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                          fontSize: 14 * ffem,
                          color: klowTextGrey,
                          fontWeight: FontWeight.normal,
                        ))),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
