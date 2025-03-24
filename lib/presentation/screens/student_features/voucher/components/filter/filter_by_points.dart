import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/student_features/voucher/components/filter/range_slider_point_custom.dart';

class FilterByPoints extends StatelessWidget {
  const FilterByPoints({
    super.key,
    required this.hem,
    required this.fem,
    required this.ffem,
  });

  final double hem;
  final double fem;
  final double ffem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 10 * hem,
            left: 25 * fem,
            right: 25 * fem,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10 * hem),
                child: Text(
                  'Giá trị đổi điểm',
                  style: GoogleFonts.openSans(
                    fontSize: 16 * ffem,
                    color: kLowTextColor,
                    fontWeight: FontWeight.w600,
                    height: 1.3625 * ffem / fem,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20 * hem),
                child: Text(
                  'Xóa tất cả',
                  style: GoogleFonts.openSans(
                    fontSize: 10 * ffem,
                    color: kLowTextColor,
                    fontWeight: FontWeight.w600,
                    height: 1.3625 * ffem / fem,
                  ),
                ),
              ),
            ],
          ),
        ),
        RangeSliderPointCustom(),
      ],
    );
  }
}
