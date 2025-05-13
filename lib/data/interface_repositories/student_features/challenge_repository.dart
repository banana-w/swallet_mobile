import 'package:swallet_mobile/data/models/api_response.dart';
import 'package:swallet_mobile/data/models/student_features/challenge_model.dart';
import 'package:swallet_mobile/data/models/student_features/location_model.dart';

abstract class ChallengeRepository {
  const ChallengeRepository();

  Future<ApiResponse<List<ChallengeModel>>?> fecthChallenges({int? page, int? limit});
  Future<ApiResponse<List<ChallengeModel>>?> fecthDailyChallenges({int? page, int? limit});
  Future<List<LocationModel>?> fetchLocation();
}
