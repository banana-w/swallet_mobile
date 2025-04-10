import 'package:swallet_mobile/data/models/api_response.dart';
import 'package:swallet_mobile/data/models/student_features/campus_model.dart';

abstract class CampusRepository {
  const CampusRepository();

  Future<ApiResponse<List<CampusModel>>?> fetchCampusByUniId({
    int? page,
    required String uniId,
  });

  Future<ApiResponse<List<CampusModel>>?> fetchCampus({
    required String searchName,
    int page = 1, // Giá trị mặc định trong interface
    int size = 10, // Giá trị mặc định trong interface
  });
}
