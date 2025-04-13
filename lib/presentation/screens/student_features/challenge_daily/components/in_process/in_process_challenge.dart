import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/challenge/challenge_bloc.dart';
import 'package:swallet_mobile/presentation/widgets/empty_widget.dart';
import '../../../../../config/constants.dart';
import '../challenge_card.dart';

class InProcessChallenge extends StatelessWidget {
  const InProcessChallenge({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;

    return BlocListener<ChallengeBloc, ChallengeState>(
      listener: (context, state) {
        if (state is ClaimLoading) {
          // Sử dụng addPostFrameCallback để tránh build trong frame hiện tại
          SchedulerBinding.instance.addPostFrameCallback((_) {
            showDialog<String>(
              context: context,
              barrierDismissible: false, // Prevent dialog from being dismissed
              builder: (BuildContext context) {
                return PopScope(
                  canPop:
                      false, // Prevent back button/gesture from closing dialog
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
          // Đóng dialog loading nếu đang mở
          Navigator.of(context).pop();

          // Show success message
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
          context.read<ChallengeBloc>().add(LoadDailyChallenge());
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
                      BlocBuilder<ChallengeBloc, ChallengeState>(
                        builder: (context, state) {
                          if (state is ChallengeLoading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: kPrimaryColor,
                              ),
                            );
                          } else if (state is ChallengesLoaded) {
                            final challenges =
                                state.challenge
                                    .where((c) => !c.isClaimed)
                                    .toList()
                                  ..sort((a, b) {
                                    if (a.isClaimed != b.isClaimed) {
                                      return a.isClaimed ? 1 : -1;
                                    }
                                    return b.isCompleted ? 1 : -1;
                                  });

                            if (challenges.isEmpty) {
                              return const EmptyWidget(
                                text: 'Không có thử thách',
                              );
                            }

                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: challenges.length,
                              itemBuilder:
                                  (context, index) => ChallengeCard(
                                    fem: fem,
                                    hem: hem,
                                    ffem: ffem,
                                    challengeModel: challenges[index],
                                  ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
