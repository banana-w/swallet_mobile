import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
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
import 'package:swallet_mobile/presentation/widgets/role_navigation.dart';

class CampaignScreenBody extends StatefulWidget {
  const CampaignScreenBody({super.key});

  @override
  State<CampaignScreenBody> createState() => _CampaignScreenBodyState();
}

class _CampaignScreenBodyState extends State<CampaignScreenBody>
    with AutomaticKeepAliveClientMixin {
  /// Khoảng cách tới đáy (px) bắt đầu tải thêm chiến dịch.
  static const double _loadMoreThreshold = 200;

  final ScrollController _scrollController = ScrollController();

  late ResponsiveValues _responsive;
  bool _isNoInternetDialogOpen = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Trước đây event này được bắn từ trong builder của RoleAppBloc nên mỗi lần
    // role đổi state lại gọi API điểm danh một lần. Chỉ cần nạp một lần ở đây.
    context.read<CheckInBloc>().add(LoadCheckInData());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Chỉ tính lại khi kích thước màn hình thật sự đổi (xoay máy, split screen).
    _responsive = ResponsiveValues.of(context);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels < position.maxScrollExtent - _loadMoreThreshold) return;

    final campaignBloc = context.read<CampaignBloc>();
    final state = campaignBloc.state;
    // Bloc tự chặn request trùng nên không cần cờ _isLoadingMore ở đây nữa.
    if (state is CampaignsLoaded && !state.hasReachMax) {
      campaignBloc.add(const LoadMoreCampaigns());
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final responsive = _responsive;
    final gap = SliverToBoxAdapter(child: SizedBox(height: 5 * responsive.hem));

    return BlocListener<InternetBloc, InternetState>(
      listener: _handleInternetState,
      child: RefreshIndicator(
        onRefresh: _refreshData,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: _MembershipSection(responsive: responsive),
            ),
            gap,
            SliverToBoxAdapter(
              child: _DailyCheckInSection(responsive: responsive),
            ),
            gap,
            SliverToBoxAdapter(
              child: _TodayCampaignsSection(responsive: responsive),
            ),
            gap,
            SliverToBoxAdapter(child: _BrandsSection(responsive: responsive)),
            gap,
            _CampaignsSection(responsive: responsive),
          ],
        ),
      ),
    );
  }

  // Internet state handling
  void _handleInternetState(BuildContext context, InternetState state) {
    if (state is Connected) {
      _showAppSnackBar(
        context,
        title: 'Đã kết nối internet',
        message: 'Đã kết nối internet!',
        contentType: ContentType.success,
      );
    } else if (state is NotConnected && !_isNoInternetDialogOpen) {
      _showNoInternetDialog(context);
    }
  }

  Future<void> _showNoInternetDialog(BuildContext context) async {
    _isNoInternetDialogOpen = true;
    await showCupertinoDialog<void>(
      context: context,
      builder:
          (dialogContext) => CupertinoAlertDialog(
            title: const Text('Không kết nối Internet'),
            content: const Text('Vui lòng kết nối Internet'),
            actions: [
              TextButton(
                onPressed: () {
                  if (dialogContext.read<InternetBloc>().state is Connected) {
                    Navigator.pop(dialogContext);
                  }
                },
                child: const Text('Đồng ý'),
              ),
            ],
          ),
    );
    _isNoInternetDialogOpen = false;
  }

  // Data operations
  Future<void> _refreshData() async {
    final campaignBloc = context.read<CampaignBloc>();
    campaignBloc.add(const LoadCampaigns());
    context.read<BrandBloc>().add(const LoadBrands(page: 1, size: 10));
    context.read<CheckInBloc>().add(LoadCheckInData());
    context.read<RoleAppBloc>().add(const RoleAppStart());

    // Giữ vòng xoay của RefreshIndicator tới khi danh sách thật sự tải xong.
    await campaignBloc.stream
        .firstWhere((state) => state is! CampaignLoading)
        .timeout(
          const Duration(seconds: 15),
          onTimeout: () => campaignBloc.state,
        );
  }
}

