import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:swallet_mobile/data/models/store_features/transact_result_model.dart';
import 'package:swallet_mobile/presentation/blocs/campaign/campaign_bloc.dart';

import '../../../config/constants.dart';

class SuccessTransactScreen extends StatelessWidget {
  static const String routeName = '/success-transact-store';

  static Route route({required TransactResultModel transactResultModel}) {
    return PageRouteBuilder(
      pageBuilder:
          (_, __, ___) =>
              SuccessTransactScreen(transactResultModel: transactResultModel),
      transitionDuration: Duration(milliseconds: 400),
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

  const SuccessTransactScreen({super.key, required this.transactResultModel});

  final TransactResultModel transactResultModel;

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
            'Kết quả giao dịch',
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
            // SvgPicture.asset('assets/icons/notification-icon.svg')
            Padding(
              padding: EdgeInsets.only(right: 20 * fem),
              child: IconButton(
                icon: Icon(Icons.home, color: Colors.white, size: 30 * fem),
                onPressed: () {
                  context.read<CampaignBloc>().add(LoadCampaigns());
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/landing-screen-store',
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
              context.read<CampaignBloc>().add(LoadCampaigns());
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/landing-screen-store',
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
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      color: klighGreyColor,
                      height: 150 * hem,
                      // width: ,
                      child: Lottie.asset(
                        'assets/animations/success-animation.json',
                        repeat: false,
                      ),
                    ),
                    Container(
                      child: Text(
                        'GIAO DỊCH THÀNH CÔNG!',
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 18 * ffem,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40 * hem),
                Container(
                  width: double.infinity,
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
                      Container(
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
                              '${_formatDatetimeString(transactResultModel.dateCreated)}',
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
                      Container(
                        height: 50 * hem,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Người nhận',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Container(
                              width: 150 * fem,
                              child: Text(
                                '${transactResultModel.studentName}',
                                maxLines: 2,
                                softWrap: true,
                                textAlign: TextAlign.end,
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
                      Container(
                        height: 50 * hem,
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
                            Container(
                              width: 150 * fem,
                              child: Text(
                                '${transactResultModel.description}',
                                maxLines: 2,
                                softWrap: true,
                                textAlign: TextAlign.end,
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
                      Container(
                        height: 50 * hem,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Số đậu xanh',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Text(
                              '${formatter.format(transactResultModel.amount)}',
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
                    ],
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

String _formatDatetimeString(String date) {
  DateTime dateTime = DateTime.parse(date).add(Duration(hours: 7));

  String formattedDatetime = DateFormat("HH:mm - dd/MM/yyyy").format(dateTime);
  return formattedDatetime;
}
