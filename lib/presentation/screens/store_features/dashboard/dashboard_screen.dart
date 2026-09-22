import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:swallet_mobile/data/interface_repositories/store_features/store_repository.dart';
import 'package:swallet_mobile/data/models/store_features/campagin_ranking_model.dart';
import 'package:swallet_mobile/data/models/student_features/student_ranking_model.dart';
import 'package:swallet_mobile/presentation/blocs/ranking/ranking_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final TooltipBehavior _tooltip;

  @override
  void initState() {
    super.initState();
    _tooltip = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RankingBloc, RankingState>(
      builder: (context, state) {
        if (state is CampaignRankingLoading) {
          return Center(
            child: Lottie.asset('assets/animations/loading-screen.json'),
          );
        }
        if (state is! CampaignRankingLoaded) {
          return const Center(child: Text('Đã xảy ra lỗi!'));
        }

        return RefreshIndicator(
          onRefresh: () async {
            context.read<RankingBloc>().add(LoadCampaignRanking());
          },
          child: ListView(
            padding: const EdgeInsets.only(top: 20, bottom: 150),
            children: [
              BlocProvider(
                create:
                    (context) => RankingBloc(
                      storeRepository: context.read<StoreRepository>(),
                    )..add(LoadStudentRanking()),
                child: const _StudentRankingCard(),
              ),
              const SizedBox(height: 25),
              _CampaignRankingCard(
                campaignRankings: state.campaignRankings,
                tooltip: _tooltip,
              ),
              const SizedBox(height: 25),
            ],
          ),
        );
      },
    );
  }
}

/// Bảng xếp hạng sinh viên; dùng bloc riêng nên tải độc lập với phần chiến dịch.
class _StudentRankingCard extends StatelessWidget {
  const _StudentRankingCard();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RankingBloc, RankingState>(
      builder: (context, state) {
        if (state is! StudentRankingLoaded) {
          return Center(
            child: Lottie.asset('assets/animations/loading-screen.json'),
          );
        }

        final rankings = state.studentRankings;

        return Column(
          children: [
            Text(
              'BẢNG XẾP HẠNG SINH VIÊN',
              style: GoogleFonts.openSans(
                textStyle: const TextStyle(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SỐ LƯỢNG SINH VIÊN: ${rankings.length}',
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          color: kYellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    if (rankings.isEmpty)
                      Center(
                        child: Text(
                          'Không có sinh viên nào \nđang tham gia',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                              fontSize: 15,
                              color: kYellow,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      )
                    else
                      for (final ranking in rankings)
                        _StudentRankingRow(ranking: ranking),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StudentRankingRow extends StatelessWidget {
  const _StudentRankingRow({required this.ranking});

  final StudentRankingModel ranking;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Stack(
            children: [
              const Icon(Icons.star, color: kYellow, size: 40),
              Positioned.fill(
                top: 12,
                child: Text(
                  '${ranking.rank}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              ranking.image,
              width: 55,
              height: 55,
              fit: BoxFit.fill,
              // Ảnh chỉ 55x55, không cần giải mã bản gốc.
              cacheWidth: (55 * MediaQuery.devicePixelRatioOf(context)).round(),
              errorBuilder:
                  (context, error, stackTrace) => Image.asset(
                    'assets/images/ava_signup.png',
                    width: 55,
                    height: 55,
                  ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: kYellow,
            ),
            width: 200,
            height: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  ranking.name,
                  style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      formatter.format(ranking.value),
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2, top: 4, bottom: 2),
                      child: SvgPicture.asset(
                        'assets/icons/coin.svg',
                        width: 24,
                        height: 22,
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
  }
}

/// Biểu đồ cột xếp hạng các chiến dịch trong thương hiệu.
class _CampaignRankingCard extends StatelessWidget {
  const _CampaignRankingCard({
    required this.campaignRankings,
    required this.tooltip,
  });

  final List<CampaignRankingModel> campaignRankings;
  final TooltipBehavior tooltip;

  @override
  Widget build(BuildContext context) {
    final axisLabelStyle = GoogleFonts.openSans(
      textStyle: const TextStyle(
        fontSize: 12,
        color: kPrimaryColor,
        fontWeight: FontWeight.w500,
      ),
    );

    return Column(
      children: [
        Text(
          'BẢNG XẾP HẠNG CHIẾN DỊCH',
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Card(
          color: const Color(0xfff6ffed),
          child: Container(
            width: MediaQuery.sizeOf(context).width - 10,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SỐ LƯỢNG CHIẾN DỊCH \nTRONG THƯƠNG HIỆU: '
                  '${campaignRankings.length}',
                  style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                      fontSize: 15,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    labelStyle: axisLabelStyle,
                    maximumLabelWidth: 50,
                  ),
                  primaryYAxis: NumericAxis(labelStyle: axisLabelStyle),
                  tooltipBehavior: tooltip,
                  series: <CartesianSeries<CampaignRankingModel, String>>[
                    BarSeries<CampaignRankingModel, String>(
                      dataSource: campaignRankings,
                      xValueMapper: (data, _) => data.name,
                      yValueMapper: (data, _) => data.value,
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
    );
  }
}
