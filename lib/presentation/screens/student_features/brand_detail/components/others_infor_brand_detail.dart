import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/blocs/brand/brand_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

import '../../../../blocs/blocs.dart';

class OthersInforBrandDetail extends StatefulWidget {
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
  State<OthersInforBrandDetail> createState() => _OthersInforBrandDetailState();
}

class _OthersInforBrandDetailState extends State<OthersInforBrandDetail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10 * widget.hem,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  width: 40 * widget.fem,
                  height: 40 * widget.hem,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[100],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.favorite,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
              BlocBuilder<BrandBloc, BrandState>(
                builder: (context, state) {
                 if(state is BrandByIdLoaded){
                   return Text(
                    // '${state.brand.numberOfFollowers} Theo dõi',
                    '0 Theo dõi',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 10 * widget.fem,
                            fontWeight: FontWeight.w600,
                            color: kLowTextColor)),
                  );
                 } return Text(
                    '0 Theo dõi',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 10 * widget.fem,
                            fontWeight: FontWeight.w600,
                            color: kLowTextColor)),
                  );
                },
              )
            ],
          ),
          Column(
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  width: 40 * widget.fem,
                  height: 40 * widget.hem,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[100],
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/campaign-navbar-icon.svg',
                      colorFilter:
                          ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
                      width: 18 * widget.fem,
                      height: 18 * widget.hem,
                    ),
                  ),
                ),
              ),
              BlocBuilder<BrandBloc, BrandState>(
                builder: (context, state) {
                 if(state is BrandByIdLoaded){
                   return Text(
                    '${state.brand.numberOfCampaigns} Chiến dịch',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 10 * widget.fem,
                            fontWeight: FontWeight.w600,
                            height: 1.3625 * widget.ffem / widget.fem,
                            color: kLowTextColor)),
                  );
                 } return Text(
                    '0 Chiến dịch',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 10 * widget.fem,
                            fontWeight: FontWeight.w600,
                            height: 1.3625 * widget.ffem / widget.fem,
                            color: kLowTextColor)),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