// ---------------------------------------------------------------------------
// Thẻ thành viên
// ---------------------------------------------------------------------------

class _MembershipSection extends StatelessWidget {
  const _MembershipSection({required this.responsive});

  final ResponsiveValues responsive;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoleAppBloc, RoleAppState>(
      buildWhen:
          (previous, current) =>
              current is Verified ||
              current is Unverified ||
              current is RoleAppLoading,
      builder: (context, state) {
        final Widget card;
        if (state is Unverified) {
          card = CardForUnVerified(
            fem: responsive.fem,
            hem: responsive.hem,
            ffem: responsive.ffem,
          );
        } else if (state is Verified) {
          card = MemberShipCard(
            fem: responsive.fem,
            hem: responsive.hem,
            ffem: responsive.ffem,
            heightText: responsive.heightText,
            studentModel: state.studentModel,
          );
        } else {
          return _LoadingLottie(responsive: responsive);
        }

        return Container(
          padding: EdgeInsets.symmetric(vertical: 15 * responsive.fem),
          color: kbgWhiteColor,
          child: card,
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Điểm danh hằng ngày
// ---------------------------------------------------------------------------

class _DailyCheckInSection extends StatelessWidget {
  const _DailyCheckInSection({required this.responsive});

  final ResponsiveValues responsive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10 * responsive.fem,
        horizontal: 10 * responsive.fem,
      ),
      width: double.infinity,
      color: kbgWhiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ĐIỂM DANH HẰNG NGÀY', style: responsive.sectionTitle),
          SizedBox(height: 10 * responsive.hem),
          RepaintBoundary(
            child: BlocConsumer<CheckInBloc, CheckInState>(
              // CheckInBloc emit CheckInSuccess rồi mới emit CheckInLoaded kèm
              // điểm thưởng, nên chỉ bắt đúng chuyển tiếp đó để báo thành công.
              listenWhen:
                  (previous, current) =>
                      current is CheckInError ||
                      (previous is CheckInSuccess && current is CheckInLoaded),
              listener: _onCheckInStateChanged,
              builder: (context, state) {
                if (state is CheckInLoaded) {
                  return _buildCalendar(context, state);
                }
                return Center(
                  child: CircularProgressIndicator(color: kPrimaryColor),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onCheckInStateChanged(BuildContext context, CheckInState state) {
    if (state is CheckInError) {
      _showAppSnackBar(
        context,
        title: 'Lỗi',
        message: state.message,
        contentType: ContentType.failure,
      );
      return;
    }
    if (state is! CheckInLoaded) return;

    // Điểm danh xong thì số dư điểm thay đổi, nạp lại thông tin thành viên.
    context.read<RoleAppBloc>().add(const RoleAppStart());
    _showAppSnackBar(
      context,
      title: 'Điểm danh thành công',
      message:
          state.streak >= 7
              ? 'Bạn đã đạt chuỗi 7 ngày! Nhận 70 điểm mỗi ngày nếu giữ chuỗi!'
              : 'Bạn nhận được ${state.rewardPoints} điểm!',
      contentType: ContentType.success,
    );
  }

  void _onDayTap(BuildContext context, CheckInLoaded state) {
    if (state.canCheckInToday) {
      context.read<CheckInBloc>().add(CheckIn());
    } else {
      _showAppSnackBar(
        context,
        title: 'Thông báo',
        message: 'Bạn đã điểm danh hôm nay rồi!',
        contentType: ContentType.warning,
      );
    }
  }

  Widget _buildCalendar(BuildContext context, CheckInLoaded state) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(7, (index) {
            final isChecked =
                index < state.checkInHistory.length &&
                state.checkInHistory[index];
            final isToday =
                index == state.currentDayIndex && state.canCheckInToday;

            return GestureDetector(
              onTap: isToday ? () => _onDayTap(context, state) : null,
              child: _buildDayItem(
                index: index,
                isChecked: isChecked,
                isToday: isToday,
              ),
            );
          }),
        ),
        SizedBox(height: 10 * responsive.hem),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10 * responsive.hem),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Chuỗi: ${state.streak} ngày',
                style: responsive.streakCounter,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDayItem({
    required int index,
    required bool isChecked,
    required bool isToday,
  }) {
    final isHighlighted = isChecked || isToday;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
              if (isToday)
                BoxShadow(
                  color: Colors.yellow.withValues(alpha: 0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
            ],
          ),
          child: SvgPicture.asset(
            isHighlighted
                ? 'assets/images/gift_checked.svg'
                : 'assets/images/gift_unchecked.svg',
            width: 40 * responsive.fem,
            height: 40 * responsive.hem,
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          bottom: 7 * responsive.hem,
          child: Text(
            'Ngày ${index + 1}',
            textAlign: TextAlign.center,
            style:
                isHighlighted
                    ? responsive.dayLabelActive
                    : responsive.dayLabelInactive,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Hôm nay có gì
// ---------------------------------------------------------------------------

class _TodayCampaignsSection extends StatelessWidget {
  const _TodayCampaignsSection({required this.responsive});

  final ResponsiveValues responsive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10 * responsive.fem),
      width: double.infinity,
      color: kbgWhiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10 * responsive.hem),
            child: Text('HÔM NAY CÓ GÌ', style: responsive.sectionTitle),
          ),
          SizedBox(height: 10 * responsive.hem),
          BlocBuilder<CampaignBloc, CampaignState>(
            buildWhen: _campaignListBuildWhen,
            builder: (context, state) {
              if (state is CampaignsFailed) {
                // Nút thử lại chỉ đặt ở mục "Chiến dịch ưu đãi" bên dưới để
                // không hiện hai nút cho cùng một lần tải hỏng.
                return _CampaignsError(
                  responsive: responsive,
                  message: state.error,
                  showRetry: false,
                );
              }
              if (state is! CampaignsLoaded) {
                return Center(
                  child: CircularProgressIndicator(color: kPrimaryColor),
                );
              }
              if (state.campaigns.isEmpty) {
                return _EmptyCampaigns(responsive: responsive);
              }
              return Padding(
                padding: const EdgeInsets.only(left: 10),
                child: CampaignCarousel(campaigns: state.campaigns),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Thương hiệu
// ---------------------------------------------------------------------------

class _BrandsSection extends StatelessWidget {
  const _BrandsSection({required this.responsive});

  final ResponsiveValues responsive;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kbgWhiteColor,
      padding: EdgeInsets.symmetric(vertical: 15 * responsive.fem),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10 * responsive.fem),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('THƯƠNG HIỆU', style: responsive.sectionTitle),
                _buildViewMoreButton(context),
              ],
            ),
          ),
          SizedBox(height: 12 * responsive.hem),
          BlocBuilder<BrandBloc, BrandState>(
            builder: (context, state) {
              if (state is! BrandsLoaded) {
                return _LoadingLottie(responsive: responsive);
              }
              return SizedBox(
                height: 160 * responsive.hem,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  addAutomaticKeepAlives: false,
                  itemCount: state.brands.length + 1,
                  itemBuilder: (context, index) {
                    if (index == state.brands.length) {
                      return _buildViewMoreBrandsItem(context);
                    }
                    final brand = state.brands[index];
                    return BrandCard(
                      fem: responsive.fem,
                      hem: responsive.hem,
                      ffem: responsive.ffem,
                      brandModel: brand,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildViewMoreButton(BuildContext context) {
    return InkWell(
      onTap: () => openByRole(context, BrandListScreen.routeName),
      child: Container(
        height: 22 * responsive.hem,
        width: 22 * responsive.fem,
        margin: EdgeInsets.only(left: 8 * responsive.fem),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(80),
        ),
        child: Icon(
          Icons.arrow_forward_rounded,
          size: 18 * responsive.fem,
          color: kDarkPrimaryColor,
        ),
      ),
    );
  }

  Widget _buildViewMoreBrandsItem(BuildContext context) {
    return InkWell(
      onTap: () => openByRole(context, BrandListScreen.routeName),
      child: Container(
        width: 80 * responsive.fem,
        margin: EdgeInsets.symmetric(horizontal: 5 * responsive.fem),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(80 * responsive.fem),
              child: Container(
                width: 80 * responsive.fem,
                height: 80 * responsive.hem,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.arrow_forward, size: 30),
                    Text(
                      'Xem thêm',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: responsive.viewMore,
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
}

// ---------------------------------------------------------------------------
// Chiến dịch ưu đãi (sliver để danh sách dựng lazy theo scroll)
// ---------------------------------------------------------------------------

class _CampaignsSection extends StatelessWidget {
  const _CampaignsSection({required this.responsive});

  final ResponsiveValues responsive;

  @override
  Widget build(BuildContext context) {
    return DecoratedSliver(
      decoration: const BoxDecoration(color: kbgWhiteColor),
      sliver: SliverMainAxisGroup(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                top: 15 * responsive.fem,
                left: 10 * responsive.fem,
                bottom: 12 * responsive.hem,
              ),
              child: Text('CHIẾN DỊCH ƯU ĐÃI', style: responsive.sectionTitle),
            ),
          ),
          BlocBuilder<CampaignBloc, CampaignState>(
            buildWhen: _campaignListBuildWhen,
            builder: (context, state) {
              if (state is CampaignsFailed) {
                return SliverToBoxAdapter(
                  child: _CampaignsError(
                    responsive: responsive,
                    message: state.error,
                  ),
                );
              }
              if (state is! CampaignsLoaded) {
                return SliverToBoxAdapter(
                  child: _ShimmerCampaigns(responsive: responsive),
                );
              }
              if (state.campaigns.isEmpty) {
                return SliverToBoxAdapter(
                  child: _EmptyCampaigns(responsive: responsive),
                );
              }

              final campaigns = state.campaigns;
              return SliverList.builder(
                itemCount:
                    state.hasReachMax ? campaigns.length : campaigns.length + 1,
                itemBuilder: (context, index) {
                  if (index >= campaigns.length) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: CircularProgressIndicator(color: kPrimaryColor),
                      ),
                    );
                  }
                  final campaign = campaigns[index];
                  void openDetail() => openByRole(
                    context,
                    CampaignDetailStudentScreen.routeName,
                    arguments: campaign.id,
                  );

                  return GestureDetector(
                    onTap: openDetail,
                    child: CampaignListCard(
                      fem: responsive.fem,
                      hem: responsive.hem,
                      ffem: responsive.ffem,
                      campaignModel: campaign,
                      onTap: openDetail,
                    ),
                  );
                },
              );
            },
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 15 * responsive.fem + 10 * responsive.hem),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Dùng chung
// ---------------------------------------------------------------------------

/// Chỉ dựng lại theo các state của danh sách chiến dịch.
///
/// [CampaignBloc] là bloc dùng chung toàn app, các state của luồng khác (ví dụ
/// [CampaignByIdLoaded]) bị bỏ qua để danh sách không biến thành vòng xoay.
bool _campaignListBuildWhen(CampaignState previous, CampaignState current) =>
    current is CampaignsLoaded ||
    current is CampaignLoading ||
    current is CampaignsFailed;

void _showAppSnackBar(
  BuildContext context, {
  required String title,
  required String message,
  required ContentType contentType,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(milliseconds: 2000),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: title,
          message: message,
          contentType: contentType,
        ),
      ),
    );
}

class _LoadingLottie extends StatelessWidget {
  const _LoadingLottie({required this.responsive});

  final ResponsiveValues responsive;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/animations/loading-screen.json',
        width: 50 * responsive.fem,
        height: 50 * responsive.hem,
      ),
    );
  }
}

class _EmptyCampaigns extends StatelessWidget {
  const _EmptyCampaigns({required this.responsive});

  final ResponsiveValues responsive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15 * responsive.fem),
      height: 220 * responsive.hem,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/campaign-navbar-icon.svg',
            width: 60 * responsive.fem,
            colorFilter: const ColorFilter.mode(kLowTextColor, BlendMode.srcIn),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              'Không có chiến dịch nào \nđang diễn ra!',
              textAlign: TextAlign.center,
              style: responsive.emptyMessage,
            ),
          ),
        ],
      ),
    );
  }
}

