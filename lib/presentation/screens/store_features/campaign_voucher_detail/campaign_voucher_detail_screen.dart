import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/campaign_repository.dart';
import 'package:swallet_mobile/presentation/blocs/campaign_voucher/campaign_voucher_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

import '../widgets/store_app_bar.dart';
import 'components/body.dart';

class CampaignVoucherDetailStoreScreen extends StatelessWidget {
  static const String routeName = '/campaign-voucher-detail-store';

  static Route route({
    required String campaignId,
    required String campaignVoucherId,
  }) {
    return MaterialPageRoute(
      builder:
          (_) => CampaignVoucherDetailStoreScreen(
            campaignId: campaignId,
            campaignVoucherId: campaignVoucherId,
          ),
      settings: const RouteSettings(name: routeName),
    );
  }

  const CampaignVoucherDetailStoreScreen({
    super.key,
    required this.campaignId,
    required this.campaignVoucherId,
  });

  final String campaignId;
  final String campaignVoucherId;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    return BlocProvider(
      create:
          (context) => CampaignVoucherBloc(
            campaignRepository: context.read<CampaignRepository>(),
          )..add(
            LoadCampaignVoucherById(
              campaignId: campaignId,
              campaignVoucherId: campaignVoucherId,
            ),
          ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: klighGreyColor,
          appBar: StoreAppBar(
            title: 'Chi tiết ưu đãi',
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
          body: const Body(),
        ),
      ),
    );
  }
}
