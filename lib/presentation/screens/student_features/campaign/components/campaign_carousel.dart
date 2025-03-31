
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_model.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/student_features/campaign_detail/campaign_detail_screen.dart';
import 'package:swallet_mobile/presentation/widgets/unverified_screen.dart';


import '../../../../widgets/shimmer_widget.dart';

class CampaignCarousel extends StatefulWidget {
  final List<CampaignModel> campaigns;
  final roleState;
  const CampaignCarousel(
      {super.key, required this.campaigns, required this.roleState});

  @override
  State<CampaignCarousel> createState() => _CampaignCarouselState();
}

class _CampaignCarouselState extends State<CampaignCarousel> {
  int activeIndex = 0;
  late List<CampaignModel> camps;
  @override
  void initState() {
    if (widget.campaigns.length >= 3) {
      camps = [
        widget.campaigns[0],
        widget.campaigns[1],
        widget.campaigns[2],
      ];
    } else if (widget.campaigns.length < 3) {
      camps = widget.campaigns;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: CarouselSlider(
              options: CarouselOptions(
                  // viewportFraction: 1,
                  // disableCenter: true,
                  autoPlay: true,
                  height: 270,
                  padEnds: false,
                  autoPlayInterval: Duration(seconds: 20),
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  },
                  viewportFraction: 0.95),
              items: camps.map((campaign) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        if (widget.roleState is Unverified) {
                          Navigator.pushNamed(
                              context, UnverifiedScreen.routeName);
                        } else {
                          Navigator.pushNamed(
                              context, CampaignDetailStudentScreen.routeName,
                              arguments: campaign.id);
                        }
                      },
                      child: SizedBox(
                        width: 360,
                        child: Card(
                          elevation: 2,
                          surfaceTintColor: Colors.white,
                          margin: const EdgeInsets.fromLTRB(4, 4, 20, 4),
                          shadowColor: klighGreyColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 210,
                                  child: Image.network(
                                    campaign.image,
                                    fit: BoxFit.fill,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return ShimmerWidget.rectangular(
                                          height: 160);
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/image-404.jpg',
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          campaign.campaignName.toUpperCase(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          style: GoogleFonts.openSans(
                                              textStyle: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          )),
                                        ),
                                        Text(
                                          campaign.brandName,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          style: GoogleFonts.openSans(
                                              textStyle: TextStyle(
                                            fontSize: 12,
                                            color: klowTextGrey,
                                            fontWeight: FontWeight.normal,
                                          )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (widget.roleState is Unverified) {
                                        Navigator.pushNamed(
                                            context, UnverifiedScreen.routeName);
                                      } else {
                                        Navigator.pushNamed(context,
                                            CampaignDetailStudentScreen.routeName,
                                            arguments: campaign.id);
                                      }
                                    },
                                    child: Container(
                                      width: 65,
                                      height: 30,
                                      margin: EdgeInsets.only(right: 10, top: 5),
                                      decoration: BoxDecoration(
                                          color: kPrimaryColor,
                                          border:
                                              Border.all(color: kPrimaryColor),
                                          borderRadius: BorderRadius.circular(5)),
                                      child: Center(
                                        child: Text(
                                          'Xem ngay',
                                          style: GoogleFonts.openSans(
                                              textStyle: TextStyle(
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList()),
        ),
        const SizedBox(
          height: 10,
        ),
        buildIndicator(camps.length),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget buildIndicator(int count) => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: count,
        effect: SlideEffect(
            activeDotColor: kPrimaryColor,
            dotWidth: 20,
            dotHeight: 5,
            dotColor: Color.fromARGB(255, 216, 216, 216)),
      );
}
