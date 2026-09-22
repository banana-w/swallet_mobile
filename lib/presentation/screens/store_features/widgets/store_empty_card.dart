import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/constants.dart';

/// Thẻ trắng báo "chưa có dữ liệu" dùng chung cho các danh sách phía cửa hàng.
///
/// Danh sách ưu đãi, danh sách chiến dịch, kết quả tìm kiếm và lịch sử sử dụng
/// đều lặp lại đúng khối này, chỉ khác icon và câu chữ.
class StoreEmptyCard extends StatelessWidget {
  const StoreEmptyCard({
    super.key,
    required this.icon,
    required this.message,
    required this.fem,
    required this.hem,
    this.margin,
  });

  /// Đường dẫn tới file svg của icon.
  final String icon;
  final String message;
  final double fem;
  final double hem;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 220 * hem,
      margin: margin ?? EdgeInsets.symmetric(horizontal: 15 * fem),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            width: 60 * fem,
            colorFilter: const ColorFilter.mode(kLowTextColor, BlendMode.srcIn),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(height: 10 * fem),
        ],
      ),
    );
  }
}
