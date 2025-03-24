import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRVoucherScreen extends StatelessWidget {
  static const String routeName = '/qr-voucher-student';

  static Route route({required String id}) {
    return MaterialPageRoute(
      builder: (_) => QRVoucherScreen(
        id: id,
      ),
      settings: const RouteSettings(name: routeName),
    );
  }

  const QRVoucherScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    // final roleState = context.watch<RoleAppBloc>().state;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 50 * hem,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 25 * fem,
              ),
            ),
            title: Text(
              'QR ưu đãi',
              style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                      fontSize: 22 * ffem,
                      fontWeight: FontWeight.w900,
                      color: Colors.white)),
            ),
            centerTitle: true,
          ),
          extendBodyBehindAppBar: true,
          extendBody: true,
          body: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background_splash.png'),
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15 * fem),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.only(top: 15 * hem, bottom: 15 * hem),
                    margin: EdgeInsets.only(right: 15 * hem, left: 15 * hem),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Đưa mã này để sử dụng ưu đãi',
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontSize: 15 * ffem,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black)),
                            ),
                            Icon(
                              Icons.arrow_drop_down_sharp,
                              size: 30,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5 * hem,
                        ),
                        Container(
                          padding: EdgeInsets.all(5 * fem),
                          width: 320 * fem,
                          height: 320 * hem,
                          child: QrImageView(
                            data: id,
                            padding: EdgeInsets.all(20 * fem),
                            version: QrVersions.auto,
                            backgroundColor: Colors.white,
                            eyeStyle: QrEyeStyle(
                              color: Colors.black,
                              eyeShape: QrEyeShape.square,
                            ),
                            dataModuleStyle: QrDataModuleStyle(
                              color: Colors.black,
                              dataModuleShape: QrDataModuleShape.square,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15 * hem,
                        ),
                      ],
                    ),
                  )
                ],
              ))),
    );
  }

  // Widget authenScreen(roleState, fem, hem, ffem, context) {
  //   if (roleState is RoleAppUnknown) {
  //     return _buildUnknown(fem, hem, ffem);
  //   } else if (roleState is RoleAppStudentVerified) {
  //     return _buildVerifiedStudent(fem, hem, ffem);
  //   } else if (roleState is RoleAppLoading) {
  //     return Scaffold(
  //         appBar: AppBarCampaign(hem: hem, ffem: ffem, fem: fem),
  //         body: Container(
  //             color: klighGreyColor,
  //             child: Center(
  //               child: Container(
  //                   child:
  //                       Lottie.asset('assets/animations/loading-screen.json')),
  //             )));
  //   }
  //   return _buildVerifiedStudent(fem, hem, ffem);
  // }

  // Widget _buildUnknown(double fem, double hem, double ffem) {
  //   return Scaffold(
  //       appBar: AppBarCampaign(hem: hem, ffem: ffem, fem: fem),
  //       body: Container(
  //           color: klighGreyColor,
  //           child:
  //               Center(child: CardForUnknow(fem: fem, hem: hem, ffem: ffem))));
  // }

  // Widget _buildVerifiedStudent(double fem, double hem, double ffem) {
  //   return SafeArea(
  //     child: Scaffold(
  //       appBar: AppBar(
  //         backgroundColor: Colors.transparent,
  //         elevation: 0,
  //         toolbarHeight: 160 * hem,
  //         title: Padding(
  //           padding: EdgeInsets.only(left: 20 * fem),
  //           child: Text(
  //             'UNI Student Bean',
  //             style: GoogleFonts.openSans(
  //                 textStyle: TextStyle(
  //                     fontSize: 30 * ffem,
  //                     fontWeight: FontWeight.w900,
  //                     height: 1.3625 * ffem / fem,
  //                     color: Colors.white)),
  //           ),
  //         ),
  //         actions: [
  //           // SvgPicture.asset('assets/icons/notification-icon.svg')
  //           Padding(
  //             padding: EdgeInsets.only(right: 20 * fem),
  //             child: IconButton(
  //               icon: Icon(
  //                 Icons.notifications,
  //                 color: Colors.white,
  //                 size: 35 * fem,
  //               ),
  //               onPressed: () {},
  //             ),
  //           ),
  //         ],
  //       ),
  //       extendBodyBehindAppBar: true,
  //       extendBody: true,
  //       body: Body(),
  //     ),
  //   );
  // }
}
