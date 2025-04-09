import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:swallet_mobile/domain/interface_repositories/student_features/wheel_repository.dart';

class SpinHistoryRepositoryImpl implements SpinHistoryRepository {
  final String baseUrl =
      "https://swallet-api-2025-capstoneproject.onrender.com/api/LuckyWheel"; // Thay bằng URL backend của bạn

  @override
  Future<int> getSpinCount(String studentId, DateTime date) async {
    final formattedDate = date.toIso8601String().split('T')[0]; // YYYY-MM-DD
    final response = await http.get(
      Uri.parse('$baseUrl/spin-count/$studentId/$formattedDate'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['spinCount'] ?? 0;
    } else {
      throw Exception('Failed to get spin count: ${response.statusCode}');
    }
  }

  @override
  Future<void> incrementSpinCount(String studentId, DateTime date) async {
    final formattedDate = date.toIso8601String().split('T')[0]; // YYYY-MM-DD
    final response = await http.post(
      Uri.parse('$baseUrl/increment-spin-count'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'studentId': studentId, 'date': formattedDate}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to increment spin count: ${response.statusCode}');
    }
  }
}
