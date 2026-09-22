import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swallet_mobile/data/models/store_features/transact_result_model.dart';
import 'package:swallet_mobile/presentation/config/app_router.dart';
import 'package:swallet_mobile/presentation/screens/store_features/campaign_voucher_list/campaign_voucher_list_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/transact/success_transact_screen.dart';

/// `AppRouter` trả về route lỗi (tên `/`) cho mọi tên chưa khai báo, nên phép
/// so tên route là cách nhận ra một màn hình bị bỏ sót khỏi bảng định tuyến.
void main() {
  group('Định tuyến phía cửa hàng', () {
    test('màn kết quả tìm kiếm ưu đãi có trong bảng định tuyến', () {
      final route = AppRouter.onGenerateRoute(
        const RouteSettings(
          name: CampaignVoucherListScreen.routeName,
          arguments: 'khuyến mãi',
        ),
      );

      expect(route.settings.name, CampaignVoucherListScreen.routeName);
    });

    test('màn tặng đậu thành công có trong bảng định tuyến', () {
      final route = AppRouter.onGenerateRoute(
        RouteSettings(
          name: SuccessTransactScreen.routeName,
          arguments: _transactResult,
        ),
      );

      expect(route.settings.name, SuccessTransactScreen.routeName);
    });

    test('tên lạ vẫn rơi về route lỗi', () {
      final route = AppRouter.onGenerateRoute(
        const RouteSettings(name: '/khong-ton-tai'),
      );

      expect(route.settings.name, '/');
    });
  });
}

const _transactResult = TransactResultModel(
  id: 'id',
  brandId: 'brand',
  brandName: 'Brand',
  storeId: 'store',
  storeName: 'Store',
  studentId: 'student',
  studentName: 'Student',
  amount: 100,
  dateCreated: '2026-09-22T10:00:00',
  dateUpdated: '2026-09-22T10:00:00',
  description: 'Chúc bạn một ngày vui vẻ',
  state: true,
  status: true,
);
