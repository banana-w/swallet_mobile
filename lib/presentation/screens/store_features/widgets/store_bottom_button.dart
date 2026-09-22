import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/constants.dart';

/// Nút hành động chính nằm trong `bottomNavigationBar` của các màn kết quả.
///
/// Màn quét hỏng, quét ưu đãi hỏng, giao dịch thành công và màn xác nhận ưu
/// đãi đều dùng chung một khối `BottomAppBar > GestureDetector > Container`
/// giống hệt nhau, chỉ khác nhãn và bề rộng.
class StoreBottomButton extends StatelessWidget {
  const StoreBottomButton({
    super.key,
    required this.label,
    required this.fem,
    required this.ffem,
    required this.hem,
    required this.onTap,
    this.width = 320,
  });

  final String label;
  final double fem;
  final double ffem;
  final double hem;
  final VoidCallback onTap;

  /// Bề rộng nút, tính theo hệ số thiết kế (sẽ nhân với [fem]).
  final double width;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: klighGreyColor,
      height: 80 * hem,
      elevation: 5,
      child: Center(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: width * fem,
            height: 45 * hem,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(10 * fem),
            ),
            child: Center(
              child: Text(
                label,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: 17 * ffem,
                    fontWeight: FontWeight.w600,
                    height: 1.3625 * ffem / fem,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
