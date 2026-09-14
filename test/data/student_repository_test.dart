import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swallet_mobile/data/datasource/api_client.dart';
import 'package:swallet_mobile/data/datasource/api_exceptions.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/repositories/student_features/student_repository_imp.dart';

import '_fixtures.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{'token': 'jwt-cu'});
  });

  test('fetchStudentById trả model và cache lại vào local', () async {
    Uri? calledUrl;
    final repo = StudentRepositoryImp(
      api: ApiClient(
        inner: MockClient((request) async {
          calledUrl = request.url;
          return jsonResponse(studentJson);
        }),
      ),
    );

    final student = await repo.fetchStudentById(id: 'acc-1');

    expect(student, isNotNull);
    expect(student!.id, 'stu-1');
    expect(student.fullName, 'Nguyễn Văn A', reason: 'phải giải mã đúng UTF-8');
    expect(student.state, 2);
    expect(calledUrl.toString(), endsWith('/account/acc-1'));
    final cached = await AuthenLocalDataSource.getStudent();
    expect(cached?.id, 'stu-1');
  });

  test('fetchStudentById trả null khi server không trả 200', () async {
    final repo = StudentRepositoryImp(
      api: ApiClient(
        inner: MockClient((_) async => http.Response('not found', 404)),
      ),
    );

    expect(await repo.fetchStudentById(id: 'khong-co'), isNull);
  });

  test('gửi kèm Bearer token lấy từ local storage', () async {
    String? authorization;
    final repo = StudentRepositoryImp(
      api: ApiClient(
        inner: MockClient((request) async {
          authorization = request.headers['Authorization'];
          return jsonResponse(studentJson);
        }),
      ),
    );

    await repo.fetchStudentById(id: 'acc-1');

    expect(authorization, 'Bearer jwt-cu');
  });

  test('fetchWishListByStudentId báo hết phiên khi chưa có session', () async {
    // Trước đây dòng `studentId = student!.id` ném TypeError khó hiểu.
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final repo = StudentRepositoryImp(
      api: ApiClient(inner: MockClient((_) async => jsonResponse(<String>[]))),
    );

    await expectLater(
      repo.fetchWishListByStudentId(),
      throwsA(isA<SessionExpiredException>()),
    );
  });
}
