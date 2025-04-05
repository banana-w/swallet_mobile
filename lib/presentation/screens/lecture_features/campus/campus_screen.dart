import 'package:flutter/material.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/presentation/screens/lecture_features/campus/components/body.dart';
import 'package:swallet_mobile/presentation/widgets/app_bar_campaign.dart';

class CampusScreen extends StatefulWidget {
  const CampusScreen({Key? key}) : super(key: key);

  @override
  _CampusScreen createState() => _CampusScreen();
}

class _CampusScreen extends State<CampusScreen> {
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
              : CampusScreenBody(lectureId: lectureId!),
    );
  }
}
