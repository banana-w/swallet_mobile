import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/blocs/brand/brand_bloc.dart';
import 'package:swallet_mobile/presentation/screens/store_features/campaign_detail/campaign_detail_store_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/campaign_detail/campaign_detail_screen.dart';

import '../../../../config/constants.dart';
import '../../../../widgets/shimmer_widget.dart';
import 'campaign_list_card.dart';

class BrandCampaigns extends StatelessWidget {
  const BrandCampaigns({
    super.key,
    required this.fem,
    required this.ffem,
    required this.hem,
    required this.id,
  });

  final double fem;
  final double ffem;
  final double hem;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<BrandBloc, BrandState>(
          builder: (context, state) {
            if (state is BrandCampaignsByIdLoaded) {
              if (state.campaignModels.isEmpty) {
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 15 * fem, right: 15 * fem),
                  height: 220 * hem,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/empty-icon.svg',
                        width: 60 * fem,
                        colorFilter: ColorFilter.mode(
                          kLowTextColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            'Không có chiến dịch nào \nđang diễn ra',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10 * fem),
                    ],
                  ),
                );
              } else {
                return Container(
                  padding: EdgeInsets.only(top: 15 * fem, bottom: 15 * fem),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 25 * fem, right: 20),
                        child: BlocBuilder<BrandBloc, BrandState>(
                          builder: (context, state) {
                            if (state is BrandCampaignsByIdLoaded) {
                              return Text(
                                'Chiến dịch đang diễn ra (${state.campaignModels.length})',
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    fontSize: 16 * ffem,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }
                            return Text(
                              'Chiến dịch đang diễn ra',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  fontSize: 16 * ffem,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.campaignModels.length,
                        itemBuilder: (context, index) {
                          final campaignModel = state.campaignModels[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                CampaignDetailStudentScreen.routeName,
                                arguments: campaignModel.id,
                              );
                            },
                            child: CampaignListCard(
                              fem: fem,
                              hem: hem,
                              ffem: ffem,
                              campaignModel: campaignModel,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  CampaignDetailStoreScreen.routeName,
                                  arguments: campaignModel.id,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }
            }
            return buildBrandVouchersShimmer(fem, hem);
          },
        ),
      ],
    );
  }
}

Widget buildBrandVouchersShimmer(double fem, double hem) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 15 * fem, top: 20 * hem),
        child: ShimmerWidget.rectangular(height: 130 * hem, width: 320 * fem),
      ),
      Container(
        margin: EdgeInsets.only(left: 15 * fem, top: 20 * hem),
        child: ShimmerWidget.rectangular(height: 130 * hem, width: 320 * fem),
      ),
    ],
  );
}
