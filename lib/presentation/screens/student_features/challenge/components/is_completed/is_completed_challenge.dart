import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/blocs/challenge/challenge_bloc.dart';
import 'package:swallet_mobile/presentation/screens/student_features/challenge/components/challenge_card.dart';

import '../../../../../config/constants.dart';

class IsCompletedChallenge extends StatefulWidget {
  const IsCompletedChallenge({super.key});

  @override
  State<IsCompletedChallenge> createState() => _IsCompletedChallengeState();
}

class _IsCompletedChallengeState extends State<IsCompletedChallenge> {
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
    if (state is ClaimAchieveLoading) {
      Future.microtask(() => _showLoadingDialog(context));
    } else if (state is ChallengesAchieveLoaded && state.isClaimed) {
      _hideLoadingDialog(context);
      Future.microtask(() {
        _showSuccessMessage(context);
        if (mounted) {
          context.read<ChallengeBloc>().add(LoadChallenge());
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
      await Future.delayed(const Duration(milliseconds: 500));
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
                return _buildLoadedContent(state, fem, hem, ffem);
              }
              
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedContent(ChallengesLoaded state, double fem, double hem, double ffem) {
    final challenges = state.challenge
        .where((c) => c.isCompleted && !c.isClaimed)
        .toList();

    if (challenges.isEmpty) {
      return _buildEmptyState(fem, hem);
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: challenges.length,
      itemBuilder: (context, index) => ChallengeCard(
        fem: fem,
        hem: hem,
        ffem: ffem,
        challengeModel: challenges[index],
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/reward-navbar-icon.svg',
            width: 60 * fem,
            colorFilter: const ColorFilter.mode(kLowTextColor, BlendMode.srcIn),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              'Hoàn thành thử thách \nđể nhận thưởng',
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

  void _showLoadingDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => PopScope(
        canPop: false,
        child: const AlertDialog(
          content: SizedBox(
            width: 100,
            height: 100,
            child: Center(
              child: CircularProgressIndicator(color: kPrimaryColor),
            ),
          ),
        ),
      ),
    );
  }

  void _hideLoadingDialog(BuildContext context) {
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void _showSuccessMessage(BuildContext context) {
    if (!mounted) return;
    
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          elevation: 0,
          duration: const Duration(milliseconds: 2000),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Nhận thưởng',
            message: 'Nhận thưởng thành công!',
            contentType: ContentType.success,
          ),
        ),
      );
  }
}