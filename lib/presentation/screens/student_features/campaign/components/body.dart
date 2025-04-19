import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_model.dart';
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
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin{
  // Constants
  static const double _baseWidth = 375;
  static const double _baseHeight = 812;

  // State variables
  StudentModel? studentModel;
  late AnimationController _animationController;
  bool _isAnimationPlaying = false;
  ResponsiveValues? _cachedResponsiveValues;
  
  // Optimizing scroll loading
  final ScrollController _campaignScrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initAnimationController();
    _loadStudentData();
    _setupScrollListener();
  }

  void _initAnimationController() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  void _setupScrollListener() {
    // Optimize the scroll listener to avoid excessive rebuilds
    _campaignScrollController.addListener(() {
      final maxScroll = _campaignScrollController.position.maxScrollExtent;
      final currentScroll = _campaignScrollController.position.pixels;
      
      // Only trigger load more when we're near the end and not already loading
      if (currentScroll > maxScroll - 200 && !_isLoadingMore) {
        final campaignState = context.read<CampaignBloc>().state;
        if (campaignState is CampaignsLoaded && !campaignState.hasReachMax) {
          _isLoadingMore = true;
          context.read<CampaignBloc>().add(LoadMoreCampaigns());
        }
      }
    });
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
    _campaignScrollController.dispose();
    super.dispose();
  }

  // Cached responsive values to prevent recalculation
  ResponsiveValues _getResponsiveValues(BuildContext context) {
    if (_cachedResponsiveValues != null) return _cachedResponsiveValues!;
    
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    
    final fem = width / _baseWidth;
    final ffem = fem * 0.97;
    final hem = height / _baseHeight;
    final heightText = 1.3625 * ffem / fem;

    _cachedResponsiveValues = ResponsiveValues(
      fem: fem,
      ffem: ffem,
      hem: hem,
      heightText: heightText,
    );
    return _cachedResponsiveValues!;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final responsiveValues = _getResponsiveValues(context);
    
    return BlocListener<InternetBloc, InternetState>(
      listener: _handleInternetState,
      child: RefreshIndicator(
        onRefresh: () async {
          _isLoadingMore = false;
          return _refreshData(context);
        },
        // Use a separate scroll controller optimized for infinite scrolling
        child: CustomScrollView(
          controller: _campaignScrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _MembershipSection(responsiveValues: responsiveValues),
                  SizedBox(height: 5 * responsiveValues.hem),
                  _DailyCheckInSection(
                    responsiveValues: responsiveValues,
                    animationController: _animationController,
                    onDayTap: (state) => _handleDayTap(context, state),
                    onCheckInStateChanged: (context, state) => 
                        _handleCheckInState(context, state),
                  ),
                  SizedBox(height: 5 * responsiveValues.hem),
                  _TodayCampaignsSection(responsiveValues: responsiveValues),
                  SizedBox(height: 5 * responsiveValues.hem),
                  _BrandsSection(responsiveValues: responsiveValues),
                  SizedBox(height: 5 * responsiveValues.hem),
                  _CampaignsSection(responsiveValues: responsiveValues),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Animation control methods
  void _startBounceAnimation() {
    if (!_isAnimationPlaying) {
      _isAnimationPlaying = true;
      _animationController.forward(from: 0).then((_) {
        _isAnimationPlaying = false;
      });
    }
  }

  // CheckIn handling
  void _handleDayTap(BuildContext context, CheckInLoaded state) {
    if (state.canCheckInToday) {
      context.read<CheckInBloc>().add(CheckIn());
    } else {
      _showWarningSnackBar(
        context, 'Thông báo', 'Bạn đã điểm danh hôm nay rồi!');
    }
  }
  
  void _handleCheckInState(BuildContext context, CheckInState state) {
    if(state is CheckInSuccess) {
            context.read<RoleAppBloc>().add(RoleAppStart());
    }
    if (state is CheckInLoaded && !state.canCheckInToday) {
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
  
  // Internet state handling
  void _handleInternetState(BuildContext context, InternetState state) {
    if (state is Connected) {
      _showConnectedSnackBar(context);
    } else if (state is NotConnected) {
      _showNoInternetDialog(context);
    }
  }

  // Snackbar methods
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
  
  // Data operations
  Future<void> _refreshData(BuildContext context) async {
    context.read<CampaignBloc>().add(LoadCampaigns());
    context.read<BrandBloc>().add(LoadBrands(page: 1, size: 10));
    context.read<CheckInBloc>().add(LoadCheckInData());
  }
}

// Separated section widgets for better performance
class _MembershipSection extends StatelessWidget {
  const _MembershipSection({
    Key? key,
    required this.responsiveValues,
  }) : super(key: key);

  final ResponsiveValues responsiveValues;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoleAppBloc, RoleAppState>(
      builder: (context, state) {
        if (state is Unverified) {
          return _buildUnverifiedCard();
        } else if (state is Verified) {
          return _buildMembershipCard(state.studentModel);
        }
        return _buildLoadingIndicator();
      },
    );
  }
  
  Widget _buildUnverifiedCard() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15 * responsiveValues.fem),
      color: kbgWhiteColor,
      child: CardForUnVerified(
        fem: responsiveValues.fem,
        hem: responsiveValues.hem,
        ffem: responsiveValues.ffem,
      ),
    );
  }
  
  Widget _buildMembershipCard(StudentModel student) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15 * responsiveValues.fem),
      color: kbgWhiteColor,
      child: MemberShipCard(
        fem: responsiveValues.fem,
        hem: responsiveValues.hem,
        ffem: responsiveValues.ffem,
        heightText: responsiveValues.heightText,
        studentModel: student,
      ),
    );
  }
  
  Widget _buildLoadingIndicator() {
    return Center(
      child: Lottie.asset(
        'assets/animations/loading-screen.json',
        width: 50 * responsiveValues.fem,
        height: 50 * responsiveValues.hem,
      ),
    );
  }
}

