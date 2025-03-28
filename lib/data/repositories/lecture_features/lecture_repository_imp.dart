import 'package:http/http.dart' as http;
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/lecture_features/lecture_model.dart';
import 'package:swallet_mobile/domain/interface_repositories/lecture_features/lecture_repository.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'dart:convert';

class LectureRepositoryImp implements LectureRepository {
  String endPoint = '${baseURL}Lecture/';
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
        Uri.parse('$endPoint/account/$accountId'),
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
