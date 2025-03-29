import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/student_features/student_model.dart';
import 'package:swallet_mobile/domain/interface_repositories/student_features/brand_repository.dart';
import 'package:swallet_mobile/presentation/blocs/brand/brand_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/campaign/campaign_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/internet/internet_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/screens/store_features/brand/components/campaign_list_card.dart';
import 'package:swallet_mobile/presentation/screens/store_features/campaign_detail/campaign_detail_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/brand_list/brand_list_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/brand_list/components/body.dart';
import 'package:swallet_mobile/presentation/screens/student_features/campaign/components/campaign_carousel.dart';
import 'package:swallet_mobile/presentation/screens/student_features/campaign/components/membership_card.dart';

import '../../../../../data/models.dart';
import '../../../../blocs/blocs.dart';
import '../../../../config/constants.dart';
import '../../../../widgets/card_for_unverified.dart';
import '../../../../widgets/unverified_screen.dart';

class CampaignScreenBody extends StatefulWidget {
  const CampaignScreenBody({super.key});

  @override
  State<CampaignScreenBody> createState() => _BodyState();
}

class _BodyState extends State<CampaignScreenBody> {
  StudentModel? studentModel;

  @override
  void initState() {
    getStudent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    double heightText = 1.3625 * ffem / fem;

    final roleState = context.watch<RoleAppBloc>().state;

    return BlocListener<InternetBloc, InternetState>(
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
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<CampaignBloc>().add(LoadCampaigns());
          context.read<BrandBloc>().add(LoadBrands());
        },
        child: CustomScrollView(
          controller: context.read<CampaignBloc>().scrollController,
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //RoleWidget
                    BlocBuilder<RoleAppBloc, RoleAppState>(
                      builder: (context, state) {
                        if (state is Unverified) {
                          return Container(
                              padding: EdgeInsets.only(
                                  top: 15 * fem, bottom: 15 * fem),
                              color: kbgWhiteColor,
                              child: CardForUnVerified(
                                  fem: fem, hem: hem, ffem: ffem));
                        } else if (state is Verified) {
                          return Container(
                              padding: EdgeInsets.only(
                                  top: 15 * fem, bottom: 15 * fem),
                              color: kbgWhiteColor,
                              child: MemberShipCard(
                                  fem: fem,
                                  hem: hem,
                                  ffem: ffem,
                                  heightText: heightText,
                                  studentModel: state.studentModel));
                        }
                        return Center(
                            child: Lottie.asset(
                                'assets/animations/loading-screen.json',
                                width: 50 * fem,
                                height: 50 * hem));
                      },
                    ),
                    SizedBox(
                      height: 5 * hem,
                    ),

                    //Hôm nay có gì
                    Container(
                      padding: EdgeInsets.only(top: 10 * fem, bottom: 10 * fem),
                      width: double.infinity,
                      color: kbgWhiteColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10 * hem),
                            child: Text(
                              'HÔM NAY CÓ GÌ',
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                fontSize: 15 * ffem,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              )),
                            ),
                          ),
                          SizedBox(
                            height: 10 * hem,
                          ),
                          BlocBuilder<CampaignBloc, CampaignState>(
                            builder: (context, state) {
                              if (state is CampaignsLoaded) {
                                if (state.campaigns.length == 0) {
                                  return Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(
                                        left: 15 * fem, right: 15 * fem),
                                    height: 220 * hem,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/campaign-navbar-icon.svg',
                                          width: 60 * fem,
                                          colorFilter: ColorFilter.mode(
                                              kLowTextColor, BlendMode.srcIn),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 5),
                                            child: Text(
                                              'Không có chiến dịch nào \nđang diễn ra!',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return Container(
                                    margin: EdgeInsets.only(left: 10),
                                    width: MediaQuery.of(context).size.width,
                                    child: CampaignCarousel(
                                      campaigns: state.campaigns,
                                      roleState: roleState,
                                    ),
                                  );
                                }
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  color: kPrimaryColor,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5 * hem,
                    ),

                    //Các thwung hiệu
                    Container(
                      color: kbgWhiteColor,
                      padding: EdgeInsets.only(top: 15 * fem, bottom: 15 * fem),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10 * fem),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'THƯƠNG HIỆU',
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                    fontSize: 15 * ffem,
                                    height: heightText,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                  )),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (roleState is Unverified) {
                                      Navigator.pushNamed(
                                          context, UnverifiedScreen.routeName);
                                    } else {
                                      Navigator.pushNamed(
                                          context, BrandListScreen.routeName);
                                    }
                                  },
                                  child: Container(
                                    height: 22 * hem,
                                    width: 22 * fem,
                                    margin: EdgeInsets.only(left: 8 * fem),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(80)),
                                    child: Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 18 * fem,
                                      color: kDarkPrimaryColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12 * hem,
                          ),
                          BlocProvider(
                            create: (context) => BrandBloc(
                                brandRepository:
                                    context.read<BrandRepository>())
                              ..add(LoadBrands(limit: 5)),
                            child: BlocBuilder<BrandBloc, BrandState>(
                                builder: (context, state) {
                              if (state is BrandsLoaded) {
                                return SizedBox(
                                    height: 120 * hem,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: state.brands.length + 1,
                                      itemBuilder: (context, index) {
                                        if (index == state.brands.length) {
                                          return InkWell(
                                            onTap: () {
                                              if (roleState is Unverified) {
                                                Navigator.pushNamed(context,
                                                    UnverifiedScreen.routeName);
                                              } else {
                                                Navigator.pushNamed(context,
                                                    BrandListScreen.routeName);
                                              }
                                            },
                                            child: Container(
                                              width: 80 * fem,
                                              decoration: BoxDecoration(),
                                              margin: EdgeInsets.only(
                                                  left: 5 * fem,
                                                  right: 5 * fem),
                                              child: Column(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            80 * fem),
                                                    child: Container(
                                                      width: 80 * fem,
                                                      height: 80 * hem,
                                                      color: Colors.white,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.arrow_forward,
                                                            size: 30,
                                                          ),
                                                          Text(
                                                            'Xem thêm',
                                                            textAlign: TextAlign
                                                                .center,
                                                            maxLines: 2,
                                                            style: GoogleFonts
                                                                .openSans(
                                                                    textStyle:
                                                                        TextStyle(
                                                              fontSize:
                                                                  10 * ffem,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            )),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        } else {
                                          return BrandCard(
                                              fem: fem,
                                              hem: hem,
                                              ffem: ffem,
                                              brandModel: state.brands[index]);
                                        }
                                      },
                                    ));
                              }
                              return Center(
                                  child: Lottie.asset(
                                      'assets/animations/loading-screen.json',
                                      width: 50 * fem,
                                      height: 50 * hem));
                            }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5 * hem,
                    ),

                    //Chiến dịch ưu đãi
                    Container(
                      color: kbgWhiteColor,
                      padding: EdgeInsets.only(top: 15 * fem, bottom: 15 * fem),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10 * fem),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'CHIẾN DỊCH ƯU ĐÃI',
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                    fontSize: 15 * ffem,
                                    height: heightText,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                  )),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12 * hem,
                          ),
                          // CampaignPaged()
                          BlocBuilder<CampaignBloc, CampaignState>(
                            builder: (context, state) {
                              if (state is CampaignLoading) {
                                return shimmerLoading(1);
                              } else if (state is CampaignsLoaded) {
                                if (state.campaigns.length == 0) {
                                  return Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(
                                        left: 15 * fem, right: 15 * fem),
                                    height: 220 * hem,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/campaign-navbar-icon.svg',
                                          width: 60 * fem,
                                          colorFilter: ColorFilter.mode(
                                              kLowTextColor, BlendMode.srcIn),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 5),
                                            child: Text(
                                              'Không có chiến dịch nào \nđang diễn ra!',
                                              style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: state.hasReachMax
                                        ? state.campaigns.length
                                        : state.campaigns.length + 1,
                                    itemBuilder: (context, index) {
                                      if (index >= state.campaigns.length) {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            color: kPrimaryColor,
                                          ),
                                        );
                                      } else {
                                        return GestureDetector(
                                          onTap: () {
                                            if (roleState is Unverified) {
                                              Navigator.pushNamed(context,
                                                  UnverifiedScreen.routeName);
                                            } else {
                                              Navigator.pushNamed(
                                                  context,
                                                  CampaignDetailScreen
                                                      .routeName,
                                                  arguments: state
                                                      .campaigns[index].id);
                                            }
                                          },
                                          child: CampaignListCard(
                                            fem: fem,
                                            hem: hem,
                                            ffem: ffem,
                                            campaignModel:
                                                state.campaigns[index],
                                            onTap: () {
                                              if (roleState is Unverified) {
                                                Navigator.pushNamed(
                                                    context,
                                                    UnverifiedScreen
                                                        .routeName);
                                              } else {
                                                Navigator.pushNamed(
                                                    context,
                                                    CampaignDetailScreen
                                                        .routeName,
                                                    arguments: state
                                                        .campaigns[index].id);
                                              }
                                            },
                                          ),
                                        );
                                      }
                                    },
                                  );
                                }
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  color: kPrimaryColor,
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 10 * hem,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ]),
            )
          ],
        ),
      ),
    );
  }

  Future getStudent() async {
    final student = await AuthenLocalDataSource.getStudent();
    setState(() {
      studentModel = student;
    });
  }
}

Widget shimmerLoading(pageSize) {
  return ListView.builder(
    itemCount: pageSize,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          margin: EdgeInsets.only(bottom: 10),
          height: 160,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      );
    },
  );
}
