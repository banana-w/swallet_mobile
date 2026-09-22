import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../config/constants.dart';

/// Khung màn hình kết quả: hoạt ảnh, dòng tiêu đề và một thẻ liệt kê chi tiết.
///
/// Ba màn kết quả (check-in thành công, check-in thất bại, quét QR giảng viên
/// thành công) trước đây chép lại y hệt nhau phần thanh điều hướng, nút "Trang
/// chủ" ở đáy và hàm `_formatDateTime` — tổng cộng hơn 120 dòng mỗi file.
class ResultScreenScaffold extends StatelessWidget {
  const ResultScreenScaffold({
    super.key,
    required this.appBarTitle,
    required this.animationAsset,
    required this.headline,
    required this.cardBorderColor,
    required this.cardHeight,
    required this.rows,
  });

  final String appBarTitle;
  final String animationAsset;
  final String headline;
  final Color cardBorderColor;

  /// Chiều cao thẻ chi tiết, tính theo hệ số `hem`.
  final double cardHeight;

  /// Các dòng chi tiết bên trong thẻ; dựng từ `hem`/`fem`/`ffem` đã tính sẵn.
  final List<Widget> Function(double fem, double hem, double ffem) rows;

  /// Nhãn thời gian được chốt một lần lúc mở màn hình.
  ///
  /// Trước đây mỗi màn gọi `DateTime.now()` ngay trong `build()`, nên chỉ cần
  /// một lần dựng lại (xoay máy, hiện bàn phím, snackbar) là "thời gian thực
  /// hiện" của giao dịch đã xong lại nhảy sang giờ mới.
  static String formatNow() =>
      DateFormat('HH:mm - dd/MM/yyyy').format(DateTime.now());

  void _goHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/landing-screen',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_splash.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          toolbarHeight: 50 * hem,
          centerTitle: true,
          title: Text(
            appBarTitle,
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 20 * ffem,
                fontWeight: FontWeight.w900,
                height: 1.3625 * ffem / fem,
                color: Colors.white,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20 * fem),
              child: IconButton(
                icon: Icon(Icons.home, color: Colors.white, size: 30 * fem),
                onPressed: () => _goHome(context),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: klighGreyColor,
          height: 80 * hem,
          elevation: 5,
          child: GestureDetector(
            onTap: () => _goHome(context),
            child: Center(
              child: Container(
                width: 320 * fem,
                height: 45 * hem,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10 * fem),
                ),
                child: Center(
                  child: Text(
                    'Trang chủ',
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
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: size.width,
            child: Column(
              children: [
                SizedBox(
                  height: 150 * hem,
                  child: Lottie.asset(animationAsset, repeat: false),
                ),
                Text(
                  headline,
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: 18 * ffem,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 30 * hem),
                Container(
                  width: double.infinity,
                  height: cardHeight * hem,
                  margin: EdgeInsets.symmetric(horizontal: 15 * fem),
                  padding: EdgeInsets.symmetric(
                    horizontal: 15 * fem,
                    vertical: 5 * hem,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: cardBorderColor),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: rows(fem, hem, ffem),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Kiểu chữ dùng cho nhãn bên trái của một dòng chi tiết.
TextStyle resultLabelStyle(double ffem) => GoogleFonts.openSans(
  textStyle: TextStyle(
    fontSize: 14 * ffem,
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  ),
);

/// Kiểu chữ dùng cho giá trị bên phải của một dòng chi tiết.
TextStyle resultValueStyle(double ffem, {Color color = Colors.black}) =>
    GoogleFonts.openSans(
      textStyle: TextStyle(
        fontSize: 15 * ffem,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
