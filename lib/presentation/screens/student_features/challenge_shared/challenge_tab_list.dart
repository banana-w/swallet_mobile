import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/models/student_features/challenge_model.dart';
import 'package:swallet_mobile/presentation/blocs/challenge/challenge_bloc.dart';
import 'package:swallet_mobile/presentation/widgets/empty_widget.dart';

import '../../../config/constants.dart';
import 'challenge_card.dart';
import 'challenge_mode.dart';

/// Ba tab của màn thử thách chỉ khác nhau ở bộ lọc và phần hiển thị khi rỗng.
enum ChallengeTabKind {
  /// Đang thực hiện: mọi thử thách chưa nhận thưởng.
  inProcess,

  /// Nhận thưởng: đã hoàn thành nhưng chưa nhận.
  claimable,

  /// Đã hoàn thành: đã nhận thưởng.
  claimed,
}

/// Danh sách thử thách của một tab.
///
/// Trước đây mỗi tab là một file riêng, và mỗi file lại được nhân đôi cho
/// `challenge/` và `challenge_daily/` — sáu file cho ba danh sách gần như
/// giống hệt nhau.
class ChallengeTabList extends StatelessWidget {
  const ChallengeTabList({super.key, required this.kind, required this.mode});

  final ChallengeTabKind kind;
  final ChallengeMode mode;

  List<ChallengeModel> _filter(List<ChallengeModel> all) {
    switch (kind) {
      case ChallengeTabKind.inProcess:
        // Điều kiện cũ `!isCompleted || (isCompleted && !isClaimed)` rút gọn
        // đúng thành `!isClaimed`; đưa cái đã hoàn thành lên đầu.
        return all.where((c) => !c.isClaimed).toList()..sort((a, b) {
          if (a.isCompleted == b.isCompleted) return 0;
          return a.isCompleted ? -1 : 1;
        });
      case ChallengeTabKind.claimable:
        return all.where((c) => c.isCompleted && !c.isClaimed).toList();
      case ChallengeTabKind.claimed:
        return all.where((c) => c.isCompleted && c.isClaimed).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<ChallengeBloc>().add(mode.reloadEvent);
        // Đợi bloc phát xong trạng thái mới rồi mới thu vòng xoay lại.
        // orElse cần thiết vì rời màn hình giữa chừng sẽ đóng bloc, và
        // firstWhere trên một stream đã đóng mà không khớp sẽ ném StateError.
        await context.read<ChallengeBloc>().stream.firstWhere(
          (state) => state is! ChallengeLoading,
          orElse: () => ChallengeInitial(),
        );
      },
      // Trước đây là CustomScrollView > SliverList > SliverChildListDelegate
      // bọc đúng một widget con.
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          width: size.width,
          child: BlocBuilder<ChallengeBloc, ChallengeState>(
            builder: (context, state) {
              if (state is ChallengeLoading) {
                return Padding(
                  padding: EdgeInsets.only(top: 40 * hem),
                  child: const Center(
                    child: CircularProgressIndicator(color: kPrimaryColor),
                  ),
                );
              }

              final loaded = challengesOf(state);
              if (loaded == null) return const SizedBox();

              final challenges = _filter(loaded.items);
              if (challenges.isEmpty) {
                return Padding(
                  padding: EdgeInsets.only(top: 15 * hem),
                  child: _emptyState(fem, hem),
                );
              }

              final isClaiming = mode.isClaiming(state);
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.only(
                  top: kind == ChallengeTabKind.inProcess ? 0 : 15 * hem,
                ),
                itemCount: challenges.length,
                itemBuilder:
                    (context, index) => ChallengeCard(
                      fem: fem,
                      hem: hem,
                      ffem: ffem,
                      mode: mode,
                      isClaiming: isClaiming,
                      challengeModel: challenges[index],
                    ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _emptyState(double fem, double hem) {
    if (kind == ChallengeTabKind.inProcess) {
      return EmptyWidget(text: mode.emptyInProcessText);
    }

    final text =
        kind == ChallengeTabKind.claimable
            ? 'Hoàn thành thử thách \nđể nhận thưởng'
            : 'Không có thử thách \nđã hoàn thành';

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
            colorFilter: const ColorFilter.mode(kLowTextColor, BlendMode.srcIn),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              text,
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
}
