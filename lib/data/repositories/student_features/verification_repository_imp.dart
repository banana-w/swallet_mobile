import 'dart:convert';

import 'package:swallet_mobile/data/datasource/api_client.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/verification_repository.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

class VerificationRepositoryImp extends VerificationRepository {
  /// Cho phep test tiem client gia; app dung client dung chung.
  VerificationRepositoryImp({ApiClient? api}) : _api = api ?? ApiClient.public;

  final ApiClient _api;

  @override
  Future<bool> verifyEmailCode(String accountId, String email, String code) async {
    final url = Uri.parse('${baseURL}Auth/verify-account');

    try {
      final response = await _api.post(
        url,
        headers: {'Content-Type': 'application/json', 'accept': 'text/plain'},
        body: jsonEncode({'id': accountId,'email': email, 'code': code}),
      );

      if (response.statusCode == 200 && response.body == 'true') {
        return true;
      } else {
        throw Exception('Failed to verify code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to verify code: $e');
    }
  }

  @override
  Future<bool> verifyStudent(String studenId, String email, String code) async {
    final url = Uri.parse('${baseURL}Auth/verify-student');

    try {
      final response = await _api.post(
        url,
        headers: {'Content-Type': 'application/json', 'accept': 'text/plain'},
        body: jsonEncode({'studentId': studenId,'email': email, 'code': code}),
      );

      if (response.statusCode == 200 && response.body == 'true') {
        return true;
      } else {
        throw Exception('Failed to verify code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to verify code: $e');
    }
  }

  @override
  Future<bool> resendEmail(String email) async {
    try {
      final url = Uri.parse('${baseURL}Email?email=${Uri.encodeComponent(email)}');

      final response = await _api.post(
        url,
        headers: {'accept': '*/*'},
        body: '',
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to resend email: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error resending email: $e');
    }
  }
}
