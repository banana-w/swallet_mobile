import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/blocs/challenge/challenge_bloc.dart';
import 'package:swallet_mobile/presentation/screens/student_features/challenge/components/challenge_card.dart';
import '../../../../../config/constants.dart';

class IsClaimedChallenge extends StatefulWidget {
  const IsClaimedChallenge({super.key});

  @override
  State<IsClaimedChallenge> createState() => _IsClaimedChallengeState();
}

class _IsClaimedChallengeState extends State<IsClaimedChallenge> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    return BlocListener<ChallengeBloc, ChallengeState>(
      listener: _handleBlocState,
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                _buildContent(context, fem, hem, ffem),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  void _handleBlocState(BuildContext context, ChallengeState state) {
    if (state is ChallengesLoaded) {
      Future.microtask(() {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      });
    }
  }

  Future<void> _handleRefresh() async {
    if (_isLoading) return;

    try {
      setState(() => _isLoading = true);
      await Future.microtask(() {
        if (!mounted) return;
        context.read<ChallengeBloc>().add(LoadChallenge());
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Widget _buildContent(BuildContext context, double fem, double hem, double ffem) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 15 * hem),
          BlocBuilder<ChallengeBloc, ChallengeState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              if (_isLoading || state is ChallengeLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: kPrimaryColor),
                );
              }

              if (state is ChallengesLoaded) {
                final challenges = state.challenge
                    .where((c) => c.isCompleted && c.isClaimed)
                    .toList();

                if (challenges.isEmpty) {
                  return _buildEmptyState(fem, hem);
                }

                return _buildChallengesList(
                  challenges: challenges,
                  fem: fem,
                  hem: hem,
                  ffem: ffem,
                );
              }

              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(double fem, double hem) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15 * fem),
      height: 220 * hem,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/reward-navbar-icon.svg',
            width: 60 * fem,
            colorFilter: ColorFilter.mode(kLowTextColor, BlendMode.srcIn),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              'Không có thử thách \nđã hoàn thành',
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(height: 10 * fem),
        ],
      ),
    );
  }

  Widget _buildChallengesList({
    required List challenges,
    required double fem,
    required double hem,
    required double ffem,
  }) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: challenges.length,
      itemBuilder: (context, index) {
        return ChallengeCard(
          fem: fem,
          hem: hem,
          ffem: ffem,
          challengeModel: challenges[index],
        );
      },
    );
  }
}