import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/blocs/brand/brand_bloc.dart';
import 'package:swallet_mobile/presentation/screens/store_features/campaign_detail/campaign_detail_store_screen.dart';

import '../../../../widgets/shimmer_widget.dart';
import '../../widgets/store_empty_card.dart';
import 'campaign_list_card.dart';

class BrandCampaigns extends StatelessWidget {
  const BrandCampaigns({
    super.key,
    required this.fem,
    required this.ffem,
    required this.hem,
  });

  final double fem;
  final double ffem;
  final double hem;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandBloc, BrandState>(
      builder: (context, state) {
        if (state is! BrandCampaignsByIdLoaded) {
          return buildBrandVouchersShimmer(fem, hem);
        }

        final campaigns = state.campaignModels;
        if (campaigns.isEmpty) {
          return StoreEmptyCard(
            icon: 'assets/icons/empty-icon.svg',
            message: 'Không có chiến dịch nào \nđang diễn ra',
            fem: fem,
            hem: hem,
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 15 * fem),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 25 * fem, right: 20),
                child: Text(
                  'Chiến dịch đang diễn ra (${campaigns.length})',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: 16 * ffem,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              for (final campaignModel in campaigns)
                CampaignListCard(
                  fem: fem,
                  hem: hem,
                  ffem: ffem,
                  campaignModel: campaignModel,
                  // Trước đây thẻ bọc ngoài đẩy sang màn chi tiết của sinh
                  // viên, chỉ nút "Xem ngay" mới sang màn của cửa hàng; giờ
                  // cả thẻ cùng đi về một chỗ.
                  onTap:
                      () => Navigator.pushNamed(
                        context,
                        CampaignDetailStoreScreen.routeName,
                        arguments: campaignModel.id,
                      ),
                ),
            ],
          ),
        );
      },
    );
  }
}

Widget buildBrandVouchersShimmer(double fem, double hem) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (var i = 0; i < 2; i++)
        Container(
          margin: EdgeInsets.only(left: 15 * fem, top: 20 * hem),
          child: ShimmerWidget.rectangular(height: 130 * hem, width: 320 * fem),
        ),
    ],
  );
}
