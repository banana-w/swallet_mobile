import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
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
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    return BlocListener<ChallengeBloc, ChallengeState>(
      listener: (context, state) {
        if (state is ChallengesLoaded) {
          if (state.isClaimed) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                elevation: 0,
                duration: const Duration(milliseconds: 2000),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Nhận thưởng',
                  message: 'Nhận thưởng thành công!',
                  contentType: ContentType.success,
                ),
              ));
          }
        } else if (state is ClaimLoading) {
          showDialog<String>(
              context: context,
              builder: (BuildContext context) {
                Future.delayed(Duration(seconds: 5));
                return AlertDialog(
                    content: Container(
                        width: 250,
                        height: 250,
                        child: Center(
                            child: CircularProgressIndicator(
                                color: kPrimaryColor))));
              });
        }
      },
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<ChallengeBloc>().add(LoadChallenge());
        },
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 15 * hem,
                      ),
                      BlocBuilder<ChallengeBloc, ChallengeState>(
                        builder: (context, state) {
                          if (state is ChallengeLoading) {
                            return Center(
                              child: Lottie.asset(
                                  'assets/animations/loading-screen.dart'),
                            );
                          } else if (state is ChallengesLoaded) {
                            final challenges = state.challenge
                                .where((c) =>
                                    (c.isCompleted && c.isClaimed == false))
                                .toList();
                            if (challenges.isEmpty) {
                              return Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                    left: 15 * fem, right: 15 * fem),
                                height: 220 * hem,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/reward-navbar-icon.svg',
                                      width: 60 * fem,
                                      colorFilter: ColorFilter.mode(
                                          kLowTextColor, BlendMode.srcIn),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 5),
                                        child: Text(
                                          'Hoàn thành thử thách \nđể nhận thưởng',
                                          textAlign: TextAlign.center,
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
                              return Column(
                                children: [
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
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
                                  ),
                                ],
                              );
                            }
                          }
                          return Container();
                        },
                      ),
                    ],
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
