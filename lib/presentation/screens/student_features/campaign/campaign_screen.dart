import 'package:flutter/material.dart';
import 'package:swallet_mobile/presentation/screens/student_features/campaign/components/body.dart';

class CampaignScreen extends StatelessWidget {
  static const String routeName = '/campaign-student';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const CampaignScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const CampaignScreen({super.key});

  // CampaignBloc dùng chung cho cả màn đổi voucher, nên không gate cả màn hình
  // theo state của nó: mỗi section tự xử lý loading/lỗi của riêng mình.
  @override
  Widget build(BuildContext context) => const CampaignScreenBody();
}
