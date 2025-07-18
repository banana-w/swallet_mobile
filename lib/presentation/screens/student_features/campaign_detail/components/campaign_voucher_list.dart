import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_detail_model.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/campaign_repository.dart';
import 'package:swallet_mobile/presentation/blocs/campaign_voucher/campaign_voucher_bloc.dart';
import 'package:swallet_mobile/presentation/screens/student_features/campaign_voucher/campaign_voucher_screen.dart';
import '../../../../config/constants.dart';
import '../../../../widgets/shimmer_widget.dart';

class CampaignVoucherList extends StatelessWidget {
  const CampaignVoucherList({
    super.key,
    required this.fem,
    required this.hem,
    required this.ffem,
    required this.campaignDetailModel,
    this.id, // Thêm id có thể null
  });

  final double fem;
  final double hem;
  final double ffem;
  final CampaignDetailModel campaignDetailModel;
  final String? id; // Thuộc tính mới để lọc voucher

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CampaignVoucherBloc(
          campaignRepository: context.read<CampaignRepository>())
        ..add(LoadCampaignVoucher(id: campaignDetailModel.id)),
      child: BlocBuilder<CampaignVoucherBloc, CampaignVoucherState>(
        builder: (context, state) {
          if (state is CampaignVoucherLoading) {
            return buildCampaignListShimmer(fem, hem);
          } else if (state is CampaignVouchersLoaded) {
            if (state.campaignVouchers.isEmpty) {
              return Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 15 * fem, right: 15 * fem),
                height: 220 * hem,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/voucher-navbar-icon.svg',
                      width: 60 * fem,
                      colorFilter:
                          ColorFilter.mode(kLowTextColor, BlendMode.srcIn),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          'Không có ưu đãi nào đang diễn ra!',
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10 * fem,
                    ),
                  ],
                ),
              );
            } else {
              // Lọc danh sách voucher dựa trên id
              final filteredVouchers = id == null
                  ? state.campaignVouchers
                  : state.campaignVouchers
                      .asMap()
                      .entries
                      .where((entry) => entry.value.id != id)
                      .map((entry) => entry.value)
                      .toList();

              if (filteredVouchers.isEmpty) {
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 15 * fem, right: 15 * fem),
                  height: 220 * hem,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/voucher-navbar-icon.svg',
                        width: 60 * fem,
                        colorFilter:
                            ColorFilter.mode(kLowTextColor, BlendMode.srcIn),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            'Không có ưu đãi nào khác trong chiến dịch này!',
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10 * fem,
                      ),
                    ],
                  ),
                );
              }

              return Container(
                height: 250 * hem,
                margin: EdgeInsets.only(left: 15 * fem),
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filteredVouchers.length,
                  itemBuilder: (context, index) {
                    var campaignVoucher = filteredVouchers[index];
                    return GestureDetector(
                      onTap: () async {
                        final account = await AuthenLocalDataSource.getAuthen();
                        Navigator.pushNamed(
                          context,
                          CampaignVoucherScreen.routeName,
                          arguments: <dynamic>[
                            campaignDetailModel,
                            filteredVouchers[index],
                            account?.accountId,
                          ],
                        );
                      },
                      child: Stack(
                        children: [
                          Container(
                            width: 170 * fem,
                            margin: EdgeInsets.only(right: 10 * fem),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15 * fem),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 5 * hem,
                                      right: 5 * fem,
                                      left: 5 * fem),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10 * fem),
                                        topRight: Radius.circular(10 * fem)),
                                    child: SizedBox(
                                      height: 150 * hem,
                                      width: 180 * fem,
                                      child: Image.network(
                                        campaignVoucher.image,
                                        fit: BoxFit.fill,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return ShimmerWidget.rectangular(
                                              height: 160 * hem);
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                              'assets/images/image-404.jpg');
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 10 * fem,
                                      right: 10 * fem,
                                      top: 10 * hem),
                                  child: Text(
                                    campaignVoucher.voucherName,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                      fontSize: 14 * ffem,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 10 * fem,
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 10 * fem, right: 10 * fem),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0x0c000000),
                                        offset: Offset(2 * fem, 5 * fem),
                                        blurRadius: 5 * fem)
                                  ]),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${formatter.format(campaignVoucher.price)}',
                                        style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                          fontSize: 20 * ffem,
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 2 * fem,
                                            top: 2 * hem,
                                            bottom: 0 * hem),
                                        child: SvgPicture.asset(
                                          'assets/icons/coin.svg',
                                          width: 25 * fem,
                                          height: 22 * fem,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10 * fem,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 10 * fem, right: 10 * fem),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${filteredVouchers[index].numberOfItemsAvailable}',
                                        style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                          fontSize: 14 * ffem,
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.normal,
                                        )),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(right: 5 * fem),
                                        child: Text(
                                          '/${filteredVouchers[index].numberOfItems}',
                                          style: GoogleFonts.openSans(
                                              textStyle: TextStyle(
                                            fontSize: 14 * ffem,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          }
          return Container();
        },
      ),
    );
  }
}

Widget buildCampaignListShimmer(double fem, double hem) {
  return Row(
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
  );
}
