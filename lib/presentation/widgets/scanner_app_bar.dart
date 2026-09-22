import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Thanh tiêu đề trên nền ảnh splash dùng cho các màn quét mã QR.
///
/// Màn check-in và màn quét QR giảng viên trước đây chép lại y hệt khối này.
class ScannerAppBar extends StatelessWidget {
  const ScannerAppBar({
    super.key,
    required this.title,
    required this.fem,
    required this.hem,
    required this.ffem,
    this.bottom,
  });

  final String title;
  final double fem;
  final double hem;
  final double ffem;

  /// Phần gắn thêm bên dưới tiêu đề, ví dụ `TabBar`.
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background_splash.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 80 * hem,
            child: Padding(
              padding: EdgeInsets.only(top: 10 * hem),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 22 * ffem,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (bottom != null) bottom!,
        ],
      ),
    );
  }
}
