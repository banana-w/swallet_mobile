import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_model.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/student_features/campaign_detail/campaign_detail_screen.dart';
import 'package:swallet_mobile/presentation/widgets/role_navigation.dart';

import '../../../../widgets/shimmer_widget.dart';

class CampaignCarousel extends StatefulWidget {
  const CampaignCarousel({super.key, required this.campaigns});

  /// Số chiến dịch tối đa hiển thị trong carousel.
  static const int maxItems = 6;

  final List<CampaignModel> campaigns;

  @override
  State<CampaignCarousel> createState() => _CampaignCarouselState();
}

class _CampaignCarouselState extends State<CampaignCarousel> {
  // ValueNotifier thay cho setState: đổi trang chỉ vẽ lại dấu chấm chỉ mục,
  // không dựng lại 6 thẻ (kèm ảnh network) bên trong.
  final ValueNotifier<int> _activeIndex = ValueNotifier<int>(0);

  late List<CampaignModel> _camps = _visibleCampaigns;

  List<CampaignModel> get _visibleCampaigns =>
      widget.campaigns.take(CampaignCarousel.maxItems).toList(growable: false);

  @override
  void didUpdateWidget(CampaignCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Trước đây danh sách chỉ lấy trong initState nên kéo-làm-mới không đổi nội dung.
    if (oldWidget.campaigns != widget.campaigns) {
      _camps = _visibleCampaigns;
      if (_activeIndex.value >= _camps.length) {
        _activeIndex.value = 0;
      }
    }
  }

  @override
  void dispose() {
    _activeIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Giới hạn kích thước ảnh giải mã theo đúng kích thước hiển thị.
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);

    return Column(
      children: [
        Center(
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: _camps.length > 1,
              height: 270,
              padEnds: false,
              autoPlayInterval: const Duration(seconds: 10),
              onPageChanged: (index, reason) => _activeIndex.value = index,
              viewportFraction: 0.95,
              enableInfiniteScroll: _camps.length > 1,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
            items: [
              for (final campaign in _camps)
                _CarouselCard(
                  key: ValueKey(campaign.id),
                  campaign: campaign,
                  devicePixelRatio: devicePixelRatio,
                ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        ValueListenableBuilder<int>(
          valueListenable: _activeIndex,
          builder:
              (context, activeIndex, _) => AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: _camps.length,
                effect: const SlideEffect(
                  activeDotColor: kPrimaryColor,
                  dotWidth: 20,
                  dotHeight: 5,
                  dotColor: Color.fromARGB(255, 216, 216, 216),
                ),
              ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _CarouselCard extends StatelessWidget {
  const _CarouselCard({
    super.key,
    required this.campaign,
    required this.devicePixelRatio,
  });

  static const double _imageHeight = 210;
  static const double _cardWidth = 360;

  final CampaignModel campaign;
  final double devicePixelRatio;

  @override
  Widget build(BuildContext context) {
    void openDetail() => openByRole(
      context,
      CampaignDetailStudentScreen.routeName,
      arguments: campaign.id,
    );

    return GestureDetector(
      onTap: openDetail,
      child: SizedBox(
        width: _cardWidth,
        child: Card(
          elevation: 2,
          surfaceTintColor: Colors.white,
          margin: const EdgeInsets.fromLTRB(4, 4, 20, 4),
          shadowColor: klighGreyColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: _imageHeight,
                  child: Image.network(
                    campaign.image,
                    fit: BoxFit.fill,
                    // Giải mã ảnh đúng bằng kích thước hiển thị thay vì kích
                    // thước gốc, giảm mạnh bộ nhớ ảnh khi lướt carousel.
                    cacheWidth: (_cardWidth * devicePixelRatio).round(),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return ShimmerWidget.rectangular(height: _imageHeight);
                    },
                    errorBuilder:
                        (context, error, stackTrace) =>
                            Image.asset('assets/images/image-404.jpg'),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          campaign.campaignName.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: _campaignNameStyle,
                        ),
                        Text(
                          campaign.brandName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: _brandNameStyle,
                        ),
                      ],
                    ),
                  ),
                  // Giữ nguyên bố cục cũ: Row dùng spaceEvenly với 3 phần tử.
                  const SizedBox(height: 15),
                  InkWell(
                    onTap: openDetail,
                    child: Container(
                      width: 65,
                      height: 30,
                      margin: const EdgeInsets.only(right: 10, top: 5),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        border: Border.all(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(child: Text('Xem ngay', style: _ctaStyle)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Style cố định, dựng một lần cho cả danh sách thay vì mỗi thẻ một lần.
final TextStyle _campaignNameStyle = GoogleFonts.openSans(
  textStyle: const TextStyle(
    fontSize: 13,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  ),
);

final TextStyle _brandNameStyle = GoogleFonts.openSans(
  textStyle: const TextStyle(
    fontSize: 12,
    color: klowTextGrey,
    fontWeight: FontWeight.normal,
  ),
);

final TextStyle _ctaStyle = GoogleFonts.openSans(
  textStyle: const TextStyle(
    fontSize: 9,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  ),
);
