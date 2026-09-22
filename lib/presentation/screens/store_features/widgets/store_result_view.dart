import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

/// Biên lai kết quả cho các màn quét / giao dịch phía cửa hàng.
///
/// Màn quét sinh viên hỏng, quét ưu đãi hỏng và tặng đậu thành công dựng cùng
/// một bố cục: hình động ở trên, tiêu đề, rồi một thẻ viền màu chứa các dòng
/// "nhãn — giá trị". Ba bản sao trước đây chỉ khác hình động, màu viền và nội
/// dung các dòng.
class StoreResultView extends StatelessWidget {
  const StoreResultView({
    super.key,
    required this.animation,
    required this.title,
    required this.borderColor,
    required this.rows,
    required this.fem,
    required this.ffem,
    required this.hem,
    this.animationBackground = Colors.white,
    this.cardHeight,
    this.spacing = 30,
  });

  /// Đường dẫn tới file lottie hiển thị phía trên.
  final String animation;
  final Color animationBackground;
  final String title;
  final Color borderColor;
  final List<Widget> rows;
  final double fem;
  final double ffem;
  final double hem;

  /// Chiều cao cố định của thẻ biên lai; bỏ trống thì thẻ tự co theo nội dung.
  final double? cardHeight;

  /// Khoảng cách giữa tiêu đề và thẻ biên lai, theo hệ số thiết kế.
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          children: [
            Container(
              color: animationBackground,
              height: 150 * hem,
              child: Lottie.asset(animation, repeat: false),
            ),
            Text(
              title,
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 18 * ffem,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: spacing * hem),
            Container(
              width: double.infinity,
              height: cardHeight == null ? null : cardHeight! * hem,
              margin: EdgeInsets.symmetric(horizontal: 15 * fem),
              padding: EdgeInsets.symmetric(
                horizontal: 15 * fem,
                vertical: 5 * hem,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: borderColor),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: rows,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Một dòng "nhãn — giá trị" trong thẻ của [StoreResultView].
class StoreResultRow extends StatelessWidget {
  const StoreResultRow({
    super.key,
    required this.label,
    required this.value,
    required this.ffem,
    required this.hem,
    this.height = 50,
    this.valueWidth,
    this.fem = 1,
    this.maxLines = 1,
  });

  final String label;
  final String value;
  final double ffem;
  final double hem;

  /// Chiều cao dòng, theo hệ số thiết kế.
  final double height;

  /// Giới hạn bề rộng phần giá trị để text dài tự xuống dòng; cần [fem].
  final double? valueWidth;
  final double fem;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final valueText = Text(
      value,
      textAlign: TextAlign.end,
      maxLines: maxLines,
      softWrap: true,
      style: GoogleFonts.openSans(
        textStyle: TextStyle(
          fontSize: 15 * ffem,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );

    return SizedBox(
      height: height * hem,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 14 * ffem,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          valueWidth == null
              ? valueText
              : SizedBox(width: valueWidth! * fem, child: valueText),
        ],
      ),
    );
  }
}

/// Định dạng thời gian hiển thị trên biên lai.
String formatResultDateTime(DateTime dateTime) =>
    DateFormat('HH:mm - dd/MM/yyyy').format(dateTime);

/// Chuỗi thời gian từ API là UTC, cộng 7 tiếng để về giờ Việt Nam.
String formatResultDateTimeString(String date) =>
    formatResultDateTime(DateTime.parse(date).add(const Duration(hours: 7)));
