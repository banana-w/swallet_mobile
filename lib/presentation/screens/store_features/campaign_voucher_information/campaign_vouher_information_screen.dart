import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/interface_repositories/store_features/store_repository.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_detail_model.dart';
import 'package:swallet_mobile/domain/entities/student_features/campaign_voucher_detail_model.dart';
import 'package:swallet_mobile/presentation/blocs/campaign/campaign_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/store/store_bloc.dart';
import 'package:swallet_mobile/presentation/screens/store_features/failed_scan_voucher/failed_scan_voucher_screen.dart';
import 'package:swallet_mobile/presentation/screens/success_scan_voucher/success_scan_voucher_screen.dart';

import '../../../config/constants.dart';
import '../widgets/store_app_bar.dart';
import '../widgets/store_bottom_button.dart';
import '../widgets/voucher_rules_card.dart';

class CampaignVoucherInformationScreen extends StatelessWidget {
  static const String routeName = '/campaign-voucher-information-store';

  static Route route({
    required CampaignDetailModel campaignModel,
    required CampaignVoucherDetailModel voucherModel,
    required String studentId,
    required String storeId,
    required String voucherItemId,
  }) {
    return PageRouteBuilder(
      pageBuilder:
          (_, _, _) => BlocProvider(
            create:
                (context) =>
                    StoreBloc(storeRepository: context.read<StoreRepository>()),
            child: CampaignVoucherInformationScreen(
              campaignModel: campaignModel,
              voucherModel: voucherModel,
              studentId: studentId,
              storeId: storeId,
              voucherItemId: voucherItemId,
            ),
          ),
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (_, animation, _, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        final offsetAnimation = animation.drive(Tween(begin: begin, end: end));

        return SlideTransition(position: offsetAnimation, child: child);
      },
      settings: const RouteSettings(name: routeName),
    );
  }

  const CampaignVoucherInformationScreen({
    super.key,
    required this.campaignModel,
    required this.voucherModel,
    required this.studentId,
    required this.storeId,
    required this.voucherItemId,
  });

  final CampaignDetailModel campaignModel;
  final CampaignVoucherDetailModel voucherModel;
  final String studentId;
  final String storeId;
  final String voucherItemId;

