import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:swallet_mobile/data/models/lecture_features/qr_code_history.dart';

class QRCodeApiClient {
  final String baseUrl =
      'https://swallet-api-2025-capstoneproject.onrender.com';

  Future<List<QRCodeHistory>> getQRCodeHistory({
    required String lectureId,
    required int page,
    required int size,
  }) async {
    final uri = Uri.parse('$baseUrl/api/Lecturer/qr-history').replace(
      queryParameters: {
        'lectureId': lectureId,
        'page': page.toString(),
        'size': size.toString(),
      },
    );

    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Parse response.body thành Map<String, dynamic>
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      // Lấy danh sách từ key "items"
      if (jsonResponse.containsKey('items') && jsonResponse['items'] != null) {
        final List<dynamic> jsonList = jsonResponse['items'] as List<dynamic>;
        return jsonList.map((json) => QRCodeHistory.fromJson(json)).toList();
      } else {
        // Trả về danh sách rỗng nếu "items" không tồn tại hoặc null
        return [];
      }
    } else {
      throw Exception('Failed to load QR code history: ${response.statusCode}');
    }
  }
}
