import 'dart:convert';

import 'package:swallet_mobile/data/interface_repositories/student_features/validation_repository.dart';

import '../../../presentation/config/constants.dart';
import 'package:http/http.dart' as http;

class ValidationRepositoryImp implements ValidationRepository {
  String endPoint = '${baseURL}Account';

  @override
  Future<String> validateEmail({required String email}) async {
    try {
      final Map<String, String> headers = {'Content-Type': 'application/json'};

      // Encode email để tránh lỗi ký tự đặc biệt
      final String encodedEmail = Uri.encodeComponent(email);
      final String url = '$endPoint/validEmail/$encodedEmail';

      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return '';
      }

      // Kiểm tra định dạng response
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse is List && jsonResponse.isNotEmpty) {
        return jsonResponse[0].toString();
      } else if (jsonResponse is Map) {
        return jsonResponse['Message'].toString();
      }
      return 'Unknown error occurred';
    } catch (e) {
      return 'Failed to validate email: $e';
    }
  }

    @override
  Future<String> validateStudentEmail({required String email}) async {
    try {
      final Map<String, String> headers = {'Content-Type': 'application/json'};

      // Encode email để tránh lỗi ký tự đặc biệt
      final String encodedEmail = Uri.encodeComponent(email);
      final String url = '$baseURL/Student/validSudentEmail/$encodedEmail';

      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return '';
      }

      // Kiểm tra định dạng response
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse is List && jsonResponse.isNotEmpty) {
        return jsonResponse[0].toString();
      } else if (jsonResponse is Map) {
        return jsonResponse['Message'].toString();
      }
      return 'Unknown error occurred';
    } catch (e) {
      return 'Failed to validate email: $e';
    }
  }

  @override
  Future<String> validateUserName({required String userName}) async {
    try {
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'text/plain',
      };

      // Encode username để tránh lỗi ký tự đặc biệt
      final String encodedUserName = Uri.encodeComponent(userName);
      final String url = '$endPoint/validUsername/$encodedUserName';

      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return '';
      }

      // Kiểm tra định dạng response
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse is List && jsonResponse.isNotEmpty) {
        return jsonResponse[0].toString();
      } else if (jsonResponse is Map) {
        return jsonResponse['Message'].toString();
      }
      return 'Unknown error occurred';
    } catch (e) {
      return 'Failed to validate username: $e';
    }
  }

  @override
  Future<String> validateStudentCode({required String studentCode}) async {
    try {
      final Map<String, String> headers = {'Content-Type': 'application/json'};

      Map<String, String> body = {'code': studentCode};

      http.Response response = await http.post(
        Uri.parse('$endPoint/code'),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return '';
      }
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse is List && jsonResponse.isNotEmpty) {
        return jsonResponse[0].toString();
      } else if (jsonResponse is Map) {
        return jsonResponse['Message'].toString();
      }
      return 'Unknown error occurred';
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<String> validatePhoneNumber({required String phoneNumber}) async {
    try {
      final Map<String, String> headers = {'Content-Type': 'application/json'};

      Map<String, String> body = {'phone': phoneNumber};

      http.Response response = await http.post(
        Uri.parse('$endPoint/phone'),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return '';
      }
      List<dynamic> jsonReponse = jsonDecode(response.body);
      String error = jsonReponse[0];
      return error;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<String> validateInviteCode({required String inviteCode}) async {
    try {
      final Map<String, String> headers = {'Content-Type': 'application/json'};

      Map<String, String> body = {'inviteCode': inviteCode};

      http.Response response = await http.post(
        Uri.parse('${baseURL}Account/validInviteCode'),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return '';
      }
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse is List && jsonResponse.isNotEmpty) {
        return jsonResponse[0].toString();
      } else if (jsonResponse is Map) {
        return jsonResponse['Message'].toString();
      }
      return 'Unknown error occurred';
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
