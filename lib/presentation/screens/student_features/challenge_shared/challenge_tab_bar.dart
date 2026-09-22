import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/blocs/challenge/challenge_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/notification/notification_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/screens/student_features/notification/notification_list_screen.dart';
import 'package:swallet_mobile/presentation/widgets/unverified_screen.dart';

import 'challenge_mode.dart';

/// Thanh tab của màn thử thách, kèm chấm đỏ báo có thưởng chưa nhận.
class ChallengeTabBar extends StatelessWidget implements PreferredSizeWidget {
  const ChallengeTabBar({super.key, required this.fem, required this.ffem});

  final double fem;
  final double ffem;

  @override
  Size get preferredSize => const Size.fromHeight(kTextTabBarHeight);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: 3,
      labelColor: Colors.white,
      labelStyle: GoogleFonts.openSans(
        textStyle: TextStyle(
          fontSize: 12 * ffem,
          height: 1.3625 * ffem / fem,
          fontWeight: FontWeight.w700,
        ),
      ),
      unselectedLabelColor: Colors.white60,
      unselectedLabelStyle: GoogleFonts.openSans(
        textStyle: TextStyle(fontSize: 12 * ffem, fontWeight: FontWeight.w700),
      ),
      tabs: const [
        Tab(text: 'Đang thực hiện'),
        _ClaimableTab(),
        Tab(text: 'Đã hoàn thành'),
      ],
    );
  }
}

/// Tab "Nhận thưởng" kèm chấm đỏ khi còn thử thách chưa nhận thưởng.
class _ClaimableTab extends StatelessWidget {
  const _ClaimableTab();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChallengeBloc, ChallengeState>(
      builder: (context, state) {
        final loaded = challengesOf(state);
        final hasUnclaimed =
            loaded?.items.any((c) => c.isCompleted && !c.isClaimed) ?? false;

        if (!hasUnclaimed) return const Tab(text: 'Nhận thưởng');

        return Stack(
          children: [
            const Tab(text: 'Nhận thưởng'),
            Positioned(
              top: 10,
              right: 0,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Nút chuông thông báo, đổi màu khi có thông báo mới.
///
/// Bản ở `challenge/` trước đây viết ba `IconButton` gần như giống hệt nhau
/// cho hai nhánh trạng thái.
class ChallengeNotificationButton extends StatelessWidget {
  const ChallengeNotificationButton({super.key, required this.fem});

  final double fem;

  @override
  Widget build(BuildContext context) {
    final roleState = context.watch<RoleAppBloc>().state;

    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        final hasNew = state is NewNotification;
        return IconButton(
          icon: Icon(
            hasNew ? Icons.notifications_active_rounded : Icons.notifications,
            color: hasNew ? Colors.yellow : Colors.white,
            size: 25 * fem,
          ),
          onPressed: () {
            if (roleState is Unverified) {
              Navigator.pushNamed(context, UnverifiedScreen.routeName);
              return;
            }
            if (hasNew) {
              context.read<NotificationBloc>().add(LoadNotification());
            }
            Navigator.pushNamed(context, NotificationListScreen.routeName);
          },
        );
      },
    );
  }
}
