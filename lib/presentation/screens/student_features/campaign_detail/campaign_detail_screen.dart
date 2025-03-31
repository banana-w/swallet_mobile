import 'package:flutter/material.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

import 'components/body.dart';

class CampaignDetailStudentScreen extends StatelessWidget {
  static const String routeName = '/campaign-detail-student';

  static Route route({required String campaignId}) {
    return MaterialPageRoute(
      builder: (_) => CampaignDetailStudentScreen(
        campaignId: campaignId,
      ),
      settings: const RouteSettings(arguments: routeName),
    );
  }

  const CampaignDetailStudentScreen({super.key, required this.campaignId});

  final String campaignId;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          elevation: 0,
          toolbarHeight: 50 * hem,
          leading: Container(
            margin: EdgeInsets.only(left: 20 * fem),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(context,
                        '/landing-screen', (Route<dynamic> route) => false);
                  },
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
        body: Body(
          id: campaignId,
        ),
      ),
    );
  }
}
