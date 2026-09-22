import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/models/nav_item.dart';
import 'package:swallet_mobile/presentation/blocs/landing_screen/landing_screen_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/student_features/landing/components/nav_painter.dart';

class CusNavStoreBar extends StatelessWidget {
  const CusNavStoreBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    final items = NavItemStore.navItems;

    return BlocBuilder<LandingScreenBloc, LandingScreenState>(
      // Chỉ dựng lại khi tab đổi, không phải mỗi lần bloc phát state.
      buildWhen: (previous, current) => previous.tabIndex != current.tabIndex,
      builder: (context, state) {
        return CustomPaint(
          painter: NavPainter(),
          child: SizedBox(
            height: 70 * hem,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (var index = 0; index < items.length; index++)
                  _NavBarItem(
                    item: items[index],
                    isSelected: state.tabIndex == index,
                    onTap:
                        () => context.read<LandingScreenBloc>().add(
                          TabChange(tabIndex: index),
                        ),
                    fem: fem,
                    ffem: ffem,
                    hem: hem,
                    // Hai mục giữa phải né nút quét QR nổi ở chính giữa.
                    margin: switch (index) {
                      1 => EdgeInsets.only(right: 40 * fem),
                      2 => EdgeInsets.only(left: 70 * fem),
                      _ => EdgeInsets.symmetric(horizontal: 5 * fem),
                    },
                    iconSize: index == 2 ? 22.5 : 20,
                    topPadding: index == 1 ? 15.2 : 15,
                    labelPadding: index == 2 ? 0 : 2,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.fem,
    required this.ffem,
    required this.hem,
    required this.margin,
    required this.iconSize,
    required this.topPadding,
    required this.labelPadding,
  });

  final NavItemStore item;
  final bool isSelected;
  final VoidCallback onTap;
  final double fem;
  final double ffem;
  final double hem;
  final EdgeInsets margin;
  final double iconSize;
  final double topPadding;
  final double labelPadding;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? kNauVang : kIconColor;

    return Container(
      width: 50 * fem,
      margin: margin,
      padding: EdgeInsets.only(top: topPadding * hem),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 3 * fem,
            color: isSelected ? kNauVang : Colors.white10,
          ),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            SizedBox(
              width: iconSize * fem,
              height: iconSize * fem,
              child: isSelected ? item.icon : item.icon2,
            ),
            Padding(
              padding: EdgeInsets.only(top: labelPadding * hem),
              child: Text(
                item.title,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: 8.5 * ffem,
                    fontWeight: FontWeight.w900,
                    height: 1.3625 * ffem / fem,
                    color: color,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
