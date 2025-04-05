import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_detail_model.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_store_model.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

import '../../../../widgets/shimmer_widget.dart';
import 'body.dart';

class CampaignStoreCard extends StatelessWidget {
  const CampaignStoreCard({
    super.key,
    required this.fem,
    required this.hem,
    required this.campaignDetailModel,
    required this.storeModel,
    required this.ffem,
  });

  final double fem;
  final double hem;
  final CampaignDetailModel campaignDetailModel;
  final CampaignStoreModel storeModel;
  final double ffem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350 * fem,
      height: 85 * hem,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15 * fem),
        color: Colors.white,
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
                width: 70 * fem,
                height: 85 * hem,
                child: Image.network(
                  campaignDetailModel.brandLogo,
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 250 * fem,
                // height: 45*hem,
                child: Text(
                  storeModel.storeName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: 15 * ffem,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2 * hem),
              SizedBox(
                width: 250 * fem,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.access_time, 
                      size: 16 * ffem,
                      color: klowTextGrey,
                    ),
                    SizedBox(width: 5 * fem), // Khoảng cách giữa icon và text
                    Expanded(
                      child: Text(
                        ' ${formatTime(storeModel.openingHours ?? '00:00')} am - ${formatTime(storeModel.closingHours ?? '00:00')} pm',
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
                  ],
                ),
              ),
              SizedBox(height: 2 * hem),
              SizedBox(
                width: 220 * fem,
                // height: 45*hem,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16 * ffem,
                      color: klowTextGrey,
                    ),
                    SizedBox(width: 5 * fem), // Khoảng cách giữa icon và text
                    Expanded(
                      child: Text(
                        storeModel.address,
                        maxLines: 2,
                        softWrap: true,
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
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
