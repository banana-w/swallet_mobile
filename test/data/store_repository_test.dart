import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swallet_mobile/data/datasource/api_client.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/repositories/store_features/store_repository_imp.dart';

import '_fixtures.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{'token': 'jwt-cu'});
  });

  test('fetchStoreById trả model và cache lại', () async {
    final repo = StoreRepositoryImp(
      api: ApiClient(inner: MockClient((_) async => jsonResponse(storeJson))),
    );

    final store = await repo.fetchStoreById(accountId: 'acc-store');

    expect(store, isNotNull);
    expect(store!.id, 'store-1');
    expect(store.brandName, 'Trà sữa ABC');
    expect((await AuthenLocalDataSource.getStore())?.id, 'store-1');
  });

  test('fetchStoreById trả null khi server lỗi', () async {
    final repo = StoreRepositoryImp(
      api: ApiClient(
        inner: MockClient((_) async => http.Response('loi', 500)),
      ),
    );

    expect(await repo.fetchStoreById(accountId: 'acc-store'), isNull);
  });

  test('token hết hạn: 401 xoá session để app biết mà đăng xuất', () async {
    final repo = StoreRepositoryImp(
      api: ApiClient(
        inner: MockClient((_) async => http.Response('unauthorized', 401)),
      ),
    );

    final store = await repo.fetchStoreById(accountId: 'acc-store');

    expect(store, isNull);
    expect(await AuthenLocalDataSource.getToken(), isNull);
  });
}
