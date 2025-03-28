import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/domain/interface_repositories/store_features/store_repository.dart';
import 'package:swallet_mobile/presentation/blocs/store/store_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/store_features/campaign/components/voucher_card_list.dart';

import '../../../widgets/shimmer_widget.dart';

class CampaignVoucherListScreen extends StatelessWidget {
  static const String routeName = '/campaign-voucher-list-store';

  static Route route({required String search}) {
    return MaterialPageRoute(
      builder: (_) => CampaignVoucherListScreen(search: search),
      settings: const RouteSettings(arguments: routeName),
    );
  }

  const CampaignVoucherListScreen({super.key, required this.search});
  final String search;

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
              StoreBloc(storeRepository: context.read<StoreRepository>())
                ..add(LoadStoreCampaignVouchers(search: search)),
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
              'Kết quả tìm kiếm',
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
          body: BlocBuilder<StoreBloc, StoreState>(
            builder: (context, state) {
              if (state is StoreCampaignVoucherLoading) {
                return buildVoucherShimmer(3, fem, hem);
              } else if (state is StoreCampaignVoucherLoaded) {
                if (state.campaignStoreCart.campaignVouchers.isEmpty) {
                  return Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      left: 15 * fem,
                      right: 15 * fem,
                      top: 20,
                    ),
                    height: 220 * hem,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/voucher-navbar-icon.svg',
                          width: 60 * fem,
                          colorFilter: ColorFilter.mode(
                            kLowTextColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              'Không tìm thấy',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate([
                          SizedBox(height: 20 * hem),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                state.campaignStoreCart.campaignVouchers.length,
                            itemBuilder: (context, index) {
                              return VoucherCardList(
                                hem: hem,
                                fem: fem,
                                voucher:
                                    state
                                        .campaignStoreCart
                                        .campaignVouchers[index],
                                ffem: ffem,
                              );
                            },
                          ),
                        ]),
                      ),
                    ],
                  );
                }
              }
              return buildVoucherShimmer(3, fem, hem);
            },
          ),
        ),
      ),
    );
  }
}

Widget buildVoucherShimmer(count, double fem, double hem) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: count,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(
              top: 15 * hem,
              left: 10 * fem,
              right: 10 * fem,
            ),
            constraints: BoxConstraints(
              maxHeight: 150 * hem,
              minWidth: 340 * fem,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15 * fem),
              color: Colors.white,
              border: Border.all(color: klighGreyColor),
              boxShadow: [
                BoxShadow(
                  color: Color(0x0c000000),
                  offset: Offset(0 * fem, 0 * fem),
                  blurRadius: 5 * fem,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerWidget.rectangular(height: 150 * hem, width: 140 * fem),
                SizedBox(width: 8 * fem),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ShimmerWidget.rectangular(
                      height: 15 * hem,
                      width: 150 * fem,
                    ),
                    ShimmerWidget.rectangular(
                      height: 15 * hem,
                      width: 200 * fem,
                    ),
                    ShimmerWidget.rectangular(
                      height: 15 * hem,
                      width: 200 * fem,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    ],
  );
}
