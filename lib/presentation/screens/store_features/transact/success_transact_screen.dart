import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/data/models/store_features/transact_result_model.dart';
import 'package:swallet_mobile/presentation/blocs/campaign/campaign_bloc.dart';

import '../../../config/constants.dart';
import '../widgets/store_app_bar.dart';
import '../widgets/store_bottom_button.dart';
import '../widgets/store_result_view.dart';

class SuccessTransactScreen extends StatelessWidget {
  static const String routeName = '/success-transact-store';

  static Route route({required TransactResultModel transactResultModel}) {
    return PageRouteBuilder(
      pageBuilder:
          (_, _, _) =>
              SuccessTransactScreen(transactResultModel: transactResultModel),
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (_, animation, _, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        final offsetAnimation = animation.drive(Tween(begin: begin, end: end));

        return SlideTransition(position: offsetAnimation, child: child);
      },
      settings: const RouteSettings(name: routeName),
    );
  }

  const SuccessTransactScreen({super.key, required this.transactResultModel});

  final TransactResultModel transactResultModel;

  void _goHome(BuildContext context) {
    context.read<CampaignBloc>().add(const LoadCampaigns());
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/landing-screen-store',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: StoreAppBar(
          title: 'Kết quả giao dịch',
          fem: fem,
          ffem: ffem,
          hem: hem,
          onHome: () => _goHome(context),
        ),
        bottomNavigationBar: StoreBottomButton(
          label: 'Trang chủ',
          fem: fem,
          ffem: ffem,
          hem: hem,
          onTap: () => _goHome(context),
        ),
        body: StoreResultView(
          animation: 'assets/animations/success-animation.json',
          animationBackground: klighGreyColor,
          title: 'GIAO DỊCH THÀNH CÔNG!',
          borderColor: kPrimaryColor,
          spacing: 40,
          fem: fem,
          ffem: ffem,
          hem: hem,
          rows: [
            StoreResultRow(
              label: 'Thời gian thực hiện',
              value: formatResultDateTimeString(
                transactResultModel.dateCreated,
              ),
              ffem: ffem,
              hem: hem,
            ),
            StoreResultRow(
              label: 'Người nhận',
              value: transactResultModel.studentName,
              ffem: ffem,
              hem: hem,
              fem: fem,
              valueWidth: 150,
              maxLines: 2,
            ),
            StoreResultRow(
              label: 'Nội dung',
              value: transactResultModel.description,
              ffem: ffem,
              hem: hem,
              fem: fem,
              valueWidth: 150,
              maxLines: 2,
            ),
            StoreResultRow(
              label: 'Số đậu xanh',
              value: formatter.format(transactResultModel.amount),
              ffem: ffem,
              hem: hem,
            ),
          ],
        ),
      ),
    );
  }
}
