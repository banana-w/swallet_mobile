import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:swallet_mobile/data/repositories/student_features/campaign_repository_imp.dart';
import 'package:swallet_mobile/domain/interface_repositories/student_features/campaign_repository.dart';
import 'package:swallet_mobile/presentation/blocs/campaign/campaign_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/campaign_store/campaign_store_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/internet/internet_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/student_features/campaign_detail/components/campaign_detail_showdal.dart';
import 'package:swallet_mobile/presentation/screens/student_features/campaign_detail/components/campaign_store_card.dart';
import 'package:swallet_mobile/presentation/screens/student_features/campaign_detail/components/campaign_voucher_list.dart';
import 'package:swallet_mobile/presentation/screens/student_features/campaign_detail/components/detail_showdal_bottom.dart';
import 'package:swallet_mobile/presentation/screens/student_features/store_list/store_list_screen.dart';

import '../../../../widgets/shimmer_widget.dart';


class Body extends StatelessWidget {
  const Body({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CampaignBloc(
              campaignRepository: context.read<CampaignRepository>())
            ..add(LoadCampaignById(id: id)),
        ),
        BlocProvider(
          create: (context) => CampaignStoreBloc(
              campaignRepository: context.read<CampaignRepository>())
            ..add(LoadCampaignStoreById(id: id)),
        ),
      ],
      child: BlocListener<InternetBloc, InternetState>(
        listener: (context, state) {
          if (state is Connected) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                elevation: 0,
                duration: const Duration(milliseconds: 2000),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Đã kết nối internet',
                  message: 'Đã kết nối internet!',
                  contentType: ContentType.success,
                ),
              ));
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
                          final stateInternet =
                              context.read<InternetBloc>().state;
                          if (stateInternet is Connected) {
                            Navigator.pop(context);
                          } else {}
                        },
                        child: const Text('Đồng ý'))
                  ],
                );
              },
            );
          }
        },
        child: BlocBuilder<CampaignBloc, CampaignState>(
          builder: (context, state) {
            if (state is CampaignLoading) {
              return buildCampaignDetailShimmer(fem, hem);
            } else if (state is CampaignByIdLoaded) {
              var campaignDetailModel = state.campaignDetailModel;
              return CustomScrollView(
                slivers: [
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Stack(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 200 * hem,
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(
                                state.campaignDetailModel.image,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return ShimmerWidget.rectangular(
                                      height: 200 * hem);
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/background_splash.png',
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 100 * hem,
                            )
                          ],
                        ),
                        Positioned(
                          top: 140 * hem,
                          left: 0 * fem,
                          right: 0 * fem,
                          child: Container(
                            height: 140 * hem,
                            margin: EdgeInsets.only(
                                right: 15 * fem, left: 15 * fem),
                            padding:
                                EdgeInsets.only(top: 5 * hem, bottom: 5 * hem),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: kPrimaryColor,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0x0c000000),
                                      offset: Offset(0 * fem, 10 * fem),
                                      blurRadius: 5 * fem)
                                ]),
                            width: MediaQuery.of(context).size.width,
                            constraints:
                                BoxConstraints(maxHeight: double.infinity),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 300 * fem,
                                  child: Text(
                                    '${state.campaignDetailModel.campaignName}',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                      fontSize: 18 * ffem,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    )),
                                  ),
                                ),
                                SizedBox(
                                  width: 240 * fem,
                                  child: Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(10 * fem),
                                      child: SizedBox(
                                        height: 35 * hem,
                                        width: 35 * fem,
                                        child: Image.network(
                                          state.campaignDetailModel.brandLogo,
                                          // state.campaignDetailModel.image,
                                          fit: BoxFit.fill,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/images/image-404.jpg',
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5 * fem,
                                    ),
                                    Text(
                                      '${state.campaignDetailModel.brandName}',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                        fontSize: 16 * ffem,
                                        color: klowTextGrey,
                                        fontWeight: FontWeight.w500,
                                      )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    CampaignDetailShowdal(
                      fem: fem,
                      hem: hem,
                      ffem: ffem,
                      campaignDetailModel: state.campaignDetailModel,
                      onTap: () {
                        _detailModelBottomSheet(
                            context, state.campaignDetailModel);
                      },
                    ),
                    SizedBox(
                      height: 10 * hem,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 15 * fem, left: 15 * fem),
                      padding: EdgeInsets.only(
                          right: 10 * fem,
                          left: 10 * fem,
                          top: 10 * hem,
                          bottom: 10 * hem),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: BlocBuilder<CampaignStoreBloc, CampaignStoreState>(
                        builder: (context, state) {
                          if (state is CampaignStoreLoading) {
                            return ShimmerWidget.rectangular(
                              height: 120 * hem,
                            );
                          } else if (state is CampaignStoreByIdLoaded) {
                            var numberOfStores = state.campaignStores.length;

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    numberOfStores == 1
                                        ? Text(
                                            'Cửa hàng áp dụng',
                                            style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                              fontSize: 16 * ffem,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                            )),
                                          )
                                        : Text(
                                            'Cửa hàng áp dụng (${numberOfStores})',
                                            style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                              fontSize: 16 * ffem,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                            )),
                                          ),
                                    numberOfStores == 1
                                        ? Container()
                                        : GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                StoreListScreen.routeName,
                                                arguments: <dynamic>[
                                                  id,
                                                  campaignDetailModel
                                                ],
                                              );
                                            },
                                            child: Text(
                                              'Xem tất cả',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                fontSize: 12 * ffem,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                              )),
                                            ),
                                          ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10 * hem,
                                ),
                                SizedBox(
                                  height: 85 * hem,
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.campaignStores.length,
                                    itemBuilder: (context, index) {
                                      var storeModel =
                                          state.campaignStores[index];
                                      return CampaignStoreCard(
                                          fem: fem,
                                          hem: hem,
                                          campaignDetailModel:
                                              campaignDetailModel,
                                          storeModel: storeModel,
                                          ffem: ffem);
                                    },
                                  ),
                                ),
                              ],
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20 * hem,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: 15 * fem, left: 25 * fem, bottom: 10 * hem),
                      child: Text(
                        'Ưu đãi trong chiến dịch',
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                          fontSize: 16.5 * ffem,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        )),
                      ),
                    ),
                    CampaignVoucherList(
                        fem: fem,
                        hem: hem,
                        ffem: ffem,
                        campaignDetailModel: state.campaignDetailModel),
                    SizedBox(
                      height: 20 * hem,
                    )
                  ]))
                ],
              );
            }
            return Center(
              child: Text('Error'),
            );
          },
        ),
      ),
    );
  }
}

