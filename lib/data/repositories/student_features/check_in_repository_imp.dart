import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:swallet_mobile/data/interface_repositories/student_features/check_in_repository.dart';

class CheckInRepositoryImpl implements CheckInRepository {
  final String baseUrl =
      "https://swallet-api-2025-capstoneproject.onrender.com/api/CheckIn"; // Cập nhật baseUrl

  @override
  Future<CheckInData> getCheckInData(String studentId) async {
    try {
      final response = await http.get(
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
      final response = await http.post(
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
}
