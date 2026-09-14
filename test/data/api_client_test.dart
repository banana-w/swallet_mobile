import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swallet_mobile/data/datasource/api_client.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{
      'token': 'jwt-cu',
      'authenString': '{"token":"jwt-cu","accountId":"acc-1",'
          '"isVerify":true,"role":"Sinh viên","email":"a@b.c"}',
    });
  });

  test('tự gắn Bearer token cho request đã xác thực', () async {
    String? seenAuthorization;
    final client = ApiClient(
      inner: MockClient((request) async {
        seenAuthorization = request.headers['Authorization'];
        return http.Response('{}', 200);
      }),
    );

    await client.get(Uri.parse('https://example.test/api/Brand'));

    expect(seenAuthorization, 'Bearer jwt-cu');
  });

  test('không ghi đè Authorization đã có sẵn', () async {
    String? seenAuthorization;
    final client = ApiClient(
      inner: MockClient((request) async {
        seenAuthorization = request.headers['Authorization'];
        return http.Response('{}', 200);
      }),
    );

    await client.get(
      Uri.parse('https://example.test/api/Brand'),
      headers: {'Authorization': 'Bearer rieng'},
    );

    expect(seenAuthorization, 'Bearer rieng');
  });

  test('client công khai không gắn token', () async {
    String? seenAuthorization;
    final client = ApiClient(
      requiresAuth: false,
      inner: MockClient((request) async {
        seenAuthorization = request.headers['Authorization'];
        return http.Response('{}', 200);
      }),
    );

    await client.post(Uri.parse('https://example.test/api/Auth/login'));

    expect(seenAuthorization, isNull);
  });

  test('401 xoá session và phát tín hiệu hết phiên', () async {
    final client = ApiClient(
      inner: MockClient((_) async => http.Response('unauthorized', 401)),
    );
    final expired = expectLater(ApiClient.onSessionExpired, emits(anything));

    final response = await client.get(Uri.parse('https://example.test/api/Me'));

    expect(response.statusCode, 401);
    await expired;
    expect(await AuthenLocalDataSource.getToken(), isNull);
    expect(await AuthenLocalDataSource.getAuthen(), isNull);
  });

  test('401 từ client công khai KHÔNG xoá session', () async {
    // Sai mật khẩu khi đăng nhập cũng trả 401 — không được coi là hết phiên.
    final client = ApiClient(
      requiresAuth: false,
      inner: MockClient((_) async => http.Response('sai mat khau', 401)),
    );

    await client.post(Uri.parse('https://example.test/api/Auth/login'));

    expect(await AuthenLocalDataSource.getToken(), 'jwt-cu');
  });
}
