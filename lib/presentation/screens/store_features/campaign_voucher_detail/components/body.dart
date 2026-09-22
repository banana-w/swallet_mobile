import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/blocs/campaign_voucher/campaign_voucher_bloc.dart';
import 'package:swallet_mobile/presentation/widgets/internet_listener.dart';

import '../../../../config/constants.dart';
import '../../../../widgets/shimmer_widget.dart';
import '../../widgets/voucher_rules_card.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    return InternetListener(
      child: BlocBuilder<CampaignVoucherBloc, CampaignVoucherState>(
        builder: (context, state) {
          if (state is CampaignVoucherLoading) {
            return buildCampaignVoucherShimmer(fem, hem);
          }
          if (state is! CampaignVoucherByIdLoaded) {
            return const SizedBox.shrink();
          }

          final voucher = state.campaignVoucherDetail;

          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(
                    width: double.infinity,
                    height: 220 * hem,
                    child: Image.network(
                      voucher.image,
                      fit: BoxFit.fill,
                      cacheWidth:
                          (size.width * MediaQuery.devicePixelRatioOf(context))
                              .round(),
                      errorBuilder:
                          (context, error, stackTrace) => Image.asset(
                            'assets/images/background_splash.png',
                            fit: BoxFit.cover,
                          ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      left: 15 * fem,
                      right: 15 * fem,
                      top: 10 * hem,
                      bottom: 15 * hem,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          voucher.brandName,
                          textAlign: TextAlign.justify,
                          softWrap: true,
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 15 * ffem,
                              color: klowTextGrey,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 2 * hem,
                            bottom: 5 * hem,
                          ),
                          child: Text(
                            voucher.voucherName,
                            textAlign: TextAlign.justify,
                            softWrap: true,
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                fontSize: 15 * ffem,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        VoucherPrice(
                          price: voucher.price,
                          fem: fem,
                          ffem: ffem,
                          hem: hem,
                        ),
                        Text(
                          'Còn lại: ${voucher.numberOfItemsAvailable}',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 15 * ffem,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5 * hem),
                  VoucherRulesCard(
                    condition: voucher.condition,
                    description: voucher.description,
                    fem: fem,
                    ffem: ffem,
                    hem: hem,
                  ),
                  SizedBox(height: 5 * hem),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget buildCampaignVoucherShimmer(double fem, double hem) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.white,
          child: ShimmerWidget.rectangular(height: 200 * hem),
        ),
        Container(
          margin: EdgeInsets.only(
            left: 15 * fem,
            right: 15 * fem,
            top: 20 * hem,
          ),
          child: ShimmerWidget.rectangular(height: 50 * hem),
        ),
        Container(
          color: Colors.white,
          margin: EdgeInsets.only(
            left: 15 * fem,
            right: 15 * fem,
            top: 20 * fem,
          ),
          child: ShimmerWidget.rectangular(height: 150 * hem),
        ),
        Container(
          margin: EdgeInsets.only(
            left: 15 * fem,
            right: 15 * fem,
            top: 20 * hem,
          ),
          child: ShimmerWidget.rectangular(height: 20 * hem, width: 150 * fem),
        ),
        Row(
          children: [
            for (var i = 0; i < 2; i++)
              Container(
                margin: EdgeInsets.only(left: 15 * fem, top: 20 * hem),
                child: ShimmerWidget.rectangular(
                  height: 200 * hem,
                  width: 170 * fem,
                ),
              ),
          ],
        ),
      ],
    ),
  );
}
