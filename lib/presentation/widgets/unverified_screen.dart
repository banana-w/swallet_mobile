import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/widgets/card_for_unverified.dart';

class UnverifiedScreen extends StatelessWidget {
  static const String routeName = '/unverified_screen';
  static Route route() {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => UnverifiedScreen(),
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

  const UnverifiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    return SafeArea(
      child: Scaffold(
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
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30 * fem,
            ),
          ),
          title: Text(
            'UniBean',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 22 * ffem,
                fontWeight: FontWeight.w900,
                height: 1.3625 * ffem / fem,
                color: Colors.white,
              ),
            ),
          ),
          // actions: [
          //   // SvgPicture.asset('assets/icons/notification-icon.svg')
          //   Padding(
          //     padding: EdgeInsets.only(right: 20 * fem),
          //     child: IconButton(
          //       icon: Icon(
          //         Icons.notifications,
          //         color: Colors.white,
          //         size: 28 * fem,
          //       ),
          //       onPressed: () {},
          //     ),
          //   ),
          // ],
        ),
        backgroundColor: klighGreyColor,
        body: Center(child: CardForUnVerified(fem: fem, hem: hem, ffem: ffem)),
      ),
    );
  }
}
