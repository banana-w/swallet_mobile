import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/screens/student_features/voucher/components/filter/filter_body.dart';

class FilterVoucherScreen extends StatelessWidget {
  static const String routeName = '/filter-voucher-student';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const FilterVoucherScreen(),
      settings: const RouteSettings(arguments: routeName),
    );
  }

  const FilterVoucherScreen({super.key});

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
          toolbarHeight: 130 * hem,
          leading: Container(
            margin: EdgeInsets.only(left: 20 * fem),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50 * hem),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 35 * fem,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10 * fem),
                  child: Text(
                    'Bộ lọc',
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontSize: 20 * ffem,
                        fontWeight: FontWeight.w900,
                        height: 1.3625 * ffem / fem,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(top: 80 * hem, right: 25 * fem),
              child: Text(
                'Đặt lại',
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: 15 * ffem,
                    fontWeight: FontWeight.w600,
                    height: 1.3625 * ffem / fem,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
          leadingWidth: 200 * fem,
        ),
        body: FilterBody(),
      ),
    );
  }
}
