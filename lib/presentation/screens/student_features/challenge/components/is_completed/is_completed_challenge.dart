import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:swallet_mobile/presentation/blocs/challenge/challenge_bloc.dart';
import 'package:swallet_mobile/presentation/screens/student_features/challenge/components/challenge_card.dart';

import '../../../../../config/constants.dart';

class IsCompletedChallenge extends StatelessWidget {
  const IsCompletedChallenge({super.key});

  @override
  Widget build(BuildContext context) {
    // Cache MediaQuery values
    final size = MediaQuery.of(context).size;
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    return BlocListener<ChallengeBloc, ChallengeState>(
      listener: (context, state) {
        if (state is ClaimLoading) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            showDialog<String>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return PopScope(
                  canPop: false,
                  child: AlertDialog(
                    content: const SizedBox(
                      width: 100,
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(color: kPrimaryColor),
                      ),
                    ),
                  ),
                );
              },
            );
          });
        } else if (state is ChallengesLoaded && state.isClaimed) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          
          SchedulerBinding.instance.addPostFrameCallback((_) {
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
          });
        }
      },
      child: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration.zero);
          if (!context.mounted) return;
          context.read<ChallengeBloc>().add(LoadChallenge());
        },
        child: CustomScrollView(
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
              if (state is ChallengeLoading) {
                return Center(
                  child: Lottie.asset('assets/animations/loading-screen.dart'),
                );
              }
              
              if (state is ChallengesLoaded) {
                final challenges = state.challenge
                    .where((c) => (c.isCompleted && !c.isClaimed))
                    .toList();

                if (challenges.isEmpty) {
                  return _buildEmptyState(fem, hem);
                }

                return _buildChallengesList(challenges, fem, hem, ffem);
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

  Widget _buildChallengesList(
    List challenges,
    double fem,
    double hem,
    double ffem,
  ) {
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