class _CampaignsError extends StatelessWidget {
  const _CampaignsError({
    required this.responsive,
    required this.message,
    this.showRetry = true,
  });

  final ResponsiveValues responsive;
  final String message;
  final bool showRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15 * responsive.fem),
      padding: EdgeInsets.symmetric(vertical: 24 * responsive.hem),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off_rounded,
            size: 40 * responsive.fem,
            color: kLowTextColor,
          ),
          SizedBox(height: 8 * responsive.hem),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16 * responsive.fem),
            child: Text(
              message,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: responsive.emptyMessage,
            ),
          ),
          if (showRetry) ...[
            SizedBox(height: 8 * responsive.hem),
            TextButton(
              onPressed:
                  () => context.read<CampaignBloc>().add(const LoadCampaigns()),
              child: const Text(
                'Thử lại',
                style: TextStyle(color: kPrimaryColor),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ShimmerCampaigns extends StatelessWidget {
  const _ShimmerCampaigns({required this.responsive});

  final ResponsiveValues responsive;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (_) => Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            margin: EdgeInsets.only(
              left: 15 * responsive.fem,
              right: 15 * responsive.fem,
              bottom: 15 * responsive.hem,
            ),
            height: 130 * responsive.hem,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15 * responsive.fem),
            ),
          ),
        ),
      ),
    );
  }
}

