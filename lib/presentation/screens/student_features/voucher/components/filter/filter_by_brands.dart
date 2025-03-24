import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

class FilterByBrands extends StatelessWidget {
  const FilterByBrands({
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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
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
                  'Thương hiệu',
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
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
            top: 20 * hem,
            left: 10 * fem,
            right: 10 * fem,
          ),
          child: Wrap(
            direction: Axis.horizontal,
            children:
                brands.map((item) {
                  return Container(
                    width: 80 * fem,
                    height: 40 * hem,
                    margin: EdgeInsets.only(left: 10 * fem, bottom: 8 * hem),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5 * fem),
                      color: kPrimaryColor,
                    ),
                    child: Center(
                      child: Text(
                        item,
                        style: GoogleFonts.openSans(
                          fontSize: 14 * ffem,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          height: 1.3625 * ffem / fem,
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}

List brands = ['Tất cả', 'McDonald', 'FPT', 'StarBuck', 'Domino', 'Loteria'];
