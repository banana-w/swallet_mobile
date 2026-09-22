import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/blocs/brand/brand_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

class OthersInforBrandDetail extends StatelessWidget {
  const OthersInforBrandDetail({
    super.key,
    required this.hem,
    required this.fem,
    required this.ffem,
  });

  final double hem;
  final double fem;
  final double ffem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10 * hem),
      child: BlocBuilder<BrandBloc, BrandState>(
        builder: (context, state) {
          // Chưa tải xong thì hiện 0 thay vì con số thật.
          final count =
              state is BrandByIdLoaded ? state.brand.numberOfCampaigns : 0;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StatColumn(
                icon: Icon(Icons.favorite, color: kPrimaryColor),
                label: '$count Theo dõi',
                fem: fem,
                ffem: ffem,
                hem: hem,
              ),
              _StatColumn(
                icon: SvgPicture.asset(
                  'assets/icons/campaign-navbar-icon.svg',
                  colorFilter: const ColorFilter.mode(
                    kPrimaryColor,
                    BlendMode.srcIn,
                  ),
                  width: 18 * fem,
                  height: 18 * hem,
                ),
                label: '$count Chiến dịch',
                fem: fem,
                ffem: ffem,
                hem: hem,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({
    required this.icon,
    required this.label,
    required this.fem,
    required this.ffem,
    required this.hem,
  });

  final Widget icon;
  final String label;
  final double fem;
  final double ffem;
  final double hem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40 * fem,
          height: 40 * hem,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[100],
          ),
          child: Center(child: icon),
        ),
        Text(
          label,
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontSize: 10 * fem,
              fontWeight: FontWeight.w600,
              height: 1.3625 * ffem / fem,
              color: kLowTextColor,
            ),
          ),
        ),
      ],
    );
  }
}
