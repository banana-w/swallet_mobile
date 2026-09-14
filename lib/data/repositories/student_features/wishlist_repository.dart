import 'dart:convert';
import 'package:swallet_mobile/data/interface_repositories/student_features/wishlist_repository.dart';
import 'package:swallet_mobile/data/models/api_response.dart';
import 'package:swallet_mobile/data/models/student_features/wishlist_model.dart';

import '../../../presentation/config/constants.dart';
import '../../datasource/authen_local_datasource.dart';
import 'package:http/http.dart' as http;
import 'package:swallet_mobile/data/datasource/api_client.dart';
import 'package:swallet_mobile/data/datasource/api_exceptions.dart';

class WishListRepositoryImp extends WishListRepository {
  /// Cho phep test tiem client gia; app dung client dung chung.
  WishListRepositoryImp({ApiClient? api}) : _api = api ?? ApiClient.instance;

  final ApiClient _api;

  String endPoint = '${baseURL}Wishlist';
  String sort = 'Id%2Cdesc';
  int page = 1;
  int limit = 10;
  String? token;
  bool state = true;

  @override
  Future<ApiResponse<List<WishListModel>>?> fetchWishLists({
    int? page,
    int? limit,
  }) async {
    try {
      token = await AuthenLocalDataSource.getToken();
      final studentId = await AuthenLocalDataSource.getStudentId();
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      http.Response response = await _api.get(
        Uri.parse('$endPoint?studentIds=$studentId&page=1&size=10'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        ApiResponse<List<WishListModel>> apiResponse =
            ApiResponse<List<WishListModel>>.fromJson(
              result,
              (data) => data.map((e) => WishListModel.fromJson(e)).toList(),
            );
        return apiResponse;
      } else {
        return null;
      }
    } on AppException {
      rethrow; // loi da co thong diep cho nguoi dung
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<WishListModel?> postWishList({
    required String studentId,
    required String brandId,
    required String description,
    required bool state,
  }) async {
    try {
      token = await AuthenLocalDataSource.getToken();
      Map body = {
        'studentId': studentId,
        'brandId': brandId,
        'description': "Được yêu thích",
        'state': state,
      };
      http.Request req = http.Request('Post', Uri.parse(endPoint));

      req.headers['Content-Type'] = 'application/json';
      req.headers['Authorization'] = 'Bearer $token';
      req.body = jsonEncode(body);
      final streamedResponse = await _api.send(req);
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        WishListModel wishList = WishListModel.fromJson(result);
        if (!wishList.status) {
          await AuthenLocalDataSource.saveUnsubcribeWishListId(
            wishList.brandId,
          );
        }
        return wishList;
      } else {
        return null;
      }
    } on AppException {
      rethrow; // loi da co thong diep cho nguoi dung
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
