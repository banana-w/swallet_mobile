import 'package:flutter_test/flutter_test.dart';
import 'package:swallet_mobile/domain/entities/account_role.dart';

void main() {
  group('AccountRole.fromApi', () {
    test('nhận diện sinh viên', () {
      expect(AccountRole.fromApi('Sinh viên'), AccountRole.student);
      expect(AccountRole.fromApi('  sinh viên  '), AccountRole.student);
      expect(AccountRole.fromApi('Student'), AccountRole.student);
    });

    test('nhận diện giáo viên ở cả dạng NFC lẫn NFD', () {
      // Đây chính là bug cũ: authen_repository lưu chuỗi dạng NFD, bloc lưu
      // dạng NFC, nhìn giống hệt nhau nhưng `==` trả về false.
      const nfc = 'Giáo viên'; // á = U+00E1
      const nfd = 'Gia\u0301o viên'; // a + U+0301
      expect(nfc == nfd, isFalse, reason: 'hai chuỗi thật sự khác nhau');
      expect(AccountRole.fromApi(nfc), AccountRole.lecturer);
      expect(AccountRole.fromApi(nfd), AccountRole.lecturer);
      expect(AccountRole.fromApi('Giao vien'), AccountRole.lecturer);
      expect(AccountRole.fromApi('Giảng viên'), AccountRole.lecturer);
    });

    test('nhận diện cửa hàng', () {
      expect(AccountRole.fromApi('Cửa hàng'), AccountRole.store);
      expect(AccountRole.fromApi('Store'), AccountRole.store);
    });

    test('Admin và Brand KHÔNG còn bị coi là cửa hàng', () {
      // Lỗi nghiệp vụ cũ: mọi role không phải Sinh viên/Giáo viên đều rơi vào
      // nhánh else và được cấp quyền Cửa hàng.
      expect(AccountRole.fromApi('Admin'), AccountRole.admin);
      expect(AccountRole.fromApi('Quản trị viên'), AccountRole.admin);
      expect(AccountRole.fromApi('Brand'), AccountRole.brand);
      expect(AccountRole.fromApi('Thương hiệu'), AccountRole.brand);
    });

    test('role rỗng hoặc lạ trả về unknown', () {
      expect(AccountRole.fromApi(null), AccountRole.unknown);
      expect(AccountRole.fromApi(''), AccountRole.unknown);
      expect(AccountRole.fromApi('Kiểm duyệt viên'), AccountRole.unknown);
    });

    test('chỉ student/lecturer/store được vào app mobile', () {
      expect(AccountRole.student.isSupportedOnMobile, isTrue);
      expect(AccountRole.lecturer.isSupportedOnMobile, isTrue);
      expect(AccountRole.store.isSupportedOnMobile, isTrue);
      expect(AccountRole.admin.isSupportedOnMobile, isFalse);
      expect(AccountRole.brand.isSupportedOnMobile, isFalse);
      expect(AccountRole.unknown.isSupportedOnMobile, isFalse);
    });
  });
}