/// Hệ số responsive + các TextStyle dựng sẵn cho màn chiến dịch.
///
/// `GoogleFonts.openSans()` phải tra cứu font mỗi lần gọi, nên các style lặp
/// lại được cache tại đây thay vì dựng lại trong từng `build`.
class ResponsiveValues {
  ResponsiveValues({
    required this.fem,
    required this.ffem,
    required this.hem,
    required this.heightText,
  });

  factory ResponsiveValues.of(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / _baseWidth;
    final ffem = fem * 0.97;
    return ResponsiveValues(
      fem: fem,
      ffem: ffem,
      hem: size.height / _baseHeight,
      heightText: 1.3625 * ffem / fem,
    );
  }

  static const double _baseWidth = 375;
  static const double _baseHeight = 812;

  final double fem;
  final double ffem;
  final double hem;
  final double heightText;

  late final TextStyle sectionTitle = GoogleFonts.openSans(
    textStyle: TextStyle(
      fontSize: 15 * ffem,
      height: heightText,
      color: Colors.black,
      fontWeight: FontWeight.w800,
    ),
  );

  late final TextStyle streakCounter = GoogleFonts.openSans(
    textStyle: TextStyle(
      fontSize: 12 * ffem,
      color: kPrimaryColor,
      fontWeight: FontWeight.w900,
    ),
  );

  late final TextStyle emptyMessage = GoogleFonts.openSans(
    textStyle: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
  );

  late final TextStyle viewMore = GoogleFonts.openSans(
    textStyle: TextStyle(
      fontSize: 10 * ffem,
      color: Colors.black,
      fontWeight: FontWeight.normal,
    ),
  );

  late final TextStyle dayLabelActive = _dayLabel(Colors.white);
  late final TextStyle dayLabelInactive = _dayLabel(Colors.grey);

  TextStyle _dayLabel(Color color) => GoogleFonts.openSans(
    textStyle: TextStyle(
      fontSize: 9 * ffem,
      color: color,
      fontWeight: FontWeight.w900,
      shadows: [
        Shadow(
          color: Colors.black.withValues(alpha: 0.5),
          offset: const Offset(1, 1),
          blurRadius: 2,
        ),
      ],
    ),
  );
}
