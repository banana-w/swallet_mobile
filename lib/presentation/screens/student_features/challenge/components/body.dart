import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/screens/student_features/challenge_daily/challenge_daily_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/challenge_shared/challenge_claim_listener.dart';
import 'package:swallet_mobile/presentation/screens/student_features/challenge_shared/challenge_mode.dart';
import 'package:swallet_mobile/presentation/screens/student_features/challenge_shared/challenge_tab_bar.dart';
import 'package:swallet_mobile/presentation/screens/student_features/challenge_shared/challenge_tab_list.dart';
import 'package:swallet_mobile/presentation/widgets/internet_listener.dart';
import 'package:swallet_mobile/presentation/widgets/unverified_screen.dart';

const _mode = ChallengeMode.achievement;

class ChallengeBody extends StatelessWidget {
  const ChallengeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    return InternetListener(
      child: ChallengeClaimListener(
        mode: _mode,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background_splash.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 40 * hem,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20 * fem),
                          child: _DailyChallengeButton(fem: fem),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10 * hem),
                          child: Text(
                            'Swallet',
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                fontSize: 22 * ffem,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 5 * fem,
                            right: 20 * fem,
                          ),
                          child: ChallengeNotificationButton(fem: fem),
                        ),
                      ],
                    ),
                  ),
                  ChallengeTabBar(fem: fem, ffem: ffem),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  ChallengeTabList(
                    kind: ChallengeTabKind.inProcess,
                    mode: _mode,
                  ),
                  ChallengeTabList(
                    kind: ChallengeTabKind.claimable,
                    mode: _mode,
                  ),
                  ChallengeTabList(kind: ChallengeTabKind.claimed, mode: _mode),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Nút mở màn nhiệm vụ ngày.
class _DailyChallengeButton extends StatelessWidget {
  const _DailyChallengeButton({required this.fem});

  final double fem;

  @override
  Widget build(BuildContext context) {
    // Trước đây đọc roleState một lần bằng `context.read` ở đầu `build` của
    // cả màn hình, nên nút giữ nguyên trạng thái cũ khi vai trò đổi.
    final roleState = context.watch<RoleAppBloc>().state;

    return IconButton(
      icon: Icon(Icons.task, color: Colors.white, size: 25 * fem),
      onPressed:
          () => Navigator.pushNamed(
            context,
            roleState is Unverified
                ? UnverifiedScreen.routeName
                : ChallengeDailyScreen.routeName,
          ),
    );
  }
}
