import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/domain/interface_repositories/store_features/store_repository.dart';
import 'package:swallet_mobile/presentation/blocs/store/store_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

import 'components/body.dart';

class CampaignVoucherDetailScreen extends StatelessWidget {
  static const String routeName = '/campaign-voucher-detail-store';

  static Route route({
    required String storeId,
    required String campaignVoucherId,
  }) {
    return MaterialPageRoute(
      builder:
          (_) => CampaignVoucherDetailScreen(
            storeId: storeId,
            campaignVoucherId: campaignVoucherId,
          ),
      settings: const RouteSettings(arguments: routeName),
    );
  }

  const CampaignVoucherDetailScreen({
    super.key,
    required this.storeId,
    required this.campaignVoucherId,
  });
  final String storeId;
  final String campaignVoucherId;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double baseHeight = 812;
    double ffem = fem * 0.97;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    return BlocProvider(
      create:
          (context) =>
              StoreBloc(storeRepository: context.read<StoreRepository>())..add(
                LoadCampaignVoucherDetail(
                  storeId: storeId,
                  campaignVoucherId: campaignVoucherId,
                ),
              ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: klighGreyColor,
          appBar: AppBar(
            elevation: 0,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background_splash.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 25 * fem,
              ),
            ),
            toolbarHeight: 50 * hem,
            centerTitle: true,
            title: Text(
              'Chi tiết ưu đãi',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 18 * ffem,
                  fontWeight: FontWeight.w900,
                  height: 1.3625 * ffem / fem,
                  color: Colors.white,
                ),
              ),
            ),
            actions: [
              // SvgPicture.asset('assets/icons/notification-icon.svg')
              Padding(
                padding: EdgeInsets.only(right: 20 * fem),
                child: IconButton(
                  icon: Icon(Icons.home, color: Colors.white, size: 25 * fem),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/landing-screen-store',
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ),
            ],
          ),
          body: Body(),
        ),
      ),
    );
  }
}
