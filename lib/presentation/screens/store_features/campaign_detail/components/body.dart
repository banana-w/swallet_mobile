import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/campaign_repository.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_detail_model.dart';
import 'package:swallet_mobile/presentation/blocs/campaign/campaign_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/widgets/internet_listener.dart';

import '../../../../widgets/shimmer_widget.dart';
import 'campaign_detail_showdal.dart';
import 'detail_showdal_bottom.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    return BlocProvider(
      create:
          (context) => CampaignBloc(
            campaignRepository: context.read<CampaignRepository>(),
          )..add(LoadCampaignById(id: id)),
      child: InternetListener(
        child: BlocBuilder<CampaignBloc, CampaignState>(
          builder: (context, state) {
            if (state is CampaignLoading) {
              return buildCampaignDetailShimmer(fem, hem);
            }
            if (state is! CampaignByIdLoaded) {
              return const Center(child: Text('Error'));
            }

            final campaign = state.campaignDetailModel;

            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    Stack(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 200 * hem,
                              width: size.width,
                              child: Image.network(
                                campaign.image,
                                fit: BoxFit.cover,
                                cacheWidth:
                                    (size.width *
                                            MediaQuery.devicePixelRatioOf(
                                              context,
                                            ))
                                        .round(),
                                loadingBuilder: (
                                  context,
                                  child,
                                  loadingProgress,
                                ) {
                                  if (loadingProgress == null) return child;
                                  return ShimmerWidget.rectangular(
                                    height: 200 * hem,
                                  );
                                },
                                errorBuilder:
                                    (context, error, stackTrace) => Image.asset(
                                      'assets/images/background_splash.png',
                                      fit: BoxFit.cover,
                                    ),
                              ),
                            ),
                            SizedBox(height: 100 * hem),
                          ],
                        ),
                        Positioned(
                          top: 140 * hem,
                          left: 0,
                          right: 0,
                          child: _CampaignHeaderCard(
                            campaign: campaign,
                            fem: fem,
                            ffem: ffem,
                            hem: hem,
                          ),
                        ),
                      ],
                    ),
                    CampaignDetailShowdal(
                      fem: fem,
                      hem: hem,
                      ffem: ffem,
                      campaignDetailModel: campaign,
                      onTap: () => _showCampaignDetailSheet(context, campaign),
                    ),
                    SizedBox(height: 30 * hem),
                  ]),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Thẻ tên chiến dịch + thương hiệu, đè lên ảnh bìa.
class _CampaignHeaderCard extends StatelessWidget {
  const _CampaignHeaderCard({
    required this.campaign,
    required this.fem,
    required this.ffem,
    required this.hem,
  });

  final CampaignDetailModel campaign;
  final double fem;
  final double ffem;
  final double hem;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140 * hem,
      width: MediaQuery.sizeOf(context).width,
      margin: EdgeInsets.symmetric(horizontal: 15 * fem),
      padding: EdgeInsets.symmetric(vertical: 5 * hem),
      constraints: const BoxConstraints(maxHeight: double.infinity),
      decoration: BoxDecoration(
        border: Border.all(color: kPrimaryColor),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0x0c000000),
            offset: Offset(0 * fem, 10 * fem),
            blurRadius: 5 * fem,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 300 * fem,
            child: Text(
              campaign.campaignName,
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 18 * ffem,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 240 * fem,
            child: const Divider(color: Colors.grey, thickness: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10 * fem),
                child: SizedBox(
                  height: 35 * hem,
                  width: 35 * fem,
                  child: Image.network(
                    campaign.image,
                    fit: BoxFit.fill,
                    // Ảnh chỉ 35x35.
                    cacheWidth:
                        (35 * fem * MediaQuery.devicePixelRatioOf(context))
                            .round(),
                    errorBuilder:
                        (context, error, stackTrace) =>
                            Image.asset('assets/images/image-404.jpg'),
                  ),
                ),
              ),
              SizedBox(width: 5 * fem),
              Text(
                campaign.brandName,
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: 16 * ffem,
                    color: klowTextGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void _showCampaignDetailSheet(
  BuildContext context,
  CampaignDetailModel campaignModel,
) {
  final size = MediaQuery.sizeOf(context);
  final fem = size.width / 375;
  final ffem = fem * 0.97;
  final hem = size.height / 812;

  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder:
        (_) => Container(
          height: 500 * hem,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15 * fem),
            color: klighGreyColor,
          ),
          child: DetailShowdalBottom(
            hem: hem,
            fem: fem,
            ffem: ffem,
            campaignDetailModel: campaignModel,
          ),
        ),
  );
}

Widget buildCampaignDetailShimmer(double fem, double hem) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 100 * fem),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 15 * fem),
        color: Colors.white,
        child: ShimmerWidget.rectangular(height: 150 * hem),
      ),
      Container(
        margin: EdgeInsets.only(left: 15 * fem, right: 15 * fem, top: 20 * hem),
        child: ShimmerWidget.rectangular(height: 120 * hem),
      ),
      Container(
        margin: EdgeInsets.only(left: 15 * fem, right: 15 * fem, top: 20 * hem),
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
  );
}
