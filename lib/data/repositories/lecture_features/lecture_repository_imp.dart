import 'package:flutter/material.dart';
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
    // required String expirationTime,
    // required String startOnTime,
    required int availableHours,
    required String lecturerId, // Đảm bảo đúng tên tham số
  }) async {
    try {
      token = await AuthenLocalDataSource.getToken();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'accept': 'text/plain',
      };

      final Map<String, dynamic> body = {
        'lecturerId': lecturerId,
        'points': points,
        'availableHours': availableHours,
      };

      debugPrint('Request body: ${jsonEncode(body)}'); // Log request để debug

      http.Response response = await http.post(
        Uri.parse('${baseURL}Lecturer/generate-qrcode'),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        return {'qrCodeImageUrl': result['qrCodeImageUrl'] as String};
      } else {
        throw Exception(
          'Failed to generate QR code: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error generating QR code: $e');
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