class _DailyCheckInSection extends StatelessWidget {
  const _DailyCheckInSection({
    Key? key,
    required this.responsiveValues,
    required this.animationController,
    required this.onDayTap,
    required this.onCheckInStateChanged,
  }) : super(key: key);

  final ResponsiveValues responsiveValues;
  final AnimationController animationController;
  final Function(CheckInLoaded) onDayTap;
  final Function(BuildContext, CheckInState) onCheckInStateChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10 * responsiveValues.fem,
        horizontal: 10 * responsiveValues.fem,
      ),
      width: double.infinity,
      color: kbgWhiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('ĐIỂM DANH HẰNG NGÀY'),
          SizedBox(height: 10 * responsiveValues.hem),
          _buildCheckInContent(context),
        ],
      ),
    );
  }

  Widget _buildCheckInContent(BuildContext context) {
    // Using RepaintBoundary to optimize animation rendering
    return RepaintBoundary(
        child: BlocConsumer<CheckInBloc, CheckInState>(
          listener: onCheckInStateChanged,
          builder: (context, state) {
            if(state is CheckInSuccess) {
              context.read<RoleAppBloc>().add(RoleAppStart());
            }
            if (state is CheckInLoaded) {
              return _buildCheckInCalendar(context, state);
            }
            return Center(
              child: CircularProgressIndicator(color: kPrimaryColor),
            );
          },
        ),
      );
  }

  Widget _buildCheckInCalendar(BuildContext context, CheckInLoaded state) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(7, (index) {
            final isChecked = state.checkInHistory.length > index && 
                state.checkInHistory[index];
            final isToday = index == state.currentDayIndex;
            
            return GestureDetector(
              onTap: isToday ? () => onDayTap(state) : null,
              child: _buildDayItem(isChecked, isToday, state, index),
            );
          }),
        ),
        SizedBox(height: 10 * responsiveValues.hem),
        _buildStreakCounter(state),
      ],
    );
  }
  
  Widget _buildDayItem(bool isChecked, bool isToday, CheckInLoaded state, int index) {
    // Only animate the current day that needs attention
    if (isToday && !isChecked && state.canCheckInToday) {
      return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return _buildDayItemContent(
            isChecked, 
            isToday, 
            state, 
            index, 
            offset: -animationController.value * 10,
          );
        },
      );
    }
    
    // For other days, no need to rebuild with animation
    return _buildDayItemContent(isChecked, isToday, state, index, offset: 0);
  }
  
  Widget _buildDayItemContent(
      bool isChecked, bool isToday, CheckInLoaded state, int index, {double offset = 0}) {
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
              width: 40 * responsiveValues.fem,
              height: 40 * responsiveValues.hem,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            bottom: 7 * responsiveValues.hem,
            child: Text(
              'Ngày ${index + 1}',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 9 * responsiveValues.ffem,
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
  }
  
  Widget _buildStreakCounter(CheckInLoaded state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10 * responsiveValues.hem),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Chuỗi: ${state.streak} ngày',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 12 * responsiveValues.ffem,
                color: kPrimaryColor,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.openSans(
        textStyle: TextStyle(
          fontSize: 15 * responsiveValues.ffem,
          height: responsiveValues.heightText,
          color: Colors.black,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _TodayCampaignsSection extends StatelessWidget {
  const _TodayCampaignsSection({
    Key? key,
    required this.responsiveValues,
  }) : super(key: key);

  final ResponsiveValues responsiveValues;

  @override
  Widget build(BuildContext context) {
    final roleState = context.watch<RoleAppBloc>().state;
    
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10 * responsiveValues.fem),
      width: double.infinity,
      color: kbgWhiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10 * responsiveValues.hem),
            child: _buildSectionTitle('HÔM NAY CÓ GÌ'),
          ),
          SizedBox(height: 10 * responsiveValues.hem),
          _buildTodayCampaigns(context, roleState),
        ],
      ),
    );
  }
  
  Widget _buildTodayCampaigns(BuildContext context, RoleAppState roleState) {
    return BlocBuilder<CampaignBloc, CampaignState>(
      buildWhen: (previous, current) {
        // Only rebuild when the campaigns list changes
        if (previous is CampaignsLoaded && current is CampaignsLoaded) {
          return previous.campaigns != current.campaigns;
        }
        return previous != current;
      },
      builder: (context, state) {
        if (state is CampaignsLoaded) {
          if (state.campaigns.isEmpty) {
            return _buildEmptyCampaignMessage();
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.openSans(
        textStyle: TextStyle(
          fontSize: 15 * responsiveValues.ffem,
          height: responsiveValues.heightText,
          color: Colors.black,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
  
  Widget _buildEmptyCampaignMessage() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15 * responsiveValues.fem),
      height: 220 * responsiveValues.hem,
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
            width: 60 * responsiveValues.fem,
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
}

class _BrandsSection extends StatelessWidget {
  const _BrandsSection({
    Key? key,
    required this.responsiveValues,
  }) : super(key: key);

  final ResponsiveValues responsiveValues;

  @override
  Widget build(BuildContext context) {
    final roleState = context.watch<RoleAppBloc>().state;
    
    return Container(
      color: kbgWhiteColor,
      padding: EdgeInsets.symmetric(vertical: 15 * responsiveValues.fem),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10 * responsiveValues.fem),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildSectionTitle('THƯƠNG HIỆU'),
                _buildViewMoreButton(context, roleState),
              ],
            ),
          ),
          SizedBox(height: 12 * responsiveValues.hem),
          _buildBrandsList(context, roleState),
        ],
      ),
    );
  }
  
  Widget _buildViewMoreButton(BuildContext context, RoleAppState roleState) {
    return InkWell(
      onTap: () => _navigateBasedOnRole(
        context, 
        roleState, 
        UnverifiedScreen.routeName,
        BrandListScreen.routeName
      ),
      child: Container(
        height: 22 * responsiveValues.hem,
        width: 22 * responsiveValues.fem,
        margin: EdgeInsets.only(left: 8 * responsiveValues.fem),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(80),
        ),
        child: Icon(
          Icons.arrow_forward_rounded,
          size: 18 * responsiveValues.fem,
          color: kDarkPrimaryColor,
        ),
      ),
    );
  }
  
  Widget _buildBrandsList(BuildContext context, RoleAppState roleState) {
    // Using separate BlocProvider to prevent unnecessary rebuilds
    return  BlocBuilder<BrandBloc, BrandState>(
        builder: (context, state) {
          if (state is BrandsLoaded) {
            return SizedBox(
              height: 160 * responsiveValues.hem,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                // Horizontal scrolling is better for performance than vertical
                scrollDirection: Axis.horizontal,
                itemCount: state.brands.length + 1,
                itemBuilder: (context, index) {
                  if (index == state.brands.length) {
                    return _buildViewMoreBrandsItem(context, roleState);
                  } else {
                    return BrandCard(
                      fem: responsiveValues.fem,
                      hem: responsiveValues.hem,
                      ffem: responsiveValues.ffem,
                      brandModel: state.brands[index],
                    );
                  }
                },
              ),
            );
          }
          return _buildLoadingIndicator();
        },
      );
  }
  
  Widget _buildViewMoreBrandsItem(BuildContext context, RoleAppState roleState) {
    return InkWell(
      onTap: () => _navigateBasedOnRole(
        context,
        roleState,
        UnverifiedScreen.routeName,
        BrandListScreen.routeName
      ),
      child: Container(
        width: 80 * responsiveValues.fem,
        margin: EdgeInsets.symmetric(horizontal: 5 * responsiveValues.fem),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(80 * responsiveValues.fem),
              child: Container(
                width: 80 * responsiveValues.fem,
                height: 80 * responsiveValues.hem,
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
                          fontSize: 10 * responsiveValues.ffem,
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.openSans(
        textStyle: TextStyle(
          fontSize: 15 * responsiveValues.ffem,
          height: responsiveValues.heightText,
          color: Colors.black,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
  
  Widget _buildLoadingIndicator() {
    return Center(
      child: Lottie.asset(
        'assets/animations/loading-screen.json',
        width: 50 * responsiveValues.fem,
        height: 50 * responsiveValues.hem,
      ),
    );
  }
  
  void _navigateBasedOnRole(BuildContext context, RoleAppState roleState, 
      String unverifiedRoute, String verifiedRoute) {
    if (roleState is Unverified) {
      Navigator.pushNamed(context, unverifiedRoute);
    } else {
      Navigator.pushNamed(context, verifiedRoute);
    }
  }
}

// Use a separate stateful widget for campaigns list to better manage state
class _CampaignsSection extends StatefulWidget {
  const _CampaignsSection({
    Key? key,
    required this.responsiveValues,
  }) : super(key: key);

  final ResponsiveValues responsiveValues;

  @override
  _CampaignsSectionState createState() => _CampaignsSectionState();
}

class _CampaignsSectionState extends State<_CampaignsSection> {
  // Use a separate cache to prevent unnecessary rebuilds
  List<CampaignModel>? _cachedCampaigns;
  bool? _cachedHasReachedMax;

  @override
  Widget build(BuildContext context) {
    final roleState = context.watch<RoleAppBloc>().state;
    
    return Container(
      color: kbgWhiteColor,
      padding: EdgeInsets.symmetric(vertical: 15 * widget.responsiveValues.fem),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10 * widget.responsiveValues.fem),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSectionTitle('CHIẾN DỊCH ƯU ĐÃI'),
              ],
            ),
          ),
          SizedBox(height: 12 * widget.responsiveValues.hem),
          _buildCampaignsList(context, roleState),
          SizedBox(height: 10 * widget.responsiveValues.hem),
        ],
      ),
    );
  }
  
  Widget _buildCampaignsList(BuildContext context, RoleAppState roleState) {
    return BlocConsumer<CampaignBloc, CampaignState>(
      listenWhen: (previous, current) {
        // Only respond when loading more is completed
        if (previous is CampaignsLoaded && current is CampaignsLoaded) {
          return previous.campaigns.length < current.campaigns.length;
        }
        return false;
      },
      listener: (context, state) {
        // Reset the loading flag when new data arrives
        if (state is CampaignsLoaded) {
          context.findAncestorStateOfType<_BodyState>()?._isLoadingMore = false;
        }
      },
      buildWhen: (previous, current) {
        // Avoid rebuilding when the data hasn't changed
        if (previous is CampaignsLoaded && current is CampaignsLoaded) {
          if (_cachedCampaigns == current.campaigns && 
              _cachedHasReachedMax == current.hasReachMax) {
            return false;
          }
          
          _cachedCampaigns = current.campaigns;
          _cachedHasReachedMax = current.hasReachMax;
          return true;
        }
        return previous.runtimeType != current.runtimeType;
      },
      builder: (context, state) {
        if (state is CampaignLoading) {
          return _buildShimmerLoading();
        } else if (state is CampaignsLoaded) {
          if (state.campaigns.isEmpty) {
            return _buildEmptyCampaignMessage();
          } else {
            return _buildCampaignsListView(context, state, roleState);
          }
        }
        return Center(child: CircularProgressIndicator(color: kPrimaryColor));
      },
    );
  }
  
  Widget _buildCampaignsListView(
      BuildContext context, CampaignsLoaded state, RoleAppState roleState) {
    // Extract the campaigns once to avoid multiple accesses
    final campaigns = state.campaigns;
    final hasReachedMax = state.hasReachMax;
    
    // Use SliverList in a ListView to improve performance
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: hasReachedMax ? campaigns.length : campaigns.length + 1,
      itemBuilder: (context, index) {
        if (index >= campaigns.length) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: CircularProgressIndicator(color: kPrimaryColor),
            ),
          );
        }
        
        // Cache campaign for this index
        final campaign = campaigns[index];
        
        // Using RepaintBoundary to optimize rendering
        return RepaintBoundary(
          child: GestureDetector(
            onTap: () => _navigateToDetailCampaign(context, roleState, campaign.id),
            child: CampaignListCard(
              fem: widget.responsiveValues.fem,
              hem: widget.responsiveValues.hem,
              ffem: widget.responsiveValues.ffem,
              campaignModel: campaign,
              onTap: () => _navigateToDetailCampaign(context, roleState, campaign.id),
            ),
          ),
        );
      },
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      itemCount: 3,
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.openSans(
        textStyle: TextStyle(
          fontSize: 15 * widget.responsiveValues.ffem,
          height: widget.responsiveValues.heightText,
          color: Colors.black,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
  
  Widget _buildEmptyCampaignMessage() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15 * widget.responsiveValues.fem),
      height: 220 * widget.responsiveValues.hem,
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
            width: 60 * widget.responsiveValues.fem,
            colorFilter: ColorFilter.mode(
              kLowTextColor,
              BlendMode.srcIn,
            ),
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                'Không có chiến dịch nào \nđang diễn ra!',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
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