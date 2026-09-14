import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swallet_mobile/data/datasource/api_client.dart';
import 'package:swallet_mobile/data/datasource/api_exceptions.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/repositories/authen_repository_imp.dart';
import 'package:swallet_mobile/domain/entities/account_role.dart';

import '_fixtures.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() => SharedPreferences.setMockInitialValues(<String, Object>{}));

  AuthenticationRepositoryImp repoReturning(Map<String, dynamic> body) =>
      AuthenticationRepositoryImp(
        api: ApiClient(
          requiresAuth: false,
          inner: MockClient((_) async => jsonResponse(body)),
        ),
      );

  test('đăng nhập sinh viên lưu token, session và cờ xác thực', () async {
    final repo = repoReturning(loginJson(role: 'Sinh viên'));

    final result = await repo.loginWithAccount('sv01', 'matkhau');

    expect(result, isNotNull);
    expect(result!.accountRole, AccountRole.student);
    expect(await AuthenLocalDataSource.getToken(), 'jwt-moi');
    expect(await AuthenLocalDataSource.getIsVerified(), 'true');
    final saved = await AuthenLocalDataSource.getAuthen();
    expect(saved?.accountId, 'acc-1');
  });

  test('đăng nhập giảng viên lưu được balance (trước đây crash ép double sang int)',
      () async {
    // Hai chặng: /Auth/login rồi /Lecture/account/<id>.
    final repo = AuthenticationRepositoryImp(
      api: ApiClient(
        requiresAuth: false,
        inner: MockClient(
          (_) async =>
              jsonResponse(loginJson(role: 'Giáo viên')),
        ),
      ),
    );
    // LectureRepositoryImp bên trong dùng client dùng chung -> tráo tạm.
    final truocDo = ApiClient.instance;
    ApiClient.instance = ApiClient(
      inner: MockClient(
        (_) async => jsonResponse(lectureJson),
      ),
    );
    addTearDown(() => ApiClient.instance = truocDo);

    final result = await repo.loginWithAccount('gv01', 'matkhau');

    expect(result?.accountRole, AccountRole.lecturer);
    expect(await AuthenLocalDataSource.getBalance(), 1500);
  });

  test('đăng nhập cửa hàng KHÔNG ghi cờ isVerify', () async {
    final repo = repoReturning(loginJson(role: 'Cửa hàng'));

    final result = await repo.loginWithAccount('store01', 'matkhau');

    expect(result?.accountRole, AccountRole.store);
    expect(await AuthenLocalDataSource.getIsVerified(), isNull);
  });

  test('tài khoản Admin bị từ chối thay vì được cấp quyền Cửa hàng', () async {
    final repo = repoReturning(loginJson(role: 'Admin'));

    await expectLater(
      repo.loginWithAccount('admin', 'matkhau'),
      throwsA(isA<UnsupportedRoleException>()),
    );
    expect(await AuthenLocalDataSource.getToken(), isNull,
        reason: 'không được tạo session cho vai trò không hỗ trợ');
  });

  test('tài khoản Brand cũng bị từ chối', () async {
    final repo = repoReturning(loginJson(role: 'Brand'));

    await expectLater(
      repo.loginWithAccount('brand', 'matkhau'),
      throwsA(isA<UnsupportedRoleException>()),
    );
  });

  test('sai thông tin đăng nhập trả null, không ném lỗi', () async {
    final repo = AuthenticationRepositoryImp(
      api: ApiClient(
        requiresAuth: false,
        inner: MockClient((_) async => http.Response('unauthorized', 401)),
      ),
    );

    expect(await repo.loginWithAccount('sai', 'sai'), isNull);
  });
}
