import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/lecture_features/qr_history/components/body.dart';
import 'package:swallet_mobile/presentation/widgets/app_bar_campaign.dart';

class QRCodeHistoryScreen extends StatefulWidget {
  const QRCodeHistoryScreen({Key? key}) : super(key: key);

  @override
  _QRCodeHistoryScreenState createState() => _QRCodeHistoryScreenState();
}

class _QRCodeHistoryScreenState extends State<QRCodeHistoryScreen> {
  String? lectureId;

  @override
  void initState() {
    super.initState();
    _getLectureId();
  }

  Future<void> _getLectureId() async {
    final lecture = await AuthenLocalDataSource.getLecture();
    setState(() {
      lectureId = lecture?.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    return Scaffold(
      appBar: AppBarCampaign(hem: hem, ffem: ffem, fem: fem),
      body:
          lectureId == null
              ? const Center(child: CircularProgressIndicator())
              : HistoryScreenBody(lectureId: lectureId!),
    );
  }
}