void _detailModelBottomSheet(context, campaignModel) {
  double baseWidth = 375;
  double fem = MediaQuery.of(context).size.width / baseWidth;
  double ffem = fem * 0.97;
  double baseHeight = 812;
  double hem = MediaQuery.of(context).size.height / baseHeight;

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return RepositoryProvider<CampaignRepository>(
        create: (context) => CampaignRepositoryImp(),
        child: Container(
          height: 500 * hem,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15 * fem),
              color: klighGreyColor),
          child: DetailShowdalBottom(
            hem: hem,
            fem: fem,
            ffem: ffem,
            campaignDetailModel: campaignModel,
          ),
        ),
      );
    },
    isScrollControlled: true,
  );
}

Widget buildCampaignDetailShimmer(double fem, double hem) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        height: 100 * fem,
      ),
      Container(
        margin: EdgeInsets.only(left: 15 * fem, right: 15 * fem),
        color: Colors.white,
        child: ShimmerWidget.rectangular(
          height: 150 * hem,
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 15 * fem, right: 15 * fem, top: 20 * hem),
        child: ShimmerWidget.rectangular(
          height: 120 * hem,
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 15 * fem, right: 15 * fem, top: 20 * hem),
        child: ShimmerWidget.rectangular(
          height: 20 * hem,
          width: 150 * fem,
        ),
      ),
      Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 15 * fem, top: 20 * hem),
            child: ShimmerWidget.rectangular(
              height: 200 * hem,
              width: 170 * fem,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15 * fem, top: 20 * hem),
            child: ShimmerWidget.rectangular(
              height: 200 * hem,
              width: 170 * fem,
            ),
          ),
        ],
      )
    ],
  );
}

String changeFormateDate(String dateTime) {
  DateTime formatDate = DateTime.parse(dateTime);
  String formattedDate = DateFormat('dd/MM/yyyy').format(formatDate);
  return formattedDate;
}

String formatTime(String inputTimeString) {
  // Parse the input time string
  DateTime parsedTime = DateTime.parse("2022-01-01 $inputTimeString");

  // Format the DateTime object to a string with "h:mm" format
  String formattedTime =
      "${parsedTime.hour.toString().padLeft(2, '0')}:${parsedTime.minute.toString().padLeft(2, '0')}";

  return formattedTime;
}
