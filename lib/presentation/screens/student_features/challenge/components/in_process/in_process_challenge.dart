import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/challenge/challenge_bloc.dart';
import 'package:swallet_mobile/presentation/widgets/empty_widget.dart';
import '../../../../../config/constants.dart';
import '../challenge_card.dart';

class InProcessChallenge extends StatefulWidget {
  const InProcessChallenge({super.key});

  @override
  State<InProcessChallenge> createState() => _InProcessChallengeState();
}

class _InProcessChallengeState extends State<InProcessChallenge> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // Cache MediaQuery values once
    final size = MediaQuery.of(context).size;
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    return BlocListener<ChallengeBloc, ChallengeState>(
      listener: (context, state) {
        if (state is ClaimAchieveLoading) {
          _showLoadingDialog(context);
        } else if (state is ChallengesAchieveLoaded && state.isClaimed) {
          _hideLoadingDialog(context);
          _showSuccessMessage(context);
          
          SchedulerBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              context.read<ChallengeBloc>().add(LoadChallenge());//challenge
            }
          });
        }
      },
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          if (_isLoading) return;
          
          try {
            await Future.sync(() { 
              context.read<ChallengeBloc>().add(LoadChallenge());
            });
            await Future.delayed(const Duration(milliseconds: 500));
          } finally {
            if (mounted) {
              setState(() => _isLoading = false);
            }
          }
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  width: size.width,
                  child: BlocBuilder<ChallengeBloc, ChallengeState>(
                    buildWhen: (previous, current) => previous != current,
                    builder: (context, state) {
                      if (_isLoading || state is ChallengeLoading) {
                        return const Center(
                          child: CircularProgressIndicator(color: kPrimaryColor),
                        );
                      }
                      
                      if (state is ChallengesLoaded) {
                        return _buildChallengesList(state, fem, hem, ffem);
                      }
                      
                      return const SizedBox();
                    },
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChallengesList(ChallengesLoaded state, double fem, double hem, double ffem) {
  // Có thể sử dụng ChallengesAchieveLoaded hoặc ChallengesLoaded
  final challenges = state.challenge
      .where((c) => !c.isCompleted || (c.isCompleted && !c.isClaimed))
      .toList()
    ..sort((a, b) {
      if (a.isCompleted != b.isCompleted) {
        return a.isCompleted ? -1 : 1; // Đã hoàn thành lên đầu
      }
      return 0;
    });

  if (challenges.isEmpty) {
    return const EmptyWidget(text: 'Không có thành tựu nào!');
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

  void _showLoadingDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
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
        );
      },
    );
  }

  void _hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _showSuccessMessage(BuildContext context) {
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
