import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/lecture_features/lecture_model.dart';
import 'package:swallet_mobile/data/interface_repositories/lecture_features/lecture_repository.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'dart:convert';

class LectureRepositoryImp implements LectureRepository {
  String endPoint = '${baseURL}Lecturer/';
  String? token;
  String? lectureId;
  String sort = 'Id%2Cdesc';
  int page = 1;
  int limit = 10;
  bool state = true;
  @override
  Future<LectureModel?> fetchLectureById({required String accountId}) async {
    try {
      token = await AuthenLocalDataSource.getToken();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      http.Response response = await http.get(
        Uri.parse('${endPoint}account/$accountId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        LectureModel lectureModel = LectureModel.fromJson(result);
        String lectureString = jsonEncode(LectureModel.fromJson(result));
        AuthenLocalDataSource.saveLecture(lectureString);
        return lectureModel;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Map<String, String>> generateQRCode({
    required int points,
    required int availableHours,
    required String lecturerId,
    required int maxUsageCount, // Thêm tham số maxUsageCount
    required BuildContext context, // Thêm context để hiển thị thông báo
  }) async {
    try {
      // Lấy token từ local storage
      token = await AuthenLocalDataSource.getToken();
      if (token == null) {
        throw Exception('Token không tồn tại. Vui lòng đăng nhập lại.');
      }

      // Kiểm tra và yêu cầu quyền vị trí
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Quyền truy cập vị trí bị từ chối')),
          );
          throw Exception('Quyền truy cập vị trí bị từ chối');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Quyền truy cập vị trí bị từ chối vĩnh viễn')),
        );
        throw Exception('Quyền truy cập vị trí bị từ chối vĩnh viễn');
      }

      // Lấy vị trí hiện tại
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Kiểm tra maxUsageCount hợp lệ
      if (maxUsageCount <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Số lần sử dụng tối đa phải lớn hơn 0')),
        );
        throw Exception('Số lần sử dụng tối đa không hợp lệ');
      }

      // Chuẩn bị headers
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'accept': 'text/plain',
      };

      // Chuẩn bị body với các trường mới
      final Map<String, dynamic> body = {
        'lecturerId': lecturerId,
        'points': points,
        'availableHours': availableHours,
        'longitude': position.longitude,
        'latitude': position.latitude,
        'maxUsageCount': maxUsageCount,
      };

      debugPrint('Request body: ${jsonEncode(body)}'); // Log request để debug

      // Gửi yêu cầu POST
      http.Response response = await http.post(
        Uri.parse('${baseURL}Lecturer/generate-qrcode'),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        return {'qrCodeImageUrl': result['qrCodeImageUrl'] as String};
      } else {
        final errorBody = jsonDecode(response.body);
        throw Exception(
          'Failed to generate QR code: ${response.statusCode} - ${errorBody['message'] ?? response.body}',
        );
      }
    } catch (e) {
      debugPrint('Error generating QR code: $e');
      throw Exception('Lỗi khi tạo mã QR: $e');
    }
  }

  @override
  Future<LectureModel?> putLecture({
    required String id,
    required String accountId,
    required String fullName,
    required DateTime dateCreated,
    required DateTime dateUpdated,
    required bool state,
    required bool status,
  }) {
    // TODO: implement putLecture
    throw UnimplementedError();
  }
}
