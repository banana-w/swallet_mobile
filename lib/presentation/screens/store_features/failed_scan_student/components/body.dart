import 'package:flutter/material.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/widgets/internet_listener.dart';

import '../../widgets/store_result_view.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.failed});

  /// Lỗi thô từ API. Màn này cố ý hiển thị câu thông báo thân thiện thay vì
  /// lỗi gốc, nên [failed] chỉ được giữ lại cho nhất quán với route.
  final String failed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    return InternetListener(
      child: StoreResultView(
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
            value: 'Không tìm thấy sinh viên',
            ffem: ffem,
            hem: hem,
            fem: fem,
            valueWidth: 150,
          ),
        ],
      ),
    );
  }
}
