import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swallet_mobile/data/datasource/api_exceptions.dart';
import 'package:swallet_mobile/data/interface_repositories/authentication_repository.dart';
import 'package:swallet_mobile/data/models/authen_model.dart';
import 'package:swallet_mobile/presentation/blocs/authentication/authentication_bloc.dart';

class _FakeAuthenticationRepository implements AuthenticationRepository {
  _FakeAuthenticationRepository({this.result, this.error});

  final AuthenModel? result;
  final Object? error;

  @override
  Future<AuthenModel?> loginWithAccount(String userName, String password) async {
    if (error != null) throw error!;
    return result;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

AuthenModel _authen({required String role, bool isVerified = true}) =>
    AuthenModel(
      jwt: 'jwt',
      accountId: 'acc-1',
      isVerified: isVerified,
      role: role,
      email: 'user@test',
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() => SharedPreferences.setMockInitialValues(<String, Object>{}));

  AuthenticationBloc blocFor({AuthenModel? result, Object? error}) =>
      AuthenticationBloc(
        authenticationRepository:
            _FakeAuthenticationRepository(result: result, error: error),
      );

  test('sinh viên đã xác thực -> AuthenticationSuccess', () async {
    final bloc = blocFor(result: _authen(role: 'Sinh viên'));
    addTearDown(bloc.close);

    final expectation = expectLater(
      bloc.stream,
      emitsInOrder([isA<AuthenticationInProcess>(), isA<AuthenticationSuccess>()]),
    );
    bloc.add(LoginAccount(userName: 'sv', password: 'x'));
    await expectation;
  });

  test('giáo viên -> AuthenticationLectureSuccess (kể cả chuỗi dạng NFD)', () async {
    final bloc = blocFor(result: _authen(role: 'Gia\u0301o viên'));
    addTearDown(bloc.close);

    final expectation = expectLater(
      bloc.stream,
      emitsInOrder([
        isA<AuthenticationInProcess>(),
        isA<AuthenticationLectureSuccess>(),
      ]),
    );
    bloc.add(LoginAccount(userName: 'gv', password: 'x'));
    await expectation;
  });

  test('cửa hàng -> AuthenticationStoreSuccess', () async {
    final bloc = blocFor(result: _authen(role: 'Cửa hàng'));
    addTearDown(bloc.close);

    final expectation = expectLater(
      bloc.stream,
      emitsInOrder([
        isA<AuthenticationInProcess>(),
        isA<AuthenticationStoreSuccess>(),
      ]),
    );
    bloc.add(LoginAccount(userName: 'store', password: 'x'));
    await expectation;
  });

  test('Admin KHÔNG được vào app dưới quyền cửa hàng', () async {
    final bloc = blocFor(result: _authen(role: 'Admin'));
    addTearDown(bloc.close);

    final expectation = expectLater(
      bloc.stream,
      emitsInOrder([
        isA<AuthenticationInProcess>(),
        isA<AuthenticationFailed>(),
      ]),
    );
    bloc.add(LoginAccount(userName: 'admin', password: 'x'));
    await expectation;
  });

  test('chưa xác thực email -> AuthenticationSuccessButNotVerified', () async {
    final bloc = blocFor(result: _authen(role: 'Sinh viên', isVerified: false));
    addTearDown(bloc.close);

    final expectation = expectLater(
      bloc.stream,
      emitsInOrder([
        isA<AuthenticationInProcess>(),
        isA<AuthenticationSuccessButNotVerified>(),
      ]),
    );
    bloc.add(LoginAccount(userName: 'sv', password: 'x'));
    await expectation;
  });

  test('sai mật khẩu (repo trả null) -> AuthenticationFailed', () async {
    final bloc = blocFor();
    addTearDown(bloc.close);

    final expectation = expectLater(
      bloc.stream,
      emitsInOrder([isA<AuthenticationInProcess>(), isA<AuthenticationFailed>()]),
    );
    bloc.add(LoginAccount(userName: 'sai', password: 'sai'));
    await expectation;
  });

  test('AppException được hiển thị nguyên văn, không kèm "Exception:"', () async {
    final bloc = blocFor(error: UnsupportedRoleException('Admin'));
    addTearDown(bloc.close);

    final states = <AuthenticationState>[];
    final sub = bloc.stream.listen(states.add);
    bloc.add(LoginAccount(userName: 'admin', password: 'x'));
    await Future<void>.delayed(const Duration(milliseconds: 50));
    await sub.cancel();

    final failed = states.whereType<AuthenticationFailed>().single;
    expect(failed.error, contains('không sử dụng được trên ứng dụng di động'));
    expect(failed.error, isNot(contains('Exception:')));
  });
}
