import 'package:flutter/material.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

import '../../widgets/store_result_view.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.failed});

  final String failed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    return StoreResultView(
      animation: 'assets/animations/failed-animation.json',
      title: 'QUÉT THẤT BẠI!',
      borderColor: kErrorTextColor,
      cardHeight: 200,
      fem: fem,
      ffem: ffem,
      hem: hem,
      rows: [
        StoreResultRow(
          label: 'Thời gian thực hiện',
          value: formatResultDateTime(DateTime.now()),
          ffem: ffem,
          hem: hem,
        ),
        StoreResultRow(
          label: 'Nội dung',
          value: failed,
          ffem: ffem,
          hem: hem,
          fem: fem,
          height: 80,
          valueWidth: 200,
          maxLines: 3,
        ),
      ],
    );
  }
}
