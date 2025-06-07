import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:swallet_mobile/data/models/lecture_features/qr_response.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

class SuccessScanLectureQRScreen extends StatelessWidget {
  static const String routeName = '/success-scan-lecture-qr';

  const SuccessScanLectureQRScreen({super.key, required this.response});

  final ScanQRResponse response;

  static Route route({required ScanQRResponse response}) {
    return PageRouteBuilder(
      pageBuilder:
          (_, __, ___) => SuccessScanLectureQRScreen(response: response),
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (_, animation, __, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double baseHeight = 812;
    double ffem = fem * 0.97;
    double hem = MediaQuery.of(context).size.height / baseHeight;

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
            'Kết quả quét mã QR',
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
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/landing-screen',
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: klighGreyColor,
          height: 80 * hem,
          elevation: 5,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/landing-screen',
                (Route<dynamic> route) => false,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
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
              ],
            ),
          ),
        ),
        body: SuccessScanLectureQRBody(response: response),
      ),
    );
  }
}

class SuccessScanLectureQRBody extends StatelessWidget {
  const SuccessScanLectureQRBody({super.key, required this.response});

  final ScanQRResponse response;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double baseHeight = 812;
    double ffem = fem * 0.97;
    double hem = MediaQuery.of(context).size.height / baseHeight;

    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  color: Colors.white,
                  height: 150 * hem,
                  child: Lottie.asset(
                    'assets/animations/success-animation.json',
                    repeat: false,
                  ),
                ),
                Text(
                  'QUÉT MÃ QR THÀNH CÔNG!',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: 18 * ffem,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50 * hem),
            Container(
              width: double.infinity,
              height: 250 * hem,
              margin: EdgeInsets.only(left: 15 * fem, right: 15 * fem),
              padding: EdgeInsets.only(
                left: 15 * fem,
                right: 15 * fem,
                top: 5 * hem,
                bottom: 5 * hem,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kPrimaryColor),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50 * hem,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Thời gian thực hiện',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Text(
                          _formatDateTime(DateTime.now()),
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 15 * ffem,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 30 * hem,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Điểm nhận được',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 200 * fem,
                          child: Text(
                            '${response.pointsTransferred} xu',
                            textAlign: TextAlign.end,
                            maxLines: 1,
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                fontSize: 15 * ffem,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40 * hem,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Số dư mới',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 200 * fem,
                          child: Text(
                            '${response.newBalance} xu',
                            textAlign: TextAlign.end,
                            maxLines: 1,
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                fontSize: 15 * ffem,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime datetime) {
    return DateFormat("HH:mm - dd/MM/yyyy").format(datetime);
  }
}
