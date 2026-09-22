import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:swallet_mobile/data/models/store_features/campaign_voucher_store_model.dart';
import 'package:swallet_mobile/data/models/store_features/store_model.dart';
import 'package:swallet_mobile/presentation/blocs/store/store_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/widgets/internet_listener.dart';

import '../../widgets/store_empty_card.dart';
import 'search_bar_custom.dart';
import 'voucher_card_list.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.storeModel});

  final StoreModel storeModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    return InternetListener(
      child: BlocBuilder<StoreBloc, StoreState>(
        builder: (context, state) {
          if (state is StoreCampaignVoucherLoading) {
            return Center(
              child: Lottie.asset('assets/animations/loading-screen.json'),
            );
          }
          if (state is! StoreCampaignVoucherLoaded) {
            return const SizedBox.shrink();
          }

          final cart = state.campaignStoreCart;
          final campaigns = cart.voucherCampaign(cart.campaignVouchers);

          return RefreshIndicator(
            onRefresh: () async {
              context.read<StoreBloc>().add(LoadStoreCampaignVouchers());
            },
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: _Greeting(
                      storeName: storeModel.storeName,
                      fem: fem,
                      ffem: ffem,
                      hem: hem,
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 5 * hem)),
                  if (campaigns.isEmpty)
                    SliverToBoxAdapter(
                      child: Container(
                        color: kbgWhiteColor,
                        padding: EdgeInsets.symmetric(vertical: 15 * fem),
                        child: StoreEmptyCard(
                          icon: 'assets/icons/empty-icon.svg',
                          message: 'Không có ưu đãi \n đang diễn ra',
                          fem: fem,
                          hem: hem,
                        ),
                      ),
                    )
                  else
                    SliverToBoxAdapter(
                      child: Container(
                        color: kbgWhiteColor,
                        padding: EdgeInsets.symmetric(vertical: 15 * fem),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (final entry in campaigns.entries)
                              _CampaignGroup(
                                campaignName: entry.key.toString(),
                                vouchers: entry.value,
                                fem: fem,
                                ffem: ffem,
                                hem: hem,
                              ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Lời chào và ô tìm kiếm ở đầu tab ưu đãi.
class _Greeting extends StatelessWidget {
  const _Greeting({
    required this.storeName,
    required this.fem,
    required this.ffem,
    required this.hem,
  });

  final String storeName;
  final double fem;
  final double ffem;
  final double hem;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kbgWhiteColor,
      padding: EdgeInsets.symmetric(vertical: 15 * fem),
      child: Column(
        children: [
          Text(
            'Xin chào, $storeName!',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 21 * ffem,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            'Tham gia các hoạt động để tích lũy ưu đãi',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 12 * ffem,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          SizedBox(height: 10 * hem),
          const SearchBarCustom(),
        ],
      ),
    );
  }
}

/// Một chiến dịch kèm danh sách ưu đãi thuộc chiến dịch đó.
class _CampaignGroup extends StatelessWidget {
  const _CampaignGroup({
    required this.campaignName,
    required this.vouchers,
    required this.fem,
    required this.ffem,
    required this.hem,
  });

  final String campaignName;
  final List<CampaignVoucherStoreModel> vouchers;
  final double fem;
  final double ffem;
  final double hem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15 * hem),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 15 * fem),
            child: Text(
              campaignName.toUpperCase(),
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 15 * ffem,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          for (final voucher in vouchers)
            VoucherCardList(hem: hem, fem: fem, ffem: ffem, voucher: voucher),
          SizedBox(height: 15 * hem),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25 * fem),
            child: const Divider(),
          ),
        ],
      ),
    );
  }
}
