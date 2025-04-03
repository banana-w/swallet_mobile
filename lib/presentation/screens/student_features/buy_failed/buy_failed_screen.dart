import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/blocs/campaign/campaign_bloc.dart';
import 'components/body.dart';

import '../../../config/constants.dart';

class FailedBuyScreen extends StatelessWidget {
  static const String routeName = '/failed-student';

  static Route route({required String failed}) {
    return PageRouteBuilder(
        pageBuilder: (_, __, ___) => FailedBuyScreen(failed: failed),
        transitionDuration: Duration(milliseconds: 400),
        transitionsBuilder: (_, animation, __, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          var tween = Tween(begin: begin, end: end);
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
        settings: const RouteSettings(name: routeName));
  }

  const FailedBuyScreen({super.key, required this.failed});

  final String failed;

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
                    fit: BoxFit.cover)),
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
                    color: Colors.white)),
          ),
          actions: [
            // SvgPicture.asset('assets/icons/notification-icon.svg')
            Padding(
              padding: EdgeInsets.only(right: 20 * fem),
              child: IconButton(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 30 * fem,
                ),
                onPressed: () {
                  context.read<CampaignBloc>().add(LoadCampaigns());
                  Navigator.pushNamedAndRemoveUntil(context,
                      '/landing-screen', (Route<dynamic> route) => false);
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
                  Navigator.pushNamedAndRemoveUntil(context,
                      '/landing-screen', (Route<dynamic> route) => false);
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
                            borderRadius: BorderRadius.circular(10 * fem)),
                        child: Center(
                          child: Text(
                            'Trang chủ',
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    fontSize: 17 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.3625 * ffem / fem,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ))),
        body: Body(
          failed: failed,
        ),
      ),
    );
  }
}
