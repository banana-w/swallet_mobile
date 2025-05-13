import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_detail_model.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/campaign_repository.dart';
import 'package:swallet_mobile/presentation/blocs/campaign_store/campaign_store_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/store_features/campaign_voucher_list/campaign_voucher_list_screen.dart';

import '../../../widgets/shimmer_widget.dart';
import '../campaign_detail/components/body.dart';

class StoreListScreen extends StatelessWidget {
  static const String routeName = '/store-list-student';

  static Route route(
      {required String brandId,
      required CampaignDetailModel campaignDetailModel}) {
    return MaterialPageRoute(
        builder: (_) => StoreListScreen(
              brandId: brandId,
              campaignDetailModel: campaignDetailModel,
            ),
        settings: const RouteSettings(arguments: routeName));
  }

  const StoreListScreen(
      {super.key, required this.brandId, required this.campaignDetailModel});
  final String brandId;
  final CampaignDetailModel campaignDetailModel;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double baseHeight = 812;
    double ffem = fem * 0.97;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    return BlocProvider(
      create: (context) => CampaignStoreBloc(
          campaignRepository: context.read<CampaignRepository>())
        ..add(LoadCampaignStoreById(id: brandId)),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: klighGreyColor,
          appBar: AppBar(
            elevation: 0,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background_splash.png'),
                      fit: BoxFit.cover)),
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
              'Danh sách cửa hàng',
              style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                      fontSize: 18 * ffem,
                      fontWeight: FontWeight.w900,
                      height: 1.3625 * ffem / fem,
                      color: Colors.white)),
            ),
            actions: [
              // SvgPicture.asset('assets/icons/notification-icon.svg')
              Padding(
                padding: EdgeInsets.only(right: 20 * fem),
                child: IconButton(
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 25 * fem,
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context,
                        '/landing-screen', (Route<dynamic> route) => false);
                  },
                ),
              ),
            ],
          ),
          body: BlocBuilder<CampaignStoreBloc, CampaignStoreState>(
            builder: (context, state) {
              if (state is CampaignStoreLoading) {
                return buildVoucherShimmer(3, fem, hem);
              } else if (state is CampaignStoreByIdLoaded) {
                return CustomScrollView(
                  slivers: [
                    SliverList(
                        delegate: SliverChildListDelegate([
                          SizedBox(height: 15,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.campaignStores.length,
                              itemBuilder: (context, index) {
                                var storeModel = state.campaignStores[index];
                                return Column(
                                  children: [
                                    Container(
                                      height: 100 * hem,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15 * fem),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5 * hem,
                                                left: 5 * fem,
                                                bottom: 5 * hem),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10 * fem),
                                              child: SizedBox(
                                                width: 80 * fem,
                                                height: 85 * hem,
                                                child: Image.network(
                                                  campaignDetailModel.brandLogo,
                                                  fit: BoxFit.fill,
                                                  loadingBuilder: (context,
                                                      child, loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      return child;
                                                    }
                                                    return ShimmerWidget
                                                        .rectangular(
                                                            height: 160 * hem);
                                                  },
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Image.asset(
                                                      'assets/images/image-404.jpg',
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10 * fem,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 250 * fem,
                                                // height: 45*hem,
                                                child: Text(
                                                    storeModel.storeName,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.openSans(
                                                        textStyle: TextStyle(
                                                      fontSize: 16 * ffem,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ))),
                                              ),
                                              SizedBox(
                                                height: 2 * hem,
                                              ),
                                              SizedBox(
                                                width: 250 * fem,
                                                // height: 45*hem,
                                                child: Text(
                                                    ' ${formatTime(storeModel.openingHours!)} am - ${formatTime(storeModel.closingHours!)} pm',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.openSans(
                                                        textStyle: TextStyle(
                                                      fontSize: 15 * ffem,
                                                      color: klowTextGrey,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ))),
                                              ),
                                              SizedBox(
                                                height: 2 * hem,
                                              ),
                                              SizedBox(
                                                width: 250 * fem,
                                                // height: 45*hem,
                                                child: Text(storeModel.address,
                                                    maxLines: 2,
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.openSans(
                                                        textStyle: TextStyle(
                                                      fontSize: 15 * ffem,
                                                      color: klowTextGrey,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ))),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    ]))
                  ],
                );
              }
              return buildStoreShimmer(3, fem, hem);
            },
          ),
        ),
      ),
    );
  }
}

Widget buildStoreShimmer(count, double fem, double hem) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
        width: 170 * fem,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15 * fem),
          color: Colors.white,
        ),
      ),
      Container(
        width: 170 * fem,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15 * fem),
          color: Colors.white,
        ),
      )
    ],
  );
}
