import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/screens/screens.dart';

import '../blocs/blocs.dart';
import 'unverified_screen.dart';

class AppBarCampaign extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCampaign({
    super.key,
    required this.hem,
    required this.ffem,
    required this.fem,
  });

  final double hem;
  final double ffem;
  final double fem;

  @override
  Widget build(BuildContext context) {
    final roleState = context.read<RoleAppBloc>().state;
    return AppBar(
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_splash.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      toolbarHeight: 50 * hem,
      centerTitle: true,
      title: Text(
        'UniBean',
        style: GoogleFonts.openSans(
          textStyle: TextStyle(
            fontSize: 22 * ffem,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ),
      actions: [
        // SvgPicture.asset('assets/icons/notification-icon.svg')
        Padding(
          padding: EdgeInsets.only(right: 20 * fem),
          // child: BlocBuilder<NotificationBloc, NotificationState>(
          //   builder: (context, state) {
          //     if (state is NewNotification) {
          //       return IconButton(
          //         icon: Icon(
          //           Icons.notifications_active_rounded,
          //           color: Colors.yellow,
          //           size: 25 * fem,
          //         ),
          //         onPressed: () {
          //           if (roleState is Unverified) {
          //             Navigator.pushNamed(context, UnverifiedScreen.routeName);
          //           } else if (roleState is StoreRole) {
          //           } else {
          //             context.read<NotificationBloc>().add(LoadNotification());
          //             Navigator.pushNamed(
          //                 context, NotificationListScreen.routeName);
          //           }
          //         },
          //       );
          //     }
          //     return IconButton(
          //       icon: Icon(
          //         Icons.notifications,
          //         color: Colors.white,
          //         size: 25 * fem,
          //       ),
          //       onPressed: () {
          //         if (roleState is Unverified) {
          //           Navigator.pushNamed(context, UnverifiedScreen.routeName);
          //         } else if (roleState is StoreRole) {
          //         } else {
          //           Navigator.pushNamed(
          //               context, NotificationListScreen.routeName);
          //         }
          //       },
          //     );
          //   },
          // ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
