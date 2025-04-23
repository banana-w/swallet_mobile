import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lottie/lottie.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/presentation/screens/student_features/campaign_detail/campaign_detail_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/profile_history/profile_trans_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/voucher_history/voucher_history.dart';
import 'package:swallet_mobile/presentation/widgets/app_bar_campaign.dart';

class NotificationScreen extends StatefulWidget {
  static const String routeName = '/notification-student';

  static Route route({required dynamic data}) {
    return MaterialPageRoute(
      builder: (_) => NotificationScreen(data: data),
      settings: RouteSettings(arguments: data), // Pass data as arguments
    );
  }

  const NotificationScreen({super.key, required this.data});
  final dynamic data;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Map payload = {};
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigateToCampaignDetailScreen();
    });
  }

  Future<void> navigateToCampaignDetailScreen() async {
    if (widget.data is RemoteMessage) {
      payload = widget.data.data;
    } else if (widget.data is NotificationResponse) {
      payload = jsonDecode(widget.data.payload!);
    }

    if (payload.containsKey('campaignId')) {
      if (payload['campaignId'] == null || payload['campaignId'].isEmpty) {
        final student = await AuthenLocalDataSource.getStudent();

        Navigator.of(context).pushNamedAndRemoveUntil(
          VoucherHistoryScreen.routeName,
          arguments: student!.id,
          (Route<dynamic> route) => false,
        );
      } else {
        Navigator.of(context).pushNamed(
          CampaignDetailStudentScreen.routeName,
          arguments: payload['campaignId'],
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double baseHeight = 812;
    double ffem = fem * 0.97;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    return Scaffold(
      appBar: AppBarCampaign(hem: hem, ffem: ffem, fem: fem),
      body: Center(
        child: Lottie.asset('assets/animations/loading-screen.json'),
      ),
    );
  }
}
