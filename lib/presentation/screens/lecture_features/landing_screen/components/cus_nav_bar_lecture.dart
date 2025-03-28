import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/models/nav_item.dart';
import 'package:swallet_mobile/presentation/blocs/landing_screen/landing_screen_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/student_features/landing/components/nav_painter.dart';

class CusNavLectureBar extends StatelessWidget {
  const CusNavLectureBar({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;

    return BlocBuilder<LandingScreenBloc, LandingScreenState>(
      builder: (context, state) {
        return CustomPaint(
          painter: NavPainter(),
          child: Container(
            height: 70 * hem,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:
                  NavItemStore.navItems.map((item) {
                    var index = NavItemStore.navItems.indexOf(item);
                    if (index == 1) {
                      return Container(
                        width: 50 * fem,
                        margin: EdgeInsets.only(top: 0 * hem, right: 40 * fem),
                        padding: EdgeInsets.only(top: 15.2 * hem),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              width: 3 * fem,
                              color:
                                  state.tabIndex == index
                                      ? kPrimaryColor
                                      : Colors.white10,
                            ),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<LandingScreenBloc>(
                              context,
                            ).add(TabChange(tabIndex: index));
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 20 * fem,
                                height: 20 * fem,
                                child:
                                    state.tabIndex == index
                                        ? item.icon
                                        : item.icon2,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 2 * hem),
                                child: Text(
                                  item.title,
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      fontSize: 8.5 * ffem,
                                      fontWeight: FontWeight.w900,
                                      height: 1.3625 * ffem / fem,
                                      color:
                                          state.tabIndex == index
                                              ? kPrimaryColor
                                              : kLowTextColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (index == 2) {
                      return Container(
                        width: 50 * fem,
                        margin: EdgeInsets.only(top: 0 * hem, left: 70 * fem),
                        padding: EdgeInsets.only(top: 15 * hem),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              width: 3 * fem,
                              color:
                                  state.tabIndex == index
                                      ? kPrimaryColor
                                      : Colors.white10,
                            ),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<LandingScreenBloc>(
                              context,
                            ).add(TabChange(tabIndex: index));
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 22.5 * fem,
                                height: 22.5 * fem,
                                child:
                                    state.tabIndex == index
                                        ? item.icon
                                        : item.icon2,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 0 * hem),
                                child: Text(
                                  item.title,
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      fontSize: 8.5 * ffem,
                                      fontWeight: FontWeight.w900,
                                      height: 1.3625 * ffem / fem,
                                      color:
                                          state.tabIndex == index
                                              ? kPrimaryColor
                                              : kLowTextColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return Container(
                      width: 50 * fem,
                      margin: EdgeInsets.only(
                        top: 0 * hem,
                        left: 5 * fem,
                        right: 5 * fem,
                      ),
                      padding: EdgeInsets.only(top: 15 * hem),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 3 * fem,
                            color:
                                state.tabIndex == index
                                    ? kPrimaryColor
                                    : Colors.white10,
                          ),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<LandingScreenBloc>(
                            context,
                          ).add(TabChange(tabIndex: index));
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 20 * fem,
                              height: 20 * fem,
                              child:
                                  state.tabIndex == index
                                      ? item.icon
                                      : item.icon2,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 2 * hem),
                              child: Text(
                                item.title,
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    fontSize: 8.5 * ffem,
                                    fontWeight: FontWeight.w900,
                                    height: 1.3625 * ffem / fem,
                                    color:
                                        state.tabIndex == index
                                            ? kPrimaryColor
                                            : kLowTextColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        );
      },
    );
  }
}
