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
import 'package:swallet_mobile/data/repositories/student_features/check_in_repository_imp.dart';
import 'package:swallet_mobile/presentation/blocs/brand/brand_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/campaign/campaign_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/checkin_bloc/check_in_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/internet/internet_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/store_features/brand/components/campaign_list_card.dart';
import 'package:swallet_mobile/presentation/screens/student_features/brand_list/brand_list_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/brand_list/components/body.dart';
import 'package:swallet_mobile/presentation/screens/student_features/campaign/components/campaign_carousel.dart';
import 'package:swallet_mobile/presentation/screens/student_features/campaign/components/membership_card.dart';
import 'package:swallet_mobile/presentation/screens/student_features/campaign_detail/campaign_detail_screen.dart';
import 'package:swallet_mobile/presentation/widgets/card_for_unverified.dart';
import 'package:swallet_mobile/presentation/widgets/unverified_screen.dart';

class CampaignScreenBody extends StatefulWidget {
  const CampaignScreenBody({super.key});

  @override
  State<CampaignScreenBody> createState() => _BodyState();
}

class _BodyState extends State<CampaignScreenBody>
    with SingleTickerProviderStateMixin {
  // Constants
  static const double _baseWidth = 375;
  static const double _baseHeight = 812;

  // State variables
  StudentModel? studentModel;
  late AnimationController _animationController;
  
  @override
  void initState() {
    super.initState();
    _initAnimationController();
    _loadStudentData();
  }

  void _initAnimationController() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  Future<void> _loadStudentData() async {
    final student = await AuthenLocalDataSource.getStudent();
    if (mounted) {
      setState(() => studentModel = student);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsiveValues = _getResponsiveValues(context);
    final roleState = context.watch<RoleAppBloc>().state;

    return BlocListener<InternetBloc, InternetState>(
      listener: _handleInternetState,
      child: RefreshIndicator(
        onRefresh: () async => _refreshData(context),
        child: CustomScrollView(
          controller: context.read<CampaignBloc>().scrollController,
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRoleSection(context, responsiveValues, roleState),
                    SizedBox(height: 5 * responsiveValues.hem),
                    _buildDailyCheckInSection(context, responsiveValues),
                    SizedBox(height: 5 * responsiveValues.hem),
                    _buildTodayHighlightsSection(context, responsiveValues, roleState),
                    SizedBox(height: 5 * responsiveValues.hem),
                    _buildBrandsSection(context, responsiveValues, roleState),
                    SizedBox(height: 5 * responsiveValues.hem),
                    _buildCampaignsSection(context, responsiveValues, roleState),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  // Responsive helpers
  ResponsiveValues _getResponsiveValues(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    
    final fem = width / _baseWidth;
    final ffem = fem * 0.97;
    final hem = height / _baseHeight;
    final heightText = 1.3625 * ffem / fem;

    return ResponsiveValues(
      fem: fem,
      ffem: ffem,
      hem: hem,
      heightText: heightText,
    );
  }

  // Section builders
  Widget _buildRoleSection(
      BuildContext context, ResponsiveValues values, RoleAppState roleState) {
    return BlocBuilder<RoleAppBloc, RoleAppState>(
      builder: (context, state) {
        if (state is Unverified) {
          return _buildUnverifiedCard(values);
        } else if (state is Verified) {
          return _buildMembershipCard(values, state.studentModel);
        }
        return _buildLoadingIndicator(values);
      },
    );
  }
  
  Widget _buildUnverifiedCard(ResponsiveValues values) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15 * values.fem),
      color: kbgWhiteColor,
      child: CardForUnVerified(
        fem: values.fem,
        hem: values.hem,
        ffem: values.ffem,
      ),
    );
  }
  
  Widget _buildMembershipCard(ResponsiveValues values, StudentModel student) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15 * values.fem),
      color: kbgWhiteColor,
      child: MemberShipCard(
        fem: values.fem,
        hem: values.hem,
        ffem: values.ffem,
        heightText: values.heightText,
        studentModel: student,
      ),
    );
  }

  Widget _buildDailyCheckInSection(BuildContext context, ResponsiveValues values) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10 * values.fem,
        horizontal: 10 * values.fem,
      ),
      width: double.infinity,
      color: kbgWhiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('ĐIỂM DANH HẰNG NGÀY', values),
          SizedBox(height: 10 * values.hem),
          _buildCheckInContent(context, values),
        ],
      ),
    );
  }

  Widget _buildCheckInContent(BuildContext context, ResponsiveValues values) {
    return BlocProvider(
      create: (context) => CheckInBloc(CheckInRepositoryImpl())
        ..add(LoadCheckInData()),
      child: BlocListener<CheckInBloc, CheckInState>(
        listener: (context, state) => _handleCheckInState(context, state),
        child: BlocBuilder<CheckInBloc, CheckInState>(
          builder: (context, state) {
            if (state is CheckInLoaded) {
              return _buildCheckInCalendar(context, state, values);
            }
            return Center(
              child: CircularProgressIndicator(color: kPrimaryColor),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCheckInCalendar(
      BuildContext context, CheckInLoaded state, ResponsiveValues values) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(7, (index) {
            final isChecked = state.checkInHistory.length > index && 
                state.checkInHistory[index];
            final isToday = index == state.currentDayIndex;
            
            return GestureDetector(
              onTap: isToday ? () => _handleDayTap(context, state) : null,
              child: _buildDayItem(isChecked, isToday, state, index, values),
            );
          }),
        ),
        SizedBox(height: 10 * values.hem),
        _buildStreakCounter(state, values),
      ],
    );
  }
  
  Widget _buildDayItem(bool isChecked, bool isToday, CheckInLoaded state, 
      int index, ResponsiveValues values) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        double offset = (isToday && !isChecked)
            ? -_animationController.value * 10
            : 0;
        
        return Transform.translate(
          offset: Offset(0, offset),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                    if (isToday && state.canCheckInToday)
                      BoxShadow(
                        color: Colors.yellow.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                  ],
                ),
                child: SvgPicture.asset(
                  isChecked
                      ? 'assets/images/gift_checked.svg'
                      : (isToday && state.canCheckInToday
                          ? 'assets/images/gift_checked.svg'
                          : 'assets/images/gift_unchecked.svg'),
                  width: 40 * values.fem,
                  height: 40 * values.hem,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                bottom: 7 * values.hem,
                child: Text(
                  'Ngày ${index + 1}',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: 9 * values.ffem,
                      color: isChecked
                          ? Colors.white
                          : (isToday && state.canCheckInToday
                              ? Colors.white
                              : Colors.grey),
                      fontWeight: FontWeight.w900,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(1, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildStreakCounter(CheckInLoaded state, ResponsiveValues values) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10 * values.hem),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Chuỗi: ${state.streak} ngày',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 12 * values.ffem,
                color: kPrimaryColor,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayHighlightsSection(
      BuildContext context, ResponsiveValues values, RoleAppState roleState) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10 * values.fem),
      width: double.infinity,
      color: kbgWhiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10 * values.hem),
            child: _buildSectionTitle('HÔM NAY CÓ GÌ', values),
          ),
          SizedBox(height: 10 * values.hem),
          _buildTodayCampaigns(context, values, roleState),
        ],
      ),
    );
  }
  
  Widget _buildTodayCampaigns(
      BuildContext context, ResponsiveValues values, RoleAppState roleState) {
    return BlocBuilder<CampaignBloc, CampaignState>(
      builder: (context, state) {
        if (state is CampaignsLoaded) {
          if (state.campaigns.isEmpty) {
            return _buildEmptyCampaignMessage(values);
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
          child: CircularProgressIndicator(color: kPrimaryColor),
        );
      },
    );
  }

  Widget _buildBrandsSection(
      BuildContext context, ResponsiveValues values, RoleAppState roleState) {
    return Container(
      color: kbgWhiteColor,
      padding: EdgeInsets.symmetric(vertical: 15 * values.fem),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10 * values.fem),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildSectionTitle('THƯƠNG HIỆU', values),
                _buildViewMoreButton(context, roleState, values),
              ],
            ),
          ),
          SizedBox(height: 12 * values.hem),
          _buildBrandsList(context, values, roleState),
        ],
      ),
    );
  }
  
  Widget _buildViewMoreButton(
      BuildContext context, RoleAppState roleState, ResponsiveValues values) {
    return InkWell(
      onTap: () => _navigateBasedOnRole(
        context, 
        roleState, 
        UnverifiedScreen.routeName,
        BrandListScreen.routeName
      ),
      child: Container(
        height: 22 * values.hem,
        width: 22 * values.fem,
        margin: EdgeInsets.only(left: 8 * values.fem),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(80),
        ),
        child: Icon(
          Icons.arrow_forward_rounded,
          size: 18 * values.fem,
          color: kDarkPrimaryColor,
        ),
      ),
    );
  }
  
  Widget _buildBrandsList(
      BuildContext context, ResponsiveValues values, RoleAppState roleState) {
    return BlocProvider(
      create: (context) => BrandBloc(
        brandRepository: context.read<BrandRepository>(),
      )..add(LoadBrands(page: 1, size: 10)),
      child: BlocBuilder<BrandBloc, BrandState>(
        builder: (context, state) {
          if (state is BrandsLoaded) {
            return SizedBox(
              height: 160 * values.hem,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.brands.length + 1,
                itemBuilder: (context, index) {
                  if (index == state.brands.length) {
                    return _buildViewMoreBrandsItem(context, values, roleState);
                  } else {
                    return BrandCard(
                      fem: values.fem,
                      hem: values.hem,
                      ffem: values.ffem,
                      brandModel: state.brands[index],
                    );
                  }
                },
              ),
            );
          }
          return _buildLoadingIndicator(values);
        },
      ),
    );
  }
  
  Widget _buildViewMoreBrandsItem(
      BuildContext context, ResponsiveValues values, RoleAppState roleState) {
    return InkWell(
      onTap: () => _navigateBasedOnRole(
        context,
        roleState,
        UnverifiedScreen.routeName,
        BrandListScreen.routeName
      ),
      child: Container(
        width: 80 * values.fem,
        margin: EdgeInsets.symmetric(horizontal: 5 * values.fem),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(80 * values.fem),
              child: Container(
                width: 80 * values.fem,
                height: 80 * values.hem,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_forward, size: 30),
                    Text(
                      'Xem thêm',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 10 * values.ffem,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
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
  }

  Widget _buildCampaignsSection(
      BuildContext context, ResponsiveValues values, RoleAppState roleState) {
    return Container(
      color: kbgWhiteColor,
      padding: EdgeInsets.symmetric(vertical: 15 * values.fem),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10 * values.fem),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSectionTitle('CHIẾN DỊCH ƯU ĐÃI', values),
              ],
            ),
          ),
          SizedBox(height: 12 * values.hem),
          _buildCampaignsList(context, values, roleState),
          SizedBox(height: 10 * values.hem),
        ],
      ),
    );
  }
  
  Widget _buildCampaignsList(
      BuildContext context, ResponsiveValues values, RoleAppState roleState) {
    return BlocBuilder<CampaignBloc, CampaignState>(
      builder: (context, state) {
        if (state is CampaignLoading) {
          return shimmerLoading(1);
        } else if (state is CampaignsLoaded) {
          if (state.campaigns.isEmpty) {
            return _buildEmptyCampaignMessage(values);
          } else {
            return _buildCampaignsListView(context, state, values, roleState);
          }
        }
        return Center(child: CircularProgressIndicator(color: kPrimaryColor));
      },
    );
  }
  
  Widget _buildCampaignsListView(BuildContext context, CampaignsLoaded state, 
      ResponsiveValues values, RoleAppState roleState) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: state.hasReachMax 
          ? state.campaigns.length 
          : state.campaigns.length + 1,
      itemBuilder: (context, index) {
        if (index >= state.campaigns.length) {
          return Center(
            child: CircularProgressIndicator(color: kPrimaryColor),
          );
        } else {
          return GestureDetector(
            onTap: () => _navigateToDetailCampaign(
              context, roleState, state.campaigns[index].id),
            child: CampaignListCard(
              fem: values.fem,
              hem: values.hem,
              ffem: values.ffem,
              campaignModel: state.campaigns[index],
              onTap: () => _navigateToDetailCampaign(
                context, roleState, state.campaigns[index].id),
            ),
          );
        }
      },
    );
  }

  // Utility widgets
  Widget _buildSectionTitle(String title, ResponsiveValues values) {
    return Text(
      title,
      style: GoogleFonts.openSans(
        textStyle: TextStyle(
          fontSize: 15 * values.ffem,
          height: values.heightText,
          color: Colors.black,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
  
  Widget _buildEmptyCampaignMessage(ResponsiveValues values) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15 * values.fem),
      height: 220 * values.hem,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/campaign-navbar-icon.svg',
            width: 60 * values.fem,
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
  }
  
  Widget _buildLoadingIndicator(ResponsiveValues values) {
    return Center(
      child: Lottie.asset(
        'assets/animations/loading-screen.json',
        width: 50 * values.fem,
        height: 50 * values.hem,
      ),
    );
  }
  
  // Event handlers
  void _handleInternetState(BuildContext context, InternetState state) {
    if (state is Connected) {
      _showConnectedSnackBar(context);
    } else if (state is NotConnected) {
      _showNoInternetDialog(context);
    }
  }

  void _showConnectedSnackBar(BuildContext context) {
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
  }

  void _showNoInternetDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Không kết nối Internet'),
        content: const Text('Vui lòng kết nối Internet'),
        actions: [
          TextButton(
            onPressed: () {
              final stateInternet = context.read<InternetBloc>().state;
              if (stateInternet is Connected) {
                Navigator.pop(context);
              }
            },
            child: const Text('Đồng ý'),
          ),
        ],
      ),
    );
  }
  
  void _handleCheckInState(BuildContext context, CheckInState state) {
    if (state is CheckInLoaded && !state.canCheckInToday) {
      context.read<RoleAppBloc>().add(RoleAppStart());
      final previousState = context.read<CheckInBloc>().state;
      
      if (previousState is CheckInLoaded && previousState.canCheckInToday) {
        String message;
        if (state.streak >= 7) {
          message = 'Bạn đã đạt chuỗi 7 ngày! Nhận 70 điểm mỗi ngày nếu giữ chuỗi!';
        } else {
          message = 'Bạn nhận được ${state.rewardPoints} điểm!';
        }
        _showSuccessSnackBar(context, 'Điểm danh thành công', message);
      }
    } else if (state is CheckInError) {
      _showErrorSnackBar(context, 'Lỗi', state.message);
    }
  }
  
  void _handleDayTap(BuildContext context, CheckInLoaded state) {
    if (state.canCheckInToday) {
      _animationController.forward(from: 0);
      context.read<CheckInBloc>().add(CheckIn());
    } else {
      _showWarningSnackBar(
        context, 'Thông báo', 'Bạn đã điểm danh hôm nay rồi!');
    }
  }
  
  void _showSuccessSnackBar(BuildContext context, String title, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        elevation: 0,
        duration: const Duration(milliseconds: 2000),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: title,
          message: message,
          contentType: ContentType.success,
        ),
      ));
  }
  
  void _showErrorSnackBar(BuildContext context, String title, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        elevation: 0,
        duration: const Duration(milliseconds: 2000),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: title,
          message: message,
          contentType: ContentType.failure,
        ),
      ));
  }
  
  void _showWarningSnackBar(BuildContext context, String title, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        elevation: 0,
        duration: const Duration(milliseconds: 2000),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: title,
          message: message,
          contentType: ContentType.warning,
        ),
      ));
  }
  
  // Navigation helpers
  void _navigateBasedOnRole(BuildContext context, RoleAppState roleState, 
      String unverifiedRoute, String verifiedRoute) {
    if (roleState is Unverified) {
      Navigator.pushNamed(context, unverifiedRoute);
    } else {
      Navigator.pushNamed(context, verifiedRoute);
    }
  }
  
  void _navigateToDetailCampaign(
      BuildContext context, RoleAppState roleState, String campaignId) {
    if (roleState is Unverified) {
      Navigator.pushNamed(context, UnverifiedScreen.routeName);
    } else {
      Navigator.pushNamed(
        context, 
        CampaignDetailStudentScreen.routeName,
        arguments: campaignId,
      );
    }
  }
  
  // Data operations
  Future<void> _refreshData(BuildContext context) async {
    context.read<CampaignBloc>().add(LoadCampaigns());
    context.read<BrandBloc>().add(LoadBrands(page: 1, size: 10));
  }
}

// Utility widget for shimmer loading
Widget shimmerLoading(int pageSize) {
  return ListView.builder(
    itemCount: pageSize,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
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

// Model class to store responsive values
class ResponsiveValues {
  final double fem;
  final double ffem;
  final double hem;
  final double heightText;

  const ResponsiveValues({
    required this.fem,
    required this.ffem,
    required this.hem,
    required this.heightText,
  });
}