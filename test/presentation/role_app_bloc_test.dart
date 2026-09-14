import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swallet_mobile/data/interface_repositories/lecture_features/lecture_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/store_features/store_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/student_repository.dart';
import 'package:swallet_mobile/data/models/lecture_features/lecture_model.dart';
import 'package:swallet_mobile/data/models/store_features/store_model.dart';
import 'package:swallet_mobile/data/models/student_features/student_model.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';

import '../data/_fixtures.dart';

class _FakeStudentRepository implements StudentRepository {
  _FakeStudentRepository(this.student);
  final StudentModel? student;

  @override
  Future<StudentModel?> fetchStudentById({required String id}) async => student;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeLectureRepository implements LectureRepository {
  _FakeLectureRepository(this.lecture);
  final LectureModel? lecture;

  @override
  Future<LectureModel?> fetchLectureById({required String accountId}) async =>
      lecture;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeStoreRepository implements StoreRepository {
  _FakeStoreRepository(this.store);
  final StoreModel? store;

  @override
  Future<StoreModel?> fetchStoreById({required String accountId}) async => store;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

RoleAppBloc buildBloc({
  StudentModel? student,
  LectureModel? lecture,
  StoreModel? store,
}) => RoleAppBloc(
  _FakeStudentRepository(student),
  _FakeStoreRepository(store),
  _FakeLectureRepository(lecture),
);

void setSession({required String role, bool isVerify = true}) {
  SharedPreferences.setMockInitialValues(<String, Object>{
    'authenString': jsonEncode(
      loginJson(role: role, isVerify: isVerify, accountId: 'acc-1'),
    ),
  });
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('chưa đăng nhập -> RoleReset, không ném NPE', () async {
    // Trước đây `authenModel!.isVerified` ném TypeError, bloc kẹt ở loading.
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final bloc = buildBloc();
    addTearDown(bloc.close);

    final expectation = expectLater(
      bloc.stream,
      emitsInOrder([isA<RoleAppLoading>(), isA<RoleReset>()]),
    );
    bloc.add(RoleAppStart());
    await expectation;
  });

  test('sinh viên state=2 -> Verified', () async {
    setSession(role: 'Sinh viên');
    final bloc = buildBloc(student: StudentModel.fromJson(studentJson));
    addTearDown(bloc.close);

    final expectation = expectLater(
      bloc.stream,
      emitsInOrder([isA<RoleAppLoading>(), isA<Verified>()]),
    );
    bloc.add(RoleAppStart());
    await expectation;
  });

  test('sinh viên state != 2 -> Unverified', () async {
    setSession(role: 'Sinh viên');
    final bloc = buildBloc(
      student: StudentModel.fromJson({...studentJson, 'state': 1}),
    );
    addTearDown(bloc.close);

    final expectation = expectLater(
      bloc.stream,
      emitsInOrder([isA<RoleAppLoading>(), isA<Unverified>()]),
    );
    bloc.add(RoleAppStart());
    await expectation;
  });

  test('giáo viên -> LectureRole', () async {
    setSession(role: 'Giáo viên');
    final bloc = buildBloc(lecture: LectureModel.fromJson(lectureJson));
    addTearDown(bloc.close);

    final expectation = expectLater(
      bloc.stream,
      emitsInOrder([isA<RoleAppLoading>(), isA<LectureRole>()]),
    );
    bloc.add(RoleAppStart());
    await expectation;
  });

  test('cửa hàng -> StoreRole', () async {
    setSession(role: 'Cửa hàng');
    final bloc = buildBloc(store: StoreModel.fromJson(storeJson));
    addTearDown(bloc.close);

    final expectation = expectLater(
      bloc.stream,
      emitsInOrder([isA<RoleAppLoading>(), isA<StoreRole>()]),
    );
    bloc.add(RoleAppStart());
    await expectation;
  });

  test('Admin -> RoleReset, KHÔNG rơi vào StoreRole', () async {
    setSession(role: 'Admin');
    final bloc = buildBloc(store: StoreModel.fromJson(storeJson));
    addTearDown(bloc.close);

    final expectation = expectLater(
      bloc.stream,
      emitsInOrder([isA<RoleAppLoading>(), isA<RoleReset>()]),
    );
    bloc.add(RoleAppStart());
    await expectation;
  });

  test('API trả null -> giữ loading, KHÔNG xoá session của người dùng', () async {
    setSession(role: 'Sinh viên');
    final bloc = buildBloc(); // student = null
    addTearDown(bloc.close);

    final states = <RoleAppState>[];
    final sub = bloc.stream.listen(states.add);
    bloc.add(RoleAppStart());
    await Future<void>.delayed(const Duration(milliseconds: 50));
    await sub.cancel();

    expect(states, everyElement(isA<RoleAppLoading>()));
    expect(states.whereType<RoleReset>(), isEmpty,
        reason: 'lỗi mạng tạm thời không được đăng xuất người dùng');
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('authenString'), isNotNull);
  });
}
