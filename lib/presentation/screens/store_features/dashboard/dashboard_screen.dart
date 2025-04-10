import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:swallet_mobile/data/models/store_features/campagin_ranking_model.dart';
import 'package:swallet_mobile/domain/interface_repositories/store_features/store_repository.dart';
import 'package:swallet_mobile/presentation/blocs/ranking/ranking_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RankingBloc, RankingState>(
      builder: (context, state) {
        if (state is CampaignRankingLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<RankingBloc>().add(LoadCampaignRanking());
            },
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    SizedBox(height: 20),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BlocProvider(
                            create:
                                (context) => RankingBloc(
                                  storeRepository:
                                      context.read<StoreRepository>(),
                                )..add(LoadStudentRanking()),
                            child: BlocBuilder<RankingBloc, RankingState>(
                              builder: (context, stateStudent) {
                                if (stateStudent is StudentRankingLoaded) {
                                  if (stateStudent.studentRankings.isEmpty) {
                                    return Column(
                                      children: [
                                        Text(
                                          'BẢNG XẾP HẠNG SINH VIÊN',
                                          style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Card(
                                          color: kbgYellow,
                                          child: Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'SỐ LƯỢNG SINH VIÊN: ${stateStudent.studentRankings.length}',
                                                      style:
                                                          GoogleFonts.openSans(
                                                            textStyle:
                                                                TextStyle(
                                                                  fontSize: 15,
                                                                  color:
                                                                      kYellow,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 8.0),
                                                Text(
                                                  'Không có sinh viên nào \nđang tham gia',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.openSans(
                                                    textStyle: TextStyle(
                                                      fontSize: 15,
                                                      color: kYellow,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Column(
                                      children: [
                                        Text(
                                          'BẢNG XẾP HẠNG SINH VIÊN',
                                          style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Card(
                                          color: kbgYellow,
                                          child: Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'SỐ LƯỢNG SINH VIÊN: ${stateStudent.studentRankings.length}',
                                                      style:
                                                          GoogleFonts.openSans(
                                                            textStyle:
                                                                TextStyle(
                                                                  fontSize: 15,
                                                                  color:
                                                                      kYellow,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 8.0),
                                                ListView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      stateStudent
                                                          .studentRankings
                                                          .length,
                                                  itemBuilder: (
                                                    context,
                                                    index,
                                                  ) {
                                                    var studentRanking =
                                                        stateStudent
                                                            .studentRankings[index];
                                                    return Container(
                                                      margin: EdgeInsets.only(
                                                        bottom: 10,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              Icon(
                                                                Icons.star,
                                                                color: kYellow,
                                                                size: 40,
                                                              ),
                                                              Positioned.fill(
                                                                top: 12,
                                                                child: Text(
                                                                  '${studentRanking.rank}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: GoogleFonts.openSans(
                                                                    textStyle: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color:
                                                                          Colors
                                                                              .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  50,
                                                                ),
                                                            child: Image.network(
                                                              '${studentRanking.image}',
                                                              // 'assets/images/ava_signup.png',
                                                              width: 55,
                                                              height: 55,
                                                              fit: BoxFit.fill,
                                                              errorBuilder: (
                                                                context,
                                                                error,
                                                                stackTrace,
                                                              ) {
                                                                return Image.asset(
                                                                  'assets/images/ava_signup.png',
                                                                  width: 55,
                                                                  height: 55,
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        30,
                                                                      ),
                                                                  color:
                                                                      kYellow,
                                                                ),
                                                            width: 200,
                                                            height: 45,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Text(
                                                                  '${studentRanking.name}',
                                                                  style: GoogleFonts.openSans(
                                                                    textStyle: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color:
                                                                          Colors
                                                                              .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      '${formatter.format(studentRanking.value)}',
                                                                      style: GoogleFonts.openSans(
                                                                        textStyle: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.white,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                        left: 2,
                                                                        top: 4,
                                                                        bottom:
                                                                            2,
                                                                      ),
                                                                      child: SvgPicture.asset(
                                                                        'assets/icons/coin.svg',
                                                                        width:
                                                                            24,
                                                                        height:
                                                                            22,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                }

                                return Container(
                                  child: Center(
                                    child: Lottie.asset(
                                      'assets/animations/loading-screen.json',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 25),
                          Column(
                            children: [
                              Text(
                                'BẢNG XẾP HẠNG CHIẾN DỊCH',
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Card(
                                color: Color(0xffff6ffed),
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 10,
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'SỐ LƯỢNG CHIẾN DỊCH \nTRONG THƯƠNG HIỆU: ${state.campaignRankings.length}',
                                            style: GoogleFonts.openSans(
                                              textStyle: TextStyle(
                                                fontSize: 15,
                                                color: kPrimaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8.0),
                                      SfCartesianChart(
                                        primaryXAxis: CategoryAxis(
                                          labelStyle: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                              fontSize: 12,
                                              color: kPrimaryColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          maximumLabelWidth: 50,
                                        ),
                                        primaryYAxis: NumericAxis(
                                          labelStyle: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                              fontSize: 12,
                                              color: kPrimaryColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        tooltipBehavior: _tooltip,
                                        series: <
                                          CartesianSeries<
                                            CampaignRankingModel,
                                            String
                                          >
                                        >[
                                          BarSeries<
                                            CampaignRankingModel,
                                            String
                                          >(
                                            dataSource: state.campaignRankings,
                                            xValueMapper:
                                                (
                                                  CampaignRankingModel data,
                                                  _,
                                                ) => data.name,
                                            yValueMapper:
                                                (
                                                  CampaignRankingModel data,
                                                  _,
                                                ) => data.value,
                                            name: 'Chiến dịch',
                                            color: kPrimaryColor,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 25),
                        ],
                      ),
                    ),
                    SizedBox(height: 150),
                  ]),
                ),
              ],
            ),
          );
        } else if (state is CampaignRankingLoading) {
          return Container(
            child: Center(
              child: Lottie.asset('assets/animations/loading-screen.json'),
            ),
          );
        }
        return Container(child: Center(child: Text('Đã xảy ra lỗi!')));
      },
    );
  }
}

class SparkbarChart extends StatelessWidget {
  const SparkbarChart({super.key, required this.campaignRankings});
  final List<CampaignRankingModel> campaignRankings;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 200,
      child: SfSparkBarChart.custom(
        dataCount: campaignRankings.length,
        xValueMapper:
            (int index) => campaignRankings[index].name, // x-axis value mapper
        yValueMapper:
            (int index) => campaignRankings[index].value, // y-axis value mapper
        axisLineWidth: 1,
        axisLineColor: Colors.white,
        color: Colors.white,
        labelDisplayMode: SparkChartLabelDisplayMode.all,
        trackball: SparkChartTrackball(
          activationMode: SparkChartActivationMode.tap,
          width: 1,
          labelStyle: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          borderWidth: 1,
        ),
      ),
    );
  }
}

String shortenName(String fullName) {
  const maxLength = 10;

  if (fullName.length > maxLength) {
    return fullName.substring(0, maxLength);
  } else {
    return fullName;
  }
}