  void _onStoreState(BuildContext context, StoreState state) {
    if (state is ScanVoucherFailed) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        FailedScanVoucherScreen.routeName,
        (route) => false,
        arguments: state.error,
      );
    } else if (state is ScanVoucherLoading) {
      showDialog<void>(
        context: context,
        builder:
            (_) => const AlertDialog(
              content: SizedBox(
                width: 250,
                height: 250,
                child: Center(
                  child: CircularProgressIndicator(color: kPrimaryColor),
                ),
              ),
            ),
      );
    } else if (state is ScanVoucherSuccess) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        SuccessScanVoucherScreen.routeName,
        (route) => false,
        arguments: state.result,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    return SafeArea(
      child: Scaffold(
        backgroundColor: klighGreyColor,
        appBar: StoreAppBar(
          title: 'Chi tiết ưu đãi',
          fem: fem,
          ffem: ffem,
          hem: hem,
          toolbarHeight: 40,
          onHome: () {
            context.read<CampaignBloc>().add(const LoadCampaigns());
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/landing-screen-store',
              (route) => false,
            );
          },
        ),
        bottomNavigationBar: StoreBottomButton(
          label: 'Xác nhận',
          width: 250,
          fem: fem,
          ffem: ffem,
          hem: hem,
          onTap:
              () => context.read<StoreBloc>().add(
                ScanVoucherCode(
                  voucherId: voucherModel.id,
                  studentId: studentId,
                  storeId: storeId,
                  voucherItemId: voucherItemId,
                ),
              ),
        ),
        body: BlocListener<StoreBloc, StoreState>(
          listener: _onStoreState,
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(
                    width: double.infinity,
                    height: 220 * hem,
                    child: Image.network(
                      voucherModel.image,
                      fit: BoxFit.fill,
                      cacheWidth:
                          (size.width * MediaQuery.devicePixelRatioOf(context))
                              .round(),
                      errorBuilder:
                          (context, error, stackTrace) => Image.asset(
                            'assets/images/background_splash.png',
                            fit: BoxFit.cover,
                          ),
                    ),
                  ),
                  _SummaryCard(
                    campaignName: campaignModel.campaignName,
                    voucherName: voucherModel.voucherName,
                    price: voucherModel.price,
                    fem: fem,
                    ffem: ffem,
                    hem: hem,
                  ),
                  SizedBox(height: 5 * hem),
                  _ExpiryRow(
                    endOn: campaignModel.endOn,
                    fem: fem,
                    ffem: ffem,
                    hem: hem,
                  ),
                  SizedBox(height: 5 * hem),
                  _CampaignCard(
                    campaignModel: campaignModel,
                    fem: fem,
                    ffem: ffem,
                    hem: hem,
                  ),
                  SizedBox(height: 5 * hem),
                  VoucherRulesCard(
                    condition: voucherModel.condition,
                    description: voucherModel.description,
                    fem: fem,
                    ffem: ffem,
                    hem: hem,
                  ),
                  SizedBox(height: 5 * hem),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.campaignName,
    required this.voucherName,
    required this.price,
    required this.fem,
    required this.ffem,
    required this.hem,
  });

  final String campaignName;
  final String voucherName;
  final num price;
  final double fem;
  final double ffem;
  final double hem;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 15 * fem,
        right: 15 * fem,
        top: 10 * hem,
        bottom: 15 * hem,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            campaignName,
            textAlign: TextAlign.justify,
            softWrap: true,
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 15 * ffem,
                color: klowTextGrey,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2 * hem, bottom: 5 * hem),
            child: Text(
              voucherName,
              textAlign: TextAlign.justify,
              softWrap: true,
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 15 * ffem,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          VoucherPrice(
            price: price,
            fem: fem,
            ffem: ffem,
            hem: hem,
            iconSize: 25,
            iconLeftPadding: 5,
          ),
        ],
      ),
    );
  }
}

class _ExpiryRow extends StatelessWidget {
  const _ExpiryRow({
    required this.endOn,
    required this.fem,
    required this.ffem,
    required this.hem,
  });

  final String endOn;
  final double fem;
  final double ffem;
  final double hem;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.only(left: 15 * fem, top: 15 * hem, bottom: 15 * hem),
      child: Row(
        children: [
          SvgPicture.asset('assets/icons/calendar-icon.svg', width: 25 * fem),
          SizedBox(width: 10 * fem),
          Text(
            'Hạn sử dụng: ${changeFormateDate(endOn)}',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 15 * ffem,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CampaignCard extends StatelessWidget {
  const _CampaignCard({
    required this.campaignModel,
    required this.fem,
    required this.ffem,
    required this.hem,
  });

  final CampaignDetailModel campaignModel;
  final double fem;
  final double ffem;
  final double hem;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 15 * hem),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15 * fem),
            child: Text(
              'CHIẾN DỊCH CUNG CẤP',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 15 * ffem,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: 10 * hem),
          Row(
            children: [
              SizedBox(width: 15 * fem),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  width: 120 * fem,
                  height: 120 * hem,
                  child: Image.network(
                    campaignModel.image,
                    fit: BoxFit.fill,
                    // Ảnh hiển thị ở 120*fem.
                    cacheWidth:
                        (120 * fem * MediaQuery.devicePixelRatioOf(context))
                            .round(),
                    errorBuilder:
                        (context, error, stackTrace) =>
                            Image.asset('assets/images/image-404.jpg'),
                  ),
                ),
              ),
              SizedBox(width: 10 * fem),
              Padding(
                padding: EdgeInsets.only(top: 5 * hem),
                child: SizedBox(
                  width: 200 * fem,
                  child: Text(
                    campaignModel.campaignName.toUpperCase(),
                    softWrap: true,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontSize: 14 * ffem,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
