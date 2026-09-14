import 'dart:async';

import 'package:http/http.dart' as http;

import 'authen_local_datasource.dart';

/// HTTP client dùng chung cho toàn bộ repository.
///
/// Trước đây mỗi repository tự đọc token, tự dựng header `Authorization` và
/// không chỗ nào xử lý 401 — token hết hạn thì app kẹt ở trạng thái loading mà
/// người dùng không nhận được phản hồi nào. Lớp này gom cả hai việc đó về một
/// chỗ:
///
/// * gắn `Authorization: Bearer <token>` cho mọi request cần xác thực;
/// * gặp 401 thì xoá session và phát [onSessionExpired] để tầng UI đưa người
///   dùng về màn đăng nhập.
///
/// Kế thừa [http.BaseClient] nên `get/post/put/delete/send` giữ nguyên chữ ký
/// như `package:http`, repository chỉ việc đổi chỗ gọi.
class ApiClient extends http.BaseClient {
  ApiClient({
    http.Client? inner,
    bool requiresAuth = true,
    Future<String?> Function()? tokenProvider,
  }) : _inner = inner ?? http.Client(),
       _requiresAuth = requiresAuth,
       _tokenProvider = tokenProvider ?? AuthenLocalDataSource.getToken;

  /// Client cho các endpoint đã đăng nhập.
  static ApiClient instance = ApiClient();

  /// Client cho endpoint công khai: đăng nhập, đăng ký, kiểm tra trùng dữ liệu.
  /// Không gắn token và không coi 401 là hết phiên — 401 ở đây chỉ nghĩa là
  /// sai thông tin đăng nhập.
  static ApiClient public = ApiClient(requiresAuth: false);

  final http.Client _inner;
  final bool _requiresAuth;
  final Future<String?> Function() _tokenProvider;

  static final StreamController<void> _sessionExpiredController =
      StreamController<void>.broadcast();

  /// Phát sự kiện mỗi khi một request đã xác thực bị máy chủ trả 401.
  static Stream<void> get onSessionExpired =>
      _sessionExpiredController.stream;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (_requiresAuth && !request.headers.containsKey('Authorization')) {
      final token = await _tokenProvider();
      if (token != null && token.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $token';
      }
    }

    final response = await _inner.send(request);

    if (_requiresAuth && response.statusCode == 401) {
      await _handleSessionExpired();
    }
    return response;
  }

  Future<void> _handleSessionExpired() async {
    await AuthenLocalDataSource.clearAuthen();
    if (!_sessionExpiredController.isClosed) {
      _sessionExpiredController.add(null);
    }
  }

  @override
  void close() => _inner.close();

  /// Dùng trong test để tráo client giả rồi trả lại nguyên trạng.
  static void overrideForTesting({ApiClient? authenticated, ApiClient? publicClient}) {
    if (authenticated != null) instance = authenticated;
    if (publicClient != null) public = publicClient;
  }
}
