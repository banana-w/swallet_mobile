import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/data/interface_repositories/store_features/store_repository.dart';
import 'package:swallet_mobile/presentation/blocs/store/store_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/store_features/campaign/components/voucher_card_list.dart';

import '../../../widgets/shimmer_widget.dart';
import '../widgets/store_app_bar.dart';
import '../widgets/store_empty_card.dart';

class CampaignVoucherListScreen extends StatelessWidget {
  static const String routeName = '/campaign-voucher-list-store';

  static Route route({required String search}) {
    return MaterialPageRoute(
      builder: (_) => CampaignVoucherListScreen(search: search),
      settings: const RouteSettings(name: routeName),
    );
  }

  const CampaignVoucherListScreen({super.key, required this.search});

  final String search;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    return BlocProvider(
      create:
          (context) =>
              StoreBloc(storeRepository: context.read<StoreRepository>())
                ..add(LoadStoreCampaignVouchers(search: search)),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: klighGreyColor,
          appBar: StoreAppBar(
            title: 'Kết quả tìm kiếm',
            fem: fem,
            ffem: ffem,
            hem: hem,
            titleSize: 18,
            iconSize: 25,
            onBack: () => Navigator.pop(context),
            onHome:
                () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/landing-screen-store',
                  (route) => false,
                ),
          ),
          body: BlocBuilder<StoreBloc, StoreState>(
            builder: (context, state) {
              if (state is! StoreCampaignVoucherLoaded) {
                return buildVoucherShimmer(3, fem, hem);
              }

              final vouchers = state.campaignStoreCart.campaignVouchers;
              if (vouchers.isEmpty) {
                return StoreEmptyCard(
                  icon: 'assets/icons/voucher-navbar-icon.svg',
                  message: 'Không tìm thấy',
                  fem: fem,
                  hem: hem,
                  margin: EdgeInsets.only(
                    left: 15 * fem,
                    right: 15 * fem,
                    top: 20,
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.only(top: 20 * hem),
                itemCount: vouchers.length,
                itemBuilder:
                    (context, index) => VoucherCardList(
                      hem: hem,
                      fem: fem,
                      ffem: ffem,
                      voucher: vouchers[index],
                    ),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Khung chờ cho danh sách ưu đãi, dùng chung với màn tìm kiếm.
Widget buildVoucherShimmer(int count, double fem, double hem) {
  return ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: count,
    itemBuilder: (context, index) {
      return Container(
        margin: EdgeInsets.only(top: 15 * hem, left: 10 * fem, right: 10 * fem),
        constraints: BoxConstraints(maxHeight: 150 * hem, minWidth: 340 * fem),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15 * fem),
          color: Colors.white,
          border: Border.all(color: klighGreyColor),
          boxShadow: [
            BoxShadow(
              color: const Color(0x0c000000),
              offset: Offset(0 * fem, 0 * fem),
              blurRadius: 5 * fem,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerWidget.rectangular(height: 150 * hem, width: 140 * fem),
            SizedBox(width: 8 * fem),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ShimmerWidget.rectangular(height: 15 * hem, width: 150 * fem),
                ShimmerWidget.rectangular(height: 15 * hem, width: 200 * fem),
                ShimmerWidget.rectangular(height: 15 * hem, width: 200 * fem),
              ],
            ),
          ],
        ),
      );
    },
  );
}
