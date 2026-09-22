import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/brand_repository.dart';
import 'package:swallet_mobile/data/models/student_features/brand_model.dart';
import 'package:swallet_mobile/presentation/blocs/brand/brand_bloc.dart';
import 'package:swallet_mobile/presentation/screens/store_features/brand/components/brand_campaigns.dart';
import 'package:swallet_mobile/presentation/widgets/internet_listener.dart';

import '../../../../config/constants.dart';
import '../../../../widgets/shimmer_widget.dart';
import 'brand_detail_showdal.dart';
import 'detail_shadow_bottom.dart';
import 'infor_card_brand_detail.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    return InternetListener(
      child: BlocBuilder<BrandBloc, BrandState>(
        builder: (context, state) {
          if (state is BrandLoading) {
            return buildBrandDetailShimmer(fem, hem);
          }
          if (state is! BrandByIdLoaded) {
            return const SizedBox.shrink();
          }

          final brand = state.brand;

          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: size.width,
                            height: 180 * hem,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/background_splash.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 120 * hem),
                        ],
                      ),
                      Positioned(
                        top: 80 * hem,
                        left: 0,
                        right: 0,
                        child: InformationCardBrandDetail(
                          hem: hem,
                          fem: fem,
                          ffem: ffem,
                          brandModel: brand,
                        ),
                      ),
                    ],
                  ),
                  BrandDetailShadow(
                    fem: fem,
                    hem: hem,
                    ffem: ffem,
                    onTap: () => _showBrandDetailSheet(context, brand),
                    brandModel: brand,
                  ),
                  SizedBox(height: 15 * hem),
                  BlocProvider(
                    create:
                        (context) => BrandBloc(
                          brandRepository: context.read<BrandRepository>(),
                        )..add(
                          LoadBrandCampaignsById(
                            id: brand.id,
                            page: 1,
                            size: 10,
                          ),
                        ),
                    child: BrandCampaigns(fem: fem, ffem: ffem, hem: hem),
                  ),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget buildBrandDetailShimmer(double fem, double hem) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 120 * fem),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 15 * fem),
        color: Colors.white,
        child: ShimmerWidget.rectangular(height: 150 * hem),
      ),
      Container(
        margin: EdgeInsets.only(left: 15 * fem, right: 15 * fem, top: 20 * hem),
        child: ShimmerWidget.rectangular(height: 100 * hem),
      ),
      Container(
        margin: EdgeInsets.only(left: 15 * fem, right: 15 * fem, top: 20 * hem),
        child: ShimmerWidget.rectangular(height: 20 * hem, width: 150 * fem),
      ),
      for (var i = 0; i < 2; i++)
        Container(
          margin: EdgeInsets.only(left: 15 * fem, top: 20 * hem),
          child: ShimmerWidget.rectangular(height: 130 * hem, width: 320 * fem),
        ),
    ],
  );
}

void _showBrandDetailSheet(BuildContext context, BrandModel brandModel) {
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
            brandModel: brandModel,
          ),
        ),
  );
}
