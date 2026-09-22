import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/constants.dart';

/// Khối "THỂ LỆ ƯU ĐÃI" và "NỘI DUNG ƯU ĐÃI" ở cuối màn chi tiết ưu đãi.
///
/// Màn chi tiết ưu đãi và màn xác nhận quét đều hiển thị đúng khối này.
class VoucherRulesCard extends StatelessWidget {
  const VoucherRulesCard({
    super.key,
    required this.condition,
    required this.description,
    required this.fem,
    required this.ffem,
    required this.hem,
  });

  /// Hai chuỗi HTML lấy thẳng từ API.
  final String condition;
  final String description;
  final double fem;
  final double ffem;
  final double hem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 10 * fem, vertical: 15 * hem),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('THỂ LỆ ƯU ĐÃI'),
          _sectionBody(condition),
          SizedBox(height: 10 * hem),
          _sectionTitle('NỘI DUNG ƯU ĐÃI'),
          _sectionBody(description),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) => Text(
    text,
    style: GoogleFonts.openSans(
      textStyle: TextStyle(
        fontSize: 15 * ffem,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  Widget _sectionBody(String html) => Padding(
    padding: EdgeInsets.only(left: 5 * fem, top: 5 * hem),
    child: HtmlWidget(
      html,
      textStyle: GoogleFonts.openSans(
        textStyle: TextStyle(
          fontSize: 14 * ffem,
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  );
}

/// Giá ưu đãi kèm icon đồng xu.
class VoucherPrice extends StatelessWidget {
  const VoucherPrice({
    super.key,
    required this.price,
    required this.fem,
    required this.ffem,
    required this.hem,
    this.iconSize = 32,
    this.iconLeftPadding = 0,
  });

  final num price;
  final double fem;
  final double ffem;
  final double hem;
  final double iconSize;
  final double iconLeftPadding;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          formatter.format(price),
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontSize: 22 * ffem,
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: iconLeftPadding * fem, top: 4 * hem),
          child: SvgPicture.asset(
            'assets/icons/coin.svg',
            width: iconSize * fem,
            height: iconSize * fem,
          ),
        ),
      ],
    );
  }
}
