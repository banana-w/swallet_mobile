import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:swallet_mobile/data/models/store_features/campaign_voucher_store_model.dart';
import 'package:swallet_mobile/data/models/store_features/store_model.dart';
import 'package:swallet_mobile/presentation/blocs/internet/internet_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/store/store_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'search_bar_custom.dart';
import 'voucher_card_list.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.storeModel});

  final StoreModel storeModel;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    return BlocListener<InternetBloc, InternetState>(
      listener: (context, state) {
        if (state is Connected) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                elevation: 0,
                duration: const Duration(milliseconds: 2000),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Đã kết nối internet',
                  message: 'Đã kết nối internet!',
                  contentType: ContentType.success,
                ),
              ),
            );
        } else if (state is NotConnected) {
          showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: const Text('Không kết nối Internet'),
                content: Text('Vui lòng kết nối Internet'),
                actions: [
                  TextButton(
                    onPressed: () {
                      final stateInternet = context.read<InternetBloc>().state;
                      if (stateInternet is Connected) {
                        Navigator.pop(context);
                      } else {}
                    },
                    child: const Text('Đồng ý'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: BlocBuilder<StoreBloc, StoreState>(
        builder: (context, state) {
          if (state is StoreCampaignVoucherLoading) {
            return Center(
              child: Lottie.asset('assets/animations/loading-screen.json'),
            );
          } else if (state is StoreCampaignVoucherLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<StoreBloc>().add(LoadStoreCampaignVouchers());
              },
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                top: 15 * fem,
                                bottom: 15 * fem,
                              ),
                              color: kbgWhiteColor,
                              child: Column(
                                children: [
                                  Center(
                                    child: Text(
                                      'Xin chào, ${storeModel.storeName}!',
                                      style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 21 * ffem,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Tham gia các hoạt động để tích lũy ưu đãi',
                                      style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12 * ffem,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10 * hem),
                                  SearchBarCustom(),
                                ],
                              ),
                            ),
                            SizedBox(height: 5 * hem),
                            Container(
                              color: kbgWhiteColor,
                              // height: 500,
                              padding: EdgeInsets.only(
                                top: 15 * fem,
                                bottom: 15 * fem,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BlocBuilder<StoreBloc, StoreState>(
                                    builder: (context, state) {
                                      if (state
                                          is StoreCampaignVoucherLoading) {
                                        return Center(
                                          child: Lottie.asset(
                                            'assets/animations/loading-screen.json',
                                          ),
                                        );
                                      } else if (state
                                          is StoreCampaignVoucherLoaded) {
                                        Map campaign = state.campaignStoreCart
                                            .voucherCampaign(
                                              state
                                                  .campaignStoreCart
                                                  .campaignVouchers,
                                            );
                                        if (campaign.isEmpty) {
                                          return Container(
                                            width: double.infinity,
                                            margin: EdgeInsets.only(
                                              left: 15 * fem,
                                              right: 15 * fem,
                                            ),
                                            height: 220 * hem,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/empty-icon.svg',
                                                  width: 60 * fem,
                                                  colorFilter: ColorFilter.mode(
                                                    kLowTextColor,
                                                    BlendMode.srcIn,
                                                  ),
                                                ),
                                                Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      top: 5,
                                                    ),
                                                    child: Text(
                                                      'Không có ưu đãi \n đang diễn ra',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          GoogleFonts.openSans(
                                                            textStyle: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10 * fem),
                                              ],
                                            ),
                                          );
                                        } else {
                                          return ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: campaign.keys.length,
                                            itemBuilder: (context, index) {
                                              var campaignName = campaign.keys
                                                  .elementAt(index);
                                              List<CampaignVoucherStoreModel>
                                              campaignVouchers = campaign.values
                                                  .elementAt(index);
                                              return Container(
                                                margin: EdgeInsets.only(
                                                  bottom: 15 * hem,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                        left: 15 * fem,
                                                      ),
                                                      child: Text(
                                                        campaignName.toString().toUpperCase(),
                                                        style: GoogleFonts.openSans(
                                                          textStyle: TextStyle(
                                                            fontSize: 15 * ffem,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        ListView.builder(
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          shrinkWrap: true,
                                                          itemCount:
                                                              campaignVouchers
                                                                  .length,
                                                          itemBuilder: (
                                                            context,
                                                            index,
                                                          ) {
                                                            var voucher =
                                                                campaignVouchers[index];
                                                            return VoucherCardList(
                                                              hem: hem,
                                                              fem: fem,
                                                              voucher: voucher,
                                                              ffem: ffem,
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 15 * hem),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                        left: 25 * fem,
                                                        right: 25 * fem,
                                                      ),
                                                      child: Divider(),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        }
                                      }
                                      return Container();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
