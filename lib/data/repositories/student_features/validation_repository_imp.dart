import 'dart:convert';

import 'package:swallet_mobile/domain/interface_repositories/student_features/validation_repository.dart';

import '../../../presentation/config/constants.dart';
import 'package:http/http.dart' as http;

class ValidationRepositoryImp implements ValidationRepository {
  String endPoint = '${baseURL}validations';

  @override
  Future<String> validateEmail({required String email}) async {
    try {
      final Map<String, String> headers = {'Content-Type': 'application/json'};

      Map<String, String> body = {'email': email};

      http.Response response = await http.post(
        Uri.parse('$endPoint/email'),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        // final List<dynamic> result =
        //     jsonDecode(utf8.decode(response.bodyBytes));

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
  Future<String> validateUserName({required String userName}) async {
    try {
      final Map<String, String> headers = {'Content-Type': 'application/json'};

      Map<String, String> body = {'userName': userName};

      http.Response response = await http.post(
        Uri.parse('$endPoint/username'),
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
      List<dynamic> jsonReponse = jsonDecode(response.body);
      String error = jsonReponse[0];
      return error;
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
        Uri.parse('$endPoint/invite-code'),
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
}
