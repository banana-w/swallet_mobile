import 'package:flutter/material.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

import 'components/body.dart';

class CampaignDetailStoreScreen extends StatelessWidget {
  static const String routeName = '/campaign-detail-store';

  static Route route({required String campaignId}) {
    return MaterialPageRoute(
      builder: (_) => CampaignDetailStoreScreen(campaignId: campaignId),
      settings: const RouteSettings(name: routeName),
    );
  }

  const CampaignDetailStoreScreen({super.key, required this.campaignId});

  final String campaignId;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final hem = size.height / 812;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          elevation: 0,
          toolbarHeight: 50 * hem,
          leading: Container(
            margin: EdgeInsets.only(left: 20 * fem),
            // leadingWidth vô hạn nên cần Row để icon bám mép trái.
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap:
                      () => Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/landing-screen-store',
                        (route) => false,
                      ),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 35 * fem,
                  ),
                ),
              ],
            ),
          ),
          leadingWidth: double.infinity,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: klighGreyColor,
        extendBodyBehindAppBar: true,
        body: Body(id: campaignId),
      ),
    );
  }
}
