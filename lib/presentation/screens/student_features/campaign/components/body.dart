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
import 'package:swallet_mobile/data/interface_repositories/student_features/brand_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/student_repository.dart';
import 'package:swallet_mobile/presentation/blocs/brand/brand_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/campaign/campaign_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/checkin_bloc/check_in_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/internet/internet_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/screens/store_features/brand/components/campaign_list_card.dart';
import 'package:swallet_mobile/presentation/screens/student_features/brand_list/brand_list_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/brand_list/components/body.dart';
import 'package:swallet_mobile/presentation/screens/student_features/campaign/components/campaign_carousel.dart';
import 'package:swallet_mobile/presentation/screens/student_features/campaign/components/membership_card.dart';
import 'package:swallet_mobile/presentation/screens/student_features/campaign_detail/campaign_detail_screen.dart';


import '../../../../config/constants.dart';
import '../../../../widgets/card_for_unverified.dart';
import '../../../../widgets/unverified_screen.dart';

class CampaignScreenBody extends StatefulWidget {
  const CampaignScreenBody({super.key});

  @override
  State<CampaignScreenBody> createState() => _BodyState();
}

class _BodyState extends State<CampaignScreenBody>
    with SingleTickerProviderStateMixin {
  StudentModel? studentModel;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    getStudent();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<CampaignBloc>().add(LoadCampaigns());
          context.read<BrandBloc>().add(LoadBrands(page: 1, size: 10));
        },
        child: CustomScrollView(
          controller: context.read<CampaignBloc>().scrollController,
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // RoleWidget
                    BlocBuilder<RoleAppBloc, RoleAppState>(
                      builder: (context, state) {
                        if (state is Unverified) {
                          return Container(
                            padding: EdgeInsets.only(
                              top: 15 * fem,
                              bottom: 15 * fem,
                            ),
                            color: kbgWhiteColor,
                            child: CardForUnVerified(
                              fem: fem,
                              hem: hem,
                              ffem: ffem,
                            ),
                          );
                        } else if (state is Verified) {
                          return Container(
                            padding: EdgeInsets.only(
                              top: 15 * fem,
                              bottom: 15 * fem,
                            ),
                            color: kbgWhiteColor,
                            child: MemberShipCard(
                              fem: fem,
                              hem: hem,
                              ffem: ffem,
                              heightText: heightText,
                              studentModel: state.studentModel,
                            ),
                          );
                        }
                        return Center(
                          child: Lottie.asset(
                            'assets/animations/loading-screen.json',
                            width: 50 * fem,
                            height: 50 * hem,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 5 * hem),

                    // ĐIỂM DANH HẰNG NGÀY
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
                              'ĐIỂM DANH HẰNG NGÀY',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  fontSize: 15 * ffem,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10 * hem),
                          BlocProvider(
                            create:
                                (context) => CheckInBloc(
                                  context.read<StudentRepository>(),
                                )..add(LoadCheckInData()),
                            child: BlocListener<CheckInBloc, CheckInState>(
                              listener: (context, state) {
                                if (state is CheckInLoaded &&
                                    !state.canCheckInToday) {
                                  context.read<RoleAppBloc>().add(
                                    RoleAppStart(),
                                  );
                                  final previousState =
                                      context.read<CheckInBloc>().state;
                                  if (previousState is CheckInLoaded &&
                                      previousState.canCheckInToday) {
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(
                                        SnackBar(
                                          elevation: 0,
                                          duration: const Duration(
                                            milliseconds: 2000,
                                          ),
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: Colors.transparent,
                                          content: AwesomeSnackbarContent(
                                            title: 'Điểm danh thành công',
                                            message:
                                                'Bạn nhận được ${state.streak * 10 + 10} điểm!',
                                            contentType: ContentType.success,
                                          ),
                                        ),
                                      );
                                  }
                                } else if (state is CheckInError) {
                                  // Hiển thị thông báo lỗi nếu có lỗi xảy ra
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(
                                      SnackBar(
                                        elevation: 0,
                                        duration: const Duration(
                                          milliseconds: 2000,
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        content: AwesomeSnackbarContent(
                                          title: 'Lỗi',
                                          message: state.message,
                                          contentType: ContentType.failure,
                                        ),
                                      ),
                                    );
                                }
                              },
                              child: BlocBuilder<CheckInBloc, CheckInState>(
                                builder: (context, state) {
                                  if (state is CheckInLoaded) {
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: List.generate(7, (index) {
                                            bool isChecked =
                                                state.checkInHistory.length >
                                                    index &&
                                                state.checkInHistory[index];
                                            bool isToday =
                                                index == state.currentDayIndex;

                                            return GestureDetector(
                                              onTap:
                                                  isToday &&
                                                          state.canCheckInToday
                                                      ? () {
                                                        // Gửi sự kiện CheckIn
                                                        context
                                                            .read<CheckInBloc>()
                                                            .add(CheckIn());

                                                        // Hiển thị thông báo đang xử lý
                                                        ScaffoldMessenger.of(
                                                            context,
                                                          )
                                                          ..hideCurrentSnackBar()
                                                          ..showSnackBar(
                                                            SnackBar(
                                                              elevation: 0,
                                                              duration:
                                                                  const Duration(
                                                                    milliseconds:
                                                                        2000,
                                                                  ),
                                                              behavior:
                                                                  SnackBarBehavior
                                                                      .floating,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              content: AwesomeSnackbarContent(
                                                                title:
                                                                    'Điểm danh thành công',
                                                                message:
                                                                    'Bạn nhận được ${state.streak * 10 + 10} điểm!',
                                                                contentType:
                                                                    ContentType
                                                                        .success,
                                                              ),
                                                            ),
                                                          );
                                                      }
                                                      : null,
                                              child: AnimatedBuilder(
                                                animation: _animationController,
                                                builder: (context, child) {
                                                  // Chỉ áp dụng hiệu ứng nếu là ngày hôm nay và chưa được nhận
                                                  double offset =
                                                      (isToday && !isChecked)
                                                          ? -_animationController
                                                                  .value *
                                                              10
                                                          : 0;
                                                  return Transform.translate(
                                                    offset: Offset(0, offset),
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                      0.1,
                                                                    ),
                                                                blurRadius: 5,
                                                                offset: Offset(
                                                                  0,
                                                                  2,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          child: SvgPicture.asset(
                                                            isChecked
                                                                ? 'assets/images/gift_checked.svg'
                                                                : (isToday
                                                                    ? 'assets/images/gift_checked.svg'
                                                                    : 'assets/images/gift_unchecked.svg'),
                                                            width: 40 * fem,
                                                            height: 40 * hem,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                        Positioned(
                                                          bottom: 7 * hem,
                                                          child: Text(
                                                            'Ngày ${index + 1}',
                                                            style: GoogleFonts.openSans(
                                                              textStyle: TextStyle(
                                                                fontSize:
                                                                    10 * ffem,
                                                                color:
                                                                    isChecked ||
                                                                            isToday
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                shadows: [
                                                                  Shadow(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                          0.5,
                                                                        ),
                                                                    offset:
                                                                        Offset(
                                                                          1,
                                                                          1,
                                                                        ),
                                                                    blurRadius:
                                                                        2,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            textAlign:
                                                                TextAlign
                                                                    .center,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          }),
                                        ),
                                        //---------------------------------------- Nút reset điểm danh (chỉ để test) -------------------------------------------------
                                        // ElevatedButton(
                                        //   onPressed: () async {
                                        //     var box = await Hive.openBox(
                                        //       'checkInBox',
                                        //     );
                                        //     // Thiết lập trạng thái: đã điểm danh ngày 1, 2, 3, 4
                                        //     await box.put('checkInHistory', [
                                        //       true,
                                        //       true,
                                        //       true,
                                        //       true,
                                        //       false,
                                        //       false,
                                        //       false,
                                        //     ]);
                                        //     await box.put(
                                        //       'streak',
                                        //       4,
                                        //     ); // Chuỗi 4 ngày
                                        //     await box.put(
                                        //       'points',
                                        //       100,
                                        //     ); // Tổng điểm: 10 + 20 + 30 + 40 = 100
                                        //     // Đặt ngày điểm danh cuối cùng là hôm qua để có thể điểm danh hôm nay
                                        //     DateTime yesterday = DateTime.now()
                                        //         .subtract(Duration(days: 1));
                                        //     await box.put(
                                        //       'lastCheckInDate',
                                        //       yesterday.toIso8601String(),
                                        //     );
                                        //     // Tải lại dữ liệu
                                        //     context.read<CheckInBloc>().add(
                                        //       LoadCheckInData(),
                                        //     );
                                        //   },
                                        //   style: ElevatedButton.styleFrom(
                                        //     backgroundColor: Colors.orange,
                                        //     shape: RoundedRectangleBorder(
                                        //       borderRadius:
                                        //           BorderRadius.circular(
                                        //             20 * fem,
                                        //           ),
                                        //     ),
                                        //     padding: EdgeInsets.symmetric(
                                        //       horizontal: 30 * fem,
                                        //       vertical: 10 * hem,
                                        //     ),
                                        //   ),
                                        //   child: Text(
                                        //     'Mô phỏng Ngày 5',
                                        //     style: GoogleFonts.openSans(
                                        //       textStyle: TextStyle(
                                        //         fontSize: 16 * ffem,
                                        //         color: Colors.white,
                                        //         fontWeight: FontWeight.w600,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),

                                        //---------------------------------------- Nút reset điểm danh (chỉ để test) -------------------------------------------------
                                      ],
                                    );
                                  }

                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: kPrimaryColor,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5 * hem),

                    // Hôm nay có gì
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
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10 * hem),
                          BlocBuilder<CampaignBloc, CampaignState>(
                            builder: (context, state) {
                              if (state is CampaignsLoaded) {
                                if (state.campaigns.isEmpty) {
                                  return Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(
                                      left: 15 * fem,
                                      right: 15 * fem,
                                    ),
                                    height: 220 * hem,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
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
                                            kLowTextColor,
                                            BlendMode.srcIn,
                                          ),
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
                                                ),
                                              ),
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
                    SizedBox(height: 5 * hem),

                    // Các thương hiệu
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
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (roleState is Unverified) {
                                      Navigator.pushNamed(
                                        context,
                                        UnverifiedScreen.routeName,
                                      );
                                    } else {
                                      Navigator.pushNamed(
                                        context,
                                        BrandListScreen.routeName,
                                      );
                                    }
                                  },
                                  child: Container(
                                    height: 22 * hem,
                                    width: 22 * fem,
                                    margin: EdgeInsets.only(left: 8 * fem),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(80),
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 18 * fem,
                                      color: kDarkPrimaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12 * hem),
                          BlocProvider(
                            create:
                                (context) => BrandBloc(
                                  brandRepository:
                                      context.read<BrandRepository>(),
                                )..add(LoadBrands(page: 1, size: 10)),
                            child: BlocBuilder<BrandBloc, BrandState>(
                              builder: (context, state) {
                                if (state is BrandsLoaded) {
                                  return SizedBox(
                                    height: 160 * hem,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: state.brands.length + 1,
                                      itemBuilder: (context, index) {
                                        if (index == state.brands.length) {
                                          return InkWell(
                                            onTap: () {
                                              if (roleState is Unverified) {
                                                Navigator.pushNamed(
                                                  context,
                                                  UnverifiedScreen.routeName,
                                                );
                                              } else {
                                                Navigator.pushNamed(
                                                  context,
                                                  BrandListScreen.routeName,
                                                );
                                              }
                                            },
                                            child: Container(
                                              width: 80 * fem,
                                              // padding: EdgeInsets.only(
                                              //   left: 5 * hem,
                                              // ),
                                              margin: EdgeInsets.only(
                                                left: 5 * fem,
                                                right: 5 * fem,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center, // Căn giữa theo chiều dọc
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center, // Căn giữa theo chiều ngang
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          80 * fem,
                                                        ),
                                                    child: Container(
                                                      width: 80 * fem,
                                                      height: 80 * hem,
                                                      color: Colors.white,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center, // Căn giữa nội dung
                                                        children: [
                                                          Icon(
                                                            Icons.arrow_forward,
                                                            size: 30,
                                                          ),
                                                          Text(
                                                            'Xem thêm',
                                                            textAlign:
                                                                TextAlign
                                                                    .center,
                                                            maxLines: 2,
                                                            style: GoogleFonts.openSans(
                                                              textStyle: TextStyle(
                                                                fontSize:
                                                                    10 * ffem,
                                                                color:
                                                                    Colors
                                                                        .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                            ),
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
                                            brandModel: state.brands[index],
                                          );
                                        }
                                      },
                                    ),
                                  );
                                }
                                return Center(
                                  child: Lottie.asset(
                                    'assets/animations/loading-screen.json',
                                    width: 50 * fem,
                                    height: 50 * hem,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5 * hem),

                    // Chiến dịch ưu đãi
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
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12 * hem),
                          BlocBuilder<CampaignBloc, CampaignState>(
                            builder: (context, state) {
                              if (state is CampaignLoading) {
                                return shimmerLoading(1);
                              } else if (state is CampaignsLoaded) {
                                if (state.campaigns.isEmpty) {
                                  return Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(
                                      left: 15 * fem,
                                      right: 15 * fem,
                                    ),
                                    height: 220 * hem,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
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
                                            kLowTextColor,
                                            BlendMode.srcIn,
                                          ),
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
                                                ),
                                              ),
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
                                    itemCount:
                                        state.hasReachMax
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
                                              Navigator.pushNamed(
                                                context,
                                                UnverifiedScreen.routeName,
                                              );
                                            } else {
                                              Navigator.pushNamed(
                                                context,
                                                CampaignDetailStudentScreen
                                                    .routeName,
                                                arguments:
                                                    state.campaigns[index].id,
                                              );
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
                                                  UnverifiedScreen.routeName,
                                                );
                                              } else {
                                                Navigator.pushNamed(
                                                  context,
                                                  CampaignDetailStudentScreen
                                                      .routeName,
                                                  arguments:
                                                      state.campaigns[index].id,
                                                );
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
                          SizedBox(height: 10 * hem),
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
