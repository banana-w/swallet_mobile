import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/models/student_features/brand_model.dart';

class DetailShowdalBottom extends StatelessWidget {
  const DetailShowdalBottom({
    super.key,
    required this.hem,
    required this.fem,
    required this.ffem,
    required this.brandModel,
  });

  final double hem;
  final double fem;
  final double ffem;
  final BrandModel brandModel;

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
                  width: MediaQuery.sizeOf(context).width,
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
                          'Thời gian làm việc',
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
                          // ' ${formatTime(brandModel.openingHours)} - ${formatTime(brandModel.closingHours)}.',
                          ' ${formatTime(brandModel.openingHours)} - ${formatTime(brandModel.closingHours)}.',
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
                          'Thông tin liên lạc',
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
                          'Địa chỉ email: ${brandModel.email}.',
                          // textAlign: TextAlign.justify,
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
                      Padding(
                        padding: EdgeInsets.only(
                          top: 5 * hem,
                          left: 15 * fem,
                          right: 15 * fem,
                        ),
                        child: Text(
                          'Số điện thoại: ${brandModel.phone}.',
                          // textAlign: TextAlign.justify,
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
                          'Thông tin về chiến dịch',
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
                          brandModel.description,
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

/// Giờ mở/đóng cửa từ API về dạng "HH:mm" (ngày ghép vào chỉ để parse được).
String formatTime(String inputTimeString) {
  final parsedTime = DateTime.parse('2024-01-01 $inputTimeString');
  return '${parsedTime.hour.toString().padLeft(2, '0')}:'
      '${parsedTime.minute.toString().padLeft(2, '0')}';
}
