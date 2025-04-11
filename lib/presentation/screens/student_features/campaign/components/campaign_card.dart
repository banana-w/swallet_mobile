import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_model.dart';

import '../../../../config/constants.dart';
import '../../../../widgets/shimmer_widget.dart';

class CampaignCard extends StatelessWidget {
  const CampaignCard(
      {super.key,
      required this.fem,
      required this.hem,
      required this.ffem,
      required this.campaignModel,
      required this.onTap});

  final double fem;
  final double hem;
  final double ffem;
  final CampaignModel campaignModel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: 172 * fem,
            margin: EdgeInsets.only(left: 10 * fem),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15 * fem),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF757575).withValues(alpha: .3),
                    blurRadius: 10.0, // soften the shadow
                    spreadRadius: 1.0, //extend the shadow
                    offset: const Offset(
                      5.0, // Move to right 5  horizontally
                      5.0, // Move to bottom 5 Vertically
                    ),
                  )
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      right: 5 * fem, left: 5 * fem, top: 5 * hem),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10 * fem),
                        topRight: Radius.circular(10 * fem)),
                    child: SizedBox(
                      height: 150 * hem,
                      width: 180 * fem,
                      child: Image.network(
                        campaignModel.image,
                        fit: BoxFit.fill,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return ShimmerWidget.rectangular(height: 150 * hem);
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return SizedBox(
                            width: 170 * fem,
                            height: 180 * hem,
                            child: Image.asset(
                              'assets/images/image-404.jpg',
                              width: 40 * fem,
                              height: 40 * hem,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 150 * fem,
                      padding: EdgeInsets.only(top: 5 * hem),
                      child: Text(
                        campaignModel.brandName,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                          fontSize: 14 * ffem,
                          color: kLowTextColor,
                          fontWeight: FontWeight.normal,
                        )),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: 10 * fem, right: 10 * fem, top: 5 * hem),
                  child: Text(
                    campaignModel.campaignName,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                      fontSize: 15 * ffem,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
