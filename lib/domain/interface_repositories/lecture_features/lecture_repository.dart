import 'package:swallet_mobile/data/models/lecture_features/lecture_model.dart';

abstract class LectureRepository {
  const LectureRepository();
  Future<LectureModel?> fetchLectureById({required String accountId});

  Future<LectureModel?> putLecture({
    required String id,
    required String accountId,
    required String fullName,
    required DateTime dateCreated,
    required DateTime dateUpdated,
    required bool state,
    required bool status,
  });

  Future<Map<String, String>> generateQRCode({
    required int points,
    // required String expirationTime,
    // required String startOnTime,
    required int availableHours,
    required String lecturerId,
  });
}
