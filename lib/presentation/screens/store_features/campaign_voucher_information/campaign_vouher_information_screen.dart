import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/store_features/campaign_voucher_information_model.dart';
import 'package:swallet_mobile/domain/interface_repositories/store_features/store_repository.dart';
import 'package:swallet_mobile/presentation/blocs/campaign/campaign_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/store/store_bloc.dart';
import 'package:swallet_mobile/presentation/screens/store_features/failed_scan_voucher/failed_scan_voucher_screen.dart';
import 'package:swallet_mobile/presentation/screens/success_scan_voucher/success_scan_voucher_screen.dart';

import '../../../config/constants.dart';

class CampaignVoucherInformationScreen extends StatelessWidget {
  static const String routeName = '/campaign-voucher-information-store';

  static Route route({
    required CampaignVoucherInformationModel campaginVoucherInformation,
  }) {
    return PageRouteBuilder(
      pageBuilder:
          (_, __, ___) => BlocProvider(
            create:
                (context) =>
                    StoreBloc(storeRepository: context.read<StoreRepository>()),
            child: CampaignVoucherInformationScreen(
              campaginVoucherInformation: campaginVoucherInformation,
            ),
          ),
      transitionDuration: Duration(milliseconds: 400),
      transitionsBuilder: (_, animation, __, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
      settings: const RouteSettings(name: routeName),
    );
  }

  const CampaignVoucherInformationScreen({
    super.key,
    required this.campaginVoucherInformation,
  });

  final CampaignVoucherInformationModel campaginVoucherInformation;
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double baseHeight = 812;
    double ffem = fem * 0.97;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    return SafeArea(
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
          toolbarHeight: 40 * hem,
          centerTitle: true,
          title: Text(
            'Chi tiết ưu đãi',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 20 * ffem,
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
                icon: Icon(Icons.home, color: Colors.white, size: 30 * fem),
                onPressed: () {
                  context.read<CampaignBloc>().add(LoadCampaigns());
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
        bottomNavigationBar: BottomAppBar(
          color: klighGreyColor,
          height: 80 * hem,
          elevation: 5,
          child: GestureDetector(
            onTap: () async {
              final storeId = await AuthenLocalDataSource.getStoreId();
              context.read<StoreBloc>().add(
                ScanVoucherCode(
                  storeId: storeId!,
                  voucherCode: campaginVoucherInformation.voucherCode,
                  description: '',
                  state: true,
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    width: 250 * fem,
                    height: 45 * hem,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(10 * fem),
                    ),
                    child: Center(
                      child: Text(
                        'Xác nhận',
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 17 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.3625 * ffem / fem,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: BlocListener<StoreBloc, StoreState>(
          listener: (context, state) {
            if (state is ScanVoucherFailed) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                FailedScanVoucherScreen.routeName,
                (Route<dynamic> route) => false,
                arguments: state.error,
              );
            } else if (state is ScanVoucherLoading) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) {
                  Future.delayed(Duration(seconds: 5));
                  return AlertDialog(
                    content: Container(
                      width: 250,
                      height: 250,
                      child: Center(
                        child: CircularProgressIndicator(color: kPrimaryColor),
                      ),
                    ),
                  );
                },
              );
            } else if (state is ScanVoucherSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                SuccessScanVoucherScreen.routeName,
                (Route<dynamic> route) => false,
                arguments: state.result,
              );
            }
          },
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 220 * hem,
                        child: Image.network(
                          campaginVoucherInformation.voucherImage,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/background_splash.png',
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        width: double.infinity,
                        padding: EdgeInsets.only(
                          left: 15 * fem,
                          top: 10 * hem,
                          bottom: 15 * hem,
                          right: 15 * fem,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${campaginVoucherInformation.campaignName}',
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
                              padding: EdgeInsets.only(
                                top: 2 * hem,
                                bottom: 5 * hem,
                              ),
                              child: Text(
                                '${campaginVoucherInformation.voucherName}',
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
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${formatter.format((campaginVoucherInformation.price))}',
                                      style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                          fontSize: 22 * ffem,
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 0 * fem,
                                        top: 4 * hem,
                                        bottom: 0 * hem,
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/icons/green-bean-icon.svg',
                                        width: 32 * fem,
                                        height: 32 * fem,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 10 * fem,
                                    right: 10 * fem,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    border: Border.all(color: Colors.red),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        'x${campaginVoucherInformation.rate.toStringAsFixed(0)}',
                                        style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                            fontSize: 18 * ffem,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 5 * fem,
                                          top: 4 * hem,
                                          bottom: 0 * hem,
                                        ),
                                        child: SvgPicture.asset(
                                          'assets/icons/red-bean-icon.svg',
                                          width: 25 * fem,
                                          height: 25 * fem,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5 * hem),
                      Container(
                        color: Colors.white,
                        width: double.infinity,
                        padding: EdgeInsets.only(
                          left: 15 * fem,
                          top: 15 * hem,
                          bottom: 15 * hem,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/calendar-icon.svg',
                              width: 25 * fem,
                            ),
                            SizedBox(width: 10 * fem),
                            Text(
                              'Hạn sử dụng: ${changeFormateDate(campaginVoucherInformation.expireOn)}',
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
                      ),
                      SizedBox(height: 5 * hem),
                      Container(
                        color: Colors.white,
                        width: double.infinity,
                        padding: EdgeInsets.only(
                          top: 15 * hem,
                          bottom: 15 * hem,
                        ),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: 15 * fem),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    width: 120 * fem,
                                    height: 120 * hem,
                                    child: Image.network(
                                      campaginVoucherInformation.campaignImage,
                                      fit: BoxFit.fill,
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return Image.asset(
                                          'assets/images/image-404.jpg',
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10 * fem),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 5 * hem),
                                      child: Container(
                                        width: 200 * fem,
                                        child: Text(
                                          campaginVoucherInformation
                                              .campaignName
                                              .toUpperCase(),
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
                          ],
                        ),
                      ),
                      SizedBox(height: 5 * hem),
                      GestureDetector(
                        onTap: () {},
                        // onTap: () {
                        //   checkLength(campaignDetailModel.condition);
                        // },
                        child: Container(
                          padding: EdgeInsets.only(
                            right: 10 * fem,
                            left: 10 * fem,
                            top: 15 * hem,
                            bottom: 15 * hem,
                          ),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 0 * fem),
                                child: Text(
                                  'THỂ LỆ ƯU ĐÃI',
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      fontSize: 15 * ffem,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  left: 5 * fem,
                                  top: 5 * hem,
                                ),
                                child: HtmlWidget(
                                  '${campaginVoucherInformation.condition}',
                                  textStyle: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      fontSize: 14 * ffem,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10 * hem),
                              Padding(
                                padding: EdgeInsets.only(left: 0 * fem),
                                child: Text(
                                  'NỘI DUNG ƯU ĐÃI',
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      fontSize: 15 * ffem,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  left: 5 * fem,
                                  top: 5 * hem,
                                ),
                                child: HtmlWidget(
                                  '${campaginVoucherInformation.description}',
                                  textStyle: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      fontSize: 14 * ffem,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5 * hem),
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
