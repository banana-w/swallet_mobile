import 'package:swallet_mobile/data/models/api_response.dart';
import 'package:swallet_mobile/data/models/student_features/wishlist_model.dart';

abstract class WishListRepository {
  const WishListRepository();

  Future<ApiResponse<List<WishListModel>>?> fetchWishLists({
    int? page,
    int? limit,
  });

  Future<WishListModel?> postWishList({
    required String studentId,
    required String brandId,
    required String description,
    required bool state,
  });
}
