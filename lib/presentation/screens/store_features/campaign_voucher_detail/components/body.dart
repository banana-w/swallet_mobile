import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/domain/entities/student_features/campaign_voucher_detail_model.dart';
import 'package:swallet_mobile/presentation/blocs/campaign_voucher/campaign_voucher_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/internet/internet_bloc.dart';
import '../../../../config/constants.dart';
import '../../../../widgets/shimmer_widget.dart';

class Body extends StatelessWidget {
  const Body({super.key});

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
      child: BlocBuilder<CampaignVoucherBloc, CampaignVoucherState>(
        builder: (context, state) {
          if (state is CampaignVoucherLoading) {
            return buildCampaignVoucherShimmer(fem, hem);
          } else if (state is CampaignVoucherByIdLoaded) {
            var campaignVoucherDetail = state.campaignVoucherDetail;
            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 220 * hem,
                          child: Image.network(
                            campaignVoucherDetail.image,
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/background_splash.png',
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          width: double.infinity,
                          padding: EdgeInsets.only(
                            left: 15 * fem,
                            top: 10 * hem,
                            bottom: 15 * hem,
                            right: 15 * fem,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                campaignVoucherDetail.brandName,
                                textAlign: TextAlign.justify,
                                softWrap: true,
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    fontSize: 15 * ffem,
                                    color: klowTextGrey,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 2 * hem,
                                  bottom: 5 * hem,
                                ),
                                child: Text(
                                  campaignVoucherDetail.voucherName,
                                  textAlign: TextAlign.justify,
                                  softWrap: true,
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      fontSize: 15 * ffem,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        formatter.format((campaignVoucherDetail.price)),
                                        style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                            fontSize: 22 * ffem,
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 0 * fem,
                                          top: 4 * hem,
                                          bottom: 0 * hem,
                                        ),
                                        child: SvgPicture.asset(
                                          'assets/icons/coin.svg',
                                          width: 32 * fem,
                                          height: 32 * fem,
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                ],
                              ),
                              Text(
                                'Còn lại: ${campaignVoucherDetail.numberOfItemsAvailable}',
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    fontSize: 15 * ffem,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5 * hem),

                        // BrandInformationCard(
                        //     hem: hem,
                        //     fem: fem,
                        //     ffem: ffem,
                        //     campaignDetil: campaignDetil),
                        // SizedBox(
                        //   height: 5 * hem,
                        // ),
                        GestureDetector(
                          onTap: () {},
                          // onTap: () {
                          //   checkLength(campaignDetailModel.condition);
                          // },
                          child: Container(
                            padding: EdgeInsets.only(
                              right: 10 * fem,
                              left: 10 * fem,
                              top: 15 * hem,
                              bottom: 15 * hem,
                            ),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 0 * fem),
                                  child: Text(
                                    'THỂ LỆ ƯU ĐÃI',
                                    style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                        fontSize: 15 * ffem,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 5 * fem,
                                    top: 5 * hem,
                                  ),
                                  child: HtmlWidget(
                                    campaignVoucherDetail.condition,
                                    textStyle: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                        fontSize: 14 * ffem,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10 * hem),
                                Padding(
                                  padding: EdgeInsets.only(left: 0 * fem),
                                  child: Text(
                                    'NỘI DUNG ƯU ĐÃI',
                                    style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                        fontSize: 15 * ffem,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 5 * fem,
                                    top: 5 * hem,
                                  ),
                                  child: HtmlWidget(
                                    campaignVoucherDetail.description,
                                    textStyle: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                        fontSize: 14 * ffem,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5 * hem),
                      ],
                    ),
                  ]),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}

Duration getDuration(String endOn) {
  DateTime dateStartOn = DateTime.parse(endOn);
  Duration duration = dateStartOn.difference(DateTime.now());
  print(DateTime.now());
  print(duration);
  print(dateStartOn);
  return duration;
}

void _detailModelBottomSheet(
    context, CampaignVoucherDetailModel campaignVoucherDetail) {
  double baseWidth = 375;
  double fem = MediaQuery.of(context).size.width / baseWidth;
  double ffem = fem * 0.97;
  double baseHeight = 812;
  double hem = MediaQuery.of(context).size.height / baseHeight;

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
          height: 500 * hem,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15 * fem),
              color: klighGreyColor),
          child: DraggableScrollableSheet(
            initialChildSize: 1,
            minChildSize: 1,
            builder: (context, scrollController) {
              return SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: 15 * hem,
                              left: 25 * fem,
                              right: 25 * fem,
                              bottom: 15 * hem),
                          child: Center(
                            child: Text(
                              'Thông tin chi tiết',
                              style: GoogleFonts.openSans(
                                fontSize: 16 * ffem,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(
                            left: 10 * fem,
                            right: 10 * fem,
                          ),
                          padding:
                              EdgeInsets.only(top: 15 * hem, bottom: 15 * hem),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10 * hem,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15 * fem),
                                child: Text(
                                  'Thể lệ ưu đãi',
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                    fontSize: 16 * ffem,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 5 * hem,
                                    left: 15 * fem,
                                    right: 15 * fem),
                                child: HtmlWidget(
                                  '${campaignVoucherDetail.condition}',
                                  textStyle: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      fontSize: 15 * ffem,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15 * hem,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15 * fem),
                                child: Text(
                                  'Nội dung ưu đãi',
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                    fontSize: 16 * ffem,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 5 * hem,
                                    left: 15 * fem,
                                    right: 15 * fem),
                                child: HtmlWidget(
                                  '${campaignVoucherDetail.description}',
                                  textStyle: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      fontSize: 15 * ffem,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
            },
          ));
    },
    isScrollControlled: true,
  );
}

Widget buildCampaignVoucherShimmer(double fem, double hem) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: Colors.white,
          child: ShimmerWidget.rectangular(height: 200 * hem),
        ),
        Container(
          margin: EdgeInsets.only(
            left: 15 * fem,
            right: 15 * fem,
            top: 20 * hem,
          ),
          child: ShimmerWidget.rectangular(height: 50 * hem),
        ),
        Container(
          color: Colors.white,
          margin: EdgeInsets.only(
            top: 20 * fem,
            left: 15 * fem,
            right: 15 * fem,
          ),
          child: ShimmerWidget.rectangular(height: 150 * hem),
        ),
        Container(
          margin: EdgeInsets.only(
            left: 15 * fem,
            right: 15 * fem,
            top: 20 * hem,
          ),
          child: ShimmerWidget.rectangular(height: 20 * hem, width: 150 * fem),
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
        ),
      ],
    ),
  );
}
