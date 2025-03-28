import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_detail_model.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../../config/constants.dart';
import '../../../../widgets/shimmer_widget.dart';

class DetailShowdalBottom extends StatelessWidget {
  const DetailShowdalBottom({
    super.key,
    required this.hem,
    required this.fem,
    required this.ffem,
    required this.campaignDetailModel,
  });

  final double hem;
  final double fem;
  final double ffem;
  final CampaignDetailModel campaignDetailModel;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      minChildSize: 1,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 15 * hem,
                    left: 25 * fem,
                    right: 25 * fem,
                    bottom: 15 * hem,
                  ),
                  child: Center(
                    child: Text(
                      'Thông tin chi tiết',
                      style: GoogleFonts.openSans(
                        fontSize: 16 * ffem,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 10 * fem, right: 10 * fem),
                  padding: EdgeInsets.only(top: 15 * hem, bottom: 15 * hem),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10 * hem),
                      Padding(
                        padding: EdgeInsets.only(left: 15 * fem),
                        child: Text(
                          'Thời gian chiến dịch',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 16 * ffem,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 5 * hem,
                          left: 15 * fem,
                          right: 15 * fem,
                        ),
                        child: Text(
                          '${changeFormateDate(campaignDetailModel.startOn)} - ${changeFormateDate(campaignDetailModel.endOn)}',
                          textAlign: TextAlign.justify,
                          softWrap: true,
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 15 * ffem,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15 * hem),
                      Padding(
                        padding: EdgeInsets.only(left: 15 * fem),
                        child: Text(
                          'Thể lệ chiến dịch',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 16 * ffem,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 5 * hem,
                          left: 15 * fem,
                          right: 15 * fem,
                        ),
                        // child: Text(
                        //   campaignDetailModel.condition,
                        //   textAlign: TextAlign.justify,
                        //   softWrap: true,
                        //   style: GoogleFonts.openSans(
                        //     textStyle: TextStyle(
                        //       fontSize: 13 * ffem,
                        //       color: Colors.black,
                        //       fontWeight: FontWeight.normal,
                        //     ),
                        //   ),
                        // ),
                        child: HtmlWidget(
                          '${campaignDetailModel.condition}',
                          textStyle: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 15 * ffem,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15 * hem),
                      Padding(
                        padding: EdgeInsets.only(left: 15 * fem),
                        child: Text(
                          'Nội dung chiến dịch',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 16 * ffem,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 5 * hem,
                          left: 15 * fem,
                          right: 15 * fem,
                        ),
                        child: HtmlWidget(
                          '${campaignDetailModel.description}',
                          textStyle: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 15 * ffem,
                              color: Colors.black,
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
          ),
        );
      },
    );
  }
}

Widget buildShowdalShimmer(double fem, double hem) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 80 * fem, right: 80 * fem, top: 20 * hem),
        child: ShimmerWidget.rectangular(height: 20 * hem),
      ),
      Container(
        margin: EdgeInsets.only(left: 15 * fem, right: 15 * fem, top: 20 * hem),
        child: ShimmerWidget.rectangular(height: 20 * hem, width: 100 * fem),
      ),
      Container(
        margin: EdgeInsets.only(left: 15 * fem, right: 15 * fem, top: 5 * hem),
        child: ShimmerWidget.rectangular(height: 20 * hem, width: 150 * fem),
      ),
      Container(
        margin: EdgeInsets.only(left: 15 * fem, right: 15 * fem, top: 20 * hem),
        child: ShimmerWidget.rectangular(height: 20 * hem, width: 100 * fem),
      ),
      Container(
        margin: EdgeInsets.only(left: 15 * fem, right: 15 * fem, top: 5 * hem),
        child: ShimmerWidget.rectangular(height: 20 * hem, width: 200 * fem),
      ),
      Container(
        margin: EdgeInsets.only(left: 15 * fem, right: 15 * fem, top: 20 * hem),
        child: ShimmerWidget.rectangular(height: 20 * hem, width: 100 * fem),
      ),
      Container(
        margin: EdgeInsets.only(left: 15 * fem, right: 15 * fem, top: 5 * hem),
        child: ShimmerWidget.rectangular(height: 20 * hem, width: 200 * fem),
      ),
      Container(
        margin: EdgeInsets.only(left: 15 * fem, right: 15 * fem, top: 20 * hem),
        child: ShimmerWidget.rectangular(height: 20 * hem, width: 100 * fem),
      ),
      Container(
        margin: EdgeInsets.only(left: 15 * fem, right: 15 * fem, top: 5 * hem),
        child: ShimmerWidget.rectangular(height: 80 * hem, width: 340 * fem),
      ),
    ],
  );
}
