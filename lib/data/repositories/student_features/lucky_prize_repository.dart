// lucky_prize_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:swallet_mobile/data/models/student_features/lucky_prize_model.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

class LuckyPrizeRepository {
  String endPoint = '${baseURL}LuckyPrize';
  Future<List<LuckyPrize>> getActivePrizes() async {
    // Giả lập gọi API (thay bằng API thực tế của bạn)
    final response = await http.get(Uri.parse(endPoint));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map((json) => LuckyPrize.fromJson(json))
          // .where(
          //   (prize) => prize.status && prize.quantity > 0,
          // ) // Chỉ lấy phần thưởng active và còn số lượng
          .toList();
    } else {
      throw Exception('Failed to load prizes');
    }
  }

  Future<void> updatePrizeQuantity(String prizeId, int newQuantity) async {
    // Gọi API để cập nhật quantity (thay bằng API thực tế)
    await http.put(
      Uri.parse('$endPoint/$prizeId'),
      body: jsonEncode({'quantity': newQuantity}),
      headers: {'Content-Type': 'application/json'},
    );
  }
}
