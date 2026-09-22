import 'package:swallet_mobile/data/datasource/api_client.dart';
import 'dart:convert';

import 'package:swallet_mobile/data/interface_repositories/student_features/check_in_repository.dart';

class CheckInRepositoryImpl implements CheckInRepository {
  /// Cho phep test tiem client gia; app dung client dung chung.
  CheckInRepositoryImpl({ApiClient? api}) : _api = api ?? ApiClient.public;

  final ApiClient _api;

  final String baseUrl =
      "https://swallet-api-2025-capstoneproject.onrender.com/api/CheckIn"; // Cập nhật baseUrl

  @override
  Future<CheckInData> getCheckInData(String studentId) async {
    try {
      final response = await _api.get(
        Uri.parse(
          '$baseUrl/get-check-in-data/$studentId',
        ), // Gọi endpoint GET /api/check-in/{studentId}
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return CheckInData.fromJson(data);
      } else {
        throw Exception(
          'Failed to get check-in data: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('Error in getCheckInData: $e');
      rethrow;
    }
  }

  @override
  Future<CheckInData> checkIn(String studentId) async {
    try {
      final response = await _api.post(
        Uri.parse(
          '$baseUrl/check-in/$studentId',
        ), // Gọi endpoint POST /api/check-in/{studentId}
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return CheckInData.fromJson(data);
      } else {
        throw Exception(
          'Failed to check in: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('Error in checkIn: $e');
      rethrow;
    }
  }

  @override
  Future<int> checkInWithQr({
    required String studentId,
    required String qrCode,
    required double latitude,
    required double longitude,
  }) async {
    final response = await _api.post(
      Uri.parse('$baseUrl/qr'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'studentId': studentId,
        'qrCode': qrCode,
        'latitude': latitude,
        'longitude': longitude,
      }),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode != 200) {
      // Thông báo của máy chủ đã là tiếng Việt và hiển thị thẳng cho người
      // dùng, nên giữ nguyên thay vì bọc thêm 'Exception: '.
      throw CheckInException(data['message'] ?? 'Check-in thất bại');
    }
    return data['pointsAwarded'] ?? 10;
  }
}
