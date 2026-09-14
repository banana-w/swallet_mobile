/// JSON mẫu khớp đúng với `fromJson` của từng model, dùng chung cho các test.
library;

import 'dart:convert';

import 'package:http/http.dart' as http;

const Map<String, dynamic> studentJson = {
  'id': 'stu-1',
  'campusId': 'campus-1',
  'accountId': 'acc-1',
  'studentCardFront': 'https://cdn.test/front.png',
  'fullName': 'Nguyễn Văn A',
  'studentEmail': 'a@student.test',
  'coinBalance': 120.0,
  'campusName': 'Cơ sở 1',
  'code': 'SE170001',
  'gender': 1,
  'dateOfBirth': '2003-01-01',
  'address': 'Thủ Đức',
  'totalIncome': 500.0,
  'totalSpending': 380.0,
  'dateCreated': '2025-01-01T00:00:00',
  'dateUpdated': '2025-06-01T00:00:00',
  'state': 2,
  'status': true,
};

const Map<String, dynamic> storeJson = {
  'id': 'store-1',
  'brandId': 'brand-1',
  'brandName': 'Trà sữa ABC',
  'areaId': 'area-1',
  'areaName': 'Khu A',
  'accountId': 'acc-store',
  'storeName': 'ABC Chi nhánh 1',
  'userName': 'abc1',
  'email': 'store@test',
  'phone': '0900000000',
  'address': 'Linh Trung',
  'openingHours': '07:00',
  'closingHours': '22:00',
  'dateCreated': '2025-01-01T00:00:00',
  'dateUpdated': '2025-06-01T00:00:00',
  'description': 'Chi nhánh chính',
  'state': true,
  'status': true,
};

const Map<String, dynamic> lectureJson = {
  'id': 'lec-1',
  'accountId': 'acc-lec',
  'fullName': 'Trần Thị B',
  'email': 'b@lecturer.test',
  'phone': '0911111111',
  'campusName': ['Cơ sở 1'],
  'balance': 1500.0,
  'dateCreated': '2025-01-01T00:00:00',
  'dateUpdated': '2025-06-01T00:00:00',
  'state': true,
  'status': true,
};

Map<String, dynamic> loginJson({
  required String role,
  bool isVerify = true,
  String accountId = 'acc-1',
}) => {
  'token': 'jwt-moi',
  'accountId': accountId,
  'isVerify': isVerify,
  'role': role,
  'email': 'user@test',
};

/// Repository giải mã body bằng `utf8.decode(response.bodyBytes)`, nên response
/// giả phải là bytes UTF-8 thật — `http.Response(String, int)` mặc định latin1
/// sẽ làm hỏng tiếng Việt.
http.Response jsonResponse(Object body, [int statusCode = 200]) =>
    http.Response.bytes(
      utf8.encode(jsonEncode(body)),
      statusCode,
      headers: const {'content-type': 'application/json; charset=utf-8'},
    );
