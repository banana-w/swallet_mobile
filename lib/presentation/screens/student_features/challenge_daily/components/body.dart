import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/screens/student_features/challenge_shared/challenge_claim_listener.dart';
import 'package:swallet_mobile/presentation/screens/student_features/challenge_shared/challenge_mode.dart';
import 'package:swallet_mobile/presentation/screens/student_features/challenge_shared/challenge_tab_bar.dart';
import 'package:swallet_mobile/presentation/screens/student_features/challenge_shared/challenge_tab_list.dart';
import 'package:swallet_mobile/presentation/widgets/internet_listener.dart';

const _mode = ChallengeMode.daily;

class ChallengeDailyBody extends StatelessWidget {
  const ChallengeDailyBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    return InternetListener(
      child: ChallengeClaimListener(
        mode: _mode,
        child: NestedScrollView(
          headerSliverBuilder:
              (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  elevation: 0,
                  iconTheme: const IconThemeData(color: Colors.white),
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/background_splash.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  toolbarHeight: 40 * hem,
                  centerTitle: true,
                  title: Padding(
                    padding: EdgeInsets.only(top: 10 * hem),
                    child: Text(
                      'Nhiệm vụ ngày',
                      style: GoogleFonts.openSans(
                        fontSize: 22 * ffem,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(top: 5 * fem, right: 20 * fem),
                      child: ChallengeNotificationButton(fem: fem),
                    ),
                  ],
                  bottom: ChallengeTabBar(fem: fem, ffem: ffem),
                ),
              ],
          body: const TabBarView(
            children: [
              ChallengeTabList(kind: ChallengeTabKind.inProcess, mode: _mode),
              ChallengeTabList(kind: ChallengeTabKind.claimable, mode: _mode),
              ChallengeTabList(kind: ChallengeTabKind.claimed, mode: _mode),
            ],
          ),
        ),
      ),
    );
  }
}
