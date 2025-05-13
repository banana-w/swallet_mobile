import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_detail_model.dart';
import 'package:swallet_mobile/domain/entities/student_features/campaign_voucher_detail_model.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/student_repository.dart';
import 'package:swallet_mobile/presentation/blocs/student/student_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/student_features/brand_detail/brand_detail_screen.dart';
import 'package:swallet_mobile/presentation/widgets/shimmer_widget.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.campaignId, required this.voucherId});

  final String campaignId;
  final String voucherId;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    return BlocProvider(
      create:
          (context) => StudentBloc(
            studentRepository: context.read<StudentRepository>(),
          )..add(LoadVoucherItem(campaignId: campaignId, voucherId: voucherId)),
      child: BlocBuilder<StudentBloc, StudentState>(
        builder: (context, state) {
          if (state is StudentVoucherItemLoading) {
            return buildCampaignVoucherShimmer(fem, hem);
          } else if (state is StudentVoucherItemLoaded) {
            var voucher = state.voucherStudentItemModel;
            var campaign = state.campaignDetailModel;
            var voucherItemId = state.voucherItemId;
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
                            voucher.image,
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
                                'Chiến dịch: ${campaign.campaignName}',
                                textAlign: TextAlign.justify,
                                softWrap: true,
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    fontSize: 17 * ffem,
                                    color: kDarkPrimaryColor,
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
                                  voucher.voucherName,
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
                                        formatter.format((voucher.price)),
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
                                          left: 5 * fem,
                                          top: 2 * hem,
                                          bottom: 0 * hem,
                                        ),
                                        child: SvgPicture.asset(
                                          'assets/icons/coin.svg',
                                          width: 25 * fem,
                                          height: 25 * fem,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Container(
                                  //   padding: EdgeInsets.only(
                                  //     left: 10 * fem,
                                  //     right: 10 * fem,
                                  //   ),
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(10),
                                  //     color: Colors.white,
                                  //     border: Border.all(color: Colors.red),
                                  //   ),
                                  // child: Row(
                                  //   children: [
                                  //     Text(
                                  //       'x${voucherItem.price.toStringAsFixed(0)}',
                                  //       style: GoogleFonts.openSans(
                                  //         textStyle: TextStyle(
                                  //           fontSize: 18 * ffem,
                                  //           color: Colors.black,
                                  //           fontWeight: FontWeight.w600,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     Padding(
                                  //       padding: EdgeInsets.only(
                                  //         left: 5 * fem,
                                  //         top: 4 * hem,
                                  //         bottom: 0 * hem,
                                  //       ),
                                  //       child: SvgPicture.asset(
                                  //         'assets/icons/red-bean-icon.svg',
                                  //         width: 25 * fem,
                                  //         height: 25 * fem,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5 * hem),
                        Container(
                          color: Colors.white,
                          width: double.infinity,
                          padding: EdgeInsets.only(
                            left: 15 * fem,
                            top: 15 * hem,
                            bottom: 15 * hem,
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/calendar-icon.svg',
                                width: 25 * fem,
                              ),
                              SizedBox(width: 10 * fem),
                              Text(
                                'Hạn sử dụng: ${changeFormateDate(campaign.endOn)}',
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    fontSize: 15 * ffem,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5 * hem),
                        Container(
                          color: Colors.white,
                          width: double.infinity,
                          padding: EdgeInsets.only(
                            top: 15 * hem,
                            bottom: 15 * hem,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 15 * fem),
                                child: Text(
                                  'THÔNG TIN THƯƠNG HIỆU CUNG CẤP',
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      fontSize: 15 * ffem,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 5 * hem,
                                          left: 5 * fem,
                                          bottom: 5 * hem,
                                        ),
                                        padding: EdgeInsets.only(
                                          left: 15 * fem,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            10 * fem,
                                          ),
                                          child: SizedBox(
                                            width: 50 * fem,
                                            height: 50 * hem,
                                            child: Image.network(
                                              campaign.brandLogo,
                                              fit: BoxFit.fill,
                                              errorBuilder: (
                                                context,
                                                error,
                                                stackTrace,
                                              ) {
                                                return Image.asset(
                                                  'assets/images/image-404.jpg',
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10 * fem),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: 5 * hem,
                                              bottom: 5 * hem,
                                            ),
                                            child: Text(
                                              voucher.brandName.toUpperCase(),
                                              softWrap: true,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                  fontSize: 14 * ffem,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        BrandDetailScreen.routeName,
                                        arguments: voucher.brandId,
                                      );
                                    },
                                    child: Container(
                                      height: 30 * hem,
                                      margin: EdgeInsets.only(right: 15 * fem),
                                      padding: EdgeInsets.only(
                                        right: 10 * fem,
                                        left: 10 * fem,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: kLowTextColor,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Xem tất cả',
                                          style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                              fontSize: 13 * ffem,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5 * hem),
                        GestureDetector(
                          onTap: () {
                            _detailModelBottomSheet(context, voucher, campaign);
                          },
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
                                    voucher.condition,
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Xem thêm',
                                      style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                          fontSize: 14 * ffem,
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 3 * fem,
                                        top: 2 * hem,
                                      ),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5 * hem),
                        Container(
                          color: Colors.white,
                          width: double.infinity,
                          padding: EdgeInsets.only(
                            top: 15 * hem,
                            bottom: 15 * hem,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Đưa mã này để sử dụng ưu đãi',
                                    style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                        fontSize: 13 * ffem,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.arrow_drop_down_sharp, size: 30),
                                ],
                              ),
                              SizedBox(height: 5 * hem),
                              Container(
                                // color: Colors.white,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/background_splash.png',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                padding: EdgeInsets.all(20 * fem),

                                width: 300 * fem,
                                height: 300 * hem,
                                child: QrImageView(
                                  data:
                                      '${voucher.id},${state.studentId},${campaign.id},$voucherItemId', // Xem lai cai nay duoc khong
                                  padding: EdgeInsets.all(20 * fem),
                                  version: QrVersions.auto,
                                  backgroundColor: Colors.white,
                                  eyeStyle: QrEyeStyle(
                                    color: Colors.black,
                                    eyeShape: QrEyeShape.square,
                                  ),
                                  dataModuleStyle: QrDataModuleStyle(
                                    color: Colors.black,
                                    dataModuleShape: QrDataModuleShape.square,
                                  ),
                                ),
                              ),
                              SizedBox(height: 15 * hem),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              voucherItemId,
                              style: GoogleFonts.openSans(
                                fontSize: 15 * ffem,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 5),
                            IconButton(
                              onPressed: () {
                                Clipboard.setData(
                                  ClipboardData(text: voucherItemId),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Đã sao chép mã voucher'),
                                  ),
                                );
                              },
                              icon: Icon(Icons.copy, size: 20),
                              tooltip: 'Sao chép mã',
                            ),
                          ],
                        ),
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

// Duration getDuration(String endOn) {
//   DateTime dateStartOn = DateTime.parse(endOn);
//   Duration duration = dateStartOn.difference(DateTime.now());
//   print(DateTime.now());
//   print(duration);
//   print(dateStartOn);
//   return duration;
// }

void _detailModelBottomSheet(
  context,
  CampaignVoucherDetailModel voucherItem,
  CampaignDetailModel campaignDetail,
) {
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
          color: klighGreyColor,
        ),
        child: DraggableScrollableSheet(
          initialChildSize: 1,
          minChildSize: 1,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 15 * hem,
                        left: 25 * fem,
                        right: 25 * fem,
                        bottom: 15 * hem,
                      ),
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
                      margin: EdgeInsets.only(left: 10 * fem, right: 10 * fem),
                      padding: EdgeInsets.only(top: 15 * hem, bottom: 15 * hem),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10 * hem),
                          Padding(
                            padding: EdgeInsets.only(left: 15 * fem),
                            child: Text(
                              'Thời gian ưu đãi',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  fontSize: 16 * ffem,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 5 * hem,
                              left: 15 * fem,
                              right: 15 * fem,
                            ),
                            child: Text(
                              '${changeFormateDate(campaignDetail.startOn)} - ${changeFormateDate(campaignDetail.endOn)}',
                              textAlign: TextAlign.justify,
                              softWrap: true,
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  fontSize: 15 * ffem,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15 * hem),
                          Padding(
                            padding: EdgeInsets.only(left: 15 * fem),
                            child: Text(
                              'Thể lệ ưu đãi',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  fontSize: 16 * ffem,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 5 * hem,
                              left: 15 * fem,
                              right: 15 * fem,
                            ),
                            child: HtmlWidget(
                              voucherItem.condition,
                              textStyle: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  fontSize: 15 * ffem,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15 * hem),
                          Padding(
                            padding: EdgeInsets.only(left: 15 * fem),
                            child: Text(
                              'Nội dung ưu đãi',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  fontSize: 16 * ffem,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 5 * hem,
                              left: 15 * fem,
                              right: 15 * fem,
                            ),
                            child: HtmlWidget(
                              voucherItem.description,
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
              ),
            );
          },
        ),
      );
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
