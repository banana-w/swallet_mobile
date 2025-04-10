import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.failed});

  final String failed;

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
                  // width: ,
                  child: Lottie.asset(
                    'assets/animations/failed-animation.json',
                    repeat: false,
                  ),
                ),
                Text(
                  'QUÉT THẤT BẠI!',
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
            SizedBox(height: 30 * hem),
            Container(
              width: double.infinity,
              height: 200 * hem,
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
                border: Border.all(color: kErrorTextColor),
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
                          '${_formatDateTime(DateTime.now())}',
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
                    height: 80 * hem,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nội dung',
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
                            '$failed',
                            textAlign: TextAlign.end,
                            maxLines: 3,
                            softWrap: true,
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
}

// String _formatDatetimeString(String date) {
//   DateTime dateTime = DateTime.parse(date).add(Duration(hours: 7));

//   String formattedDatetime = DateFormat("HH:mm - dd/MM/yyyy").format(dateTime);
//   return formattedDatetime;
// }

String _formatDateTime(DateTime datetime) {
  String formattedDatetime = DateFormat("HH:mm - dd/MM/yyyy").format(datetime);
  return formattedDatetime;
}
