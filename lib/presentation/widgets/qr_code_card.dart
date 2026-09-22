import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// Màn hình hiển thị một mã QR trên nền ảnh splash.
///
/// Trước đây `QRScreen` và `QRVoucherScreen` là hai bản sao giống nhau từng ký
/// tự, chỉ khác đúng hai chuỗi tiêu đề — kèm theo khoảng 70 dòng code đã bị
/// comment cũng được chép y hệt sang cả hai file.
class QrCodeCardScreen extends StatelessWidget {
  const QrCodeCardScreen({
    super.key,
    required this.id,
    required this.appBarTitle,
    required this.caption,
  });

  /// Dữ liệu được mã hoá vào mã QR.
  final String id;

  /// Tiêu đề trên thanh điều hướng.
  final String appBarTitle;

  /// Dòng mô tả nằm ngay phía trên mã QR.
  final String caption;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 50 * hem,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 25 * fem,
            ),
          ),
          title: Text(
            appBarTitle,
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 22 * ffem,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
          centerTitle: true,
        ),
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: Container(
          width: double.infinity,
          // Bỏ `height: MediaQuery.of(context).size.height`: Container đã nằm
          // trong body của Scaffold nên tự chiếm hết chiều cao khả dụng, còn
          // chiều cao màn hình thì không trừ appBar và bàn phím.
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_splash.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15 * fem),
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(vertical: 15 * hem),
              margin: EdgeInsets.symmetric(horizontal: 15 * fem),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          caption,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 15 * ffem,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down_sharp, size: 30),
                    ],
                  ),
                  SizedBox(height: 5 * hem),
                  SizedBox(
                    width: 320 * fem,
                    height: 320 * hem,
                    child: QrImageView(
                      data: id,
                      padding: EdgeInsets.all(20 * fem),
                      version: QrVersions.auto,
                      backgroundColor: Colors.white,
                      eyeStyle: const QrEyeStyle(
                        color: Colors.black,
                        eyeShape: QrEyeShape.square,
                      ),
                      dataModuleStyle: const QrDataModuleStyle(
                        color: Colors.black,
                        dataModuleShape: QrDataModuleShape.square,
                      ),
                    ),
                  ),
                  SizedBox(height: 15 * hem),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
