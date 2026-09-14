/// Lỗi có thông điệp đã sẵn sàng hiển thị cho người dùng.
///
/// Tầng repository ném [AppException]; bloc bắt đúng kiểu này để lấy
/// [message] thay vì đổ nguyên `e.toString()` ra giao diện.
sealed class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Phiên đăng nhập hết hạn hoặc token không hợp lệ (HTTP 401).
class SessionExpiredException extends AppException {
  const SessionExpiredException([
    super.message = 'Phiên đăng nhập đã hết hạn, vui lòng đăng nhập lại.',
  ]);
}

/// Tài khoản đăng nhập đúng nhưng vai trò không có giao diện trên mobile
/// (Admin, Brand hoặc một vai trò backend mới mà app chưa hỗ trợ).
class UnsupportedRoleException extends AppException {
  UnsupportedRoleException(this.rawRole)
    : super(
        'Tài khoản "$rawRole" không sử dụng được trên ứng dụng di động. '
        'Vui lòng dùng bản web.',
      );

  final String rawRole;
}

/// Máy chủ trả về mã lỗi ngoài dải thành công.
class ApiException extends AppException {
  ApiException({required this.statusCode, String? message})
    : super(message ?? 'Máy chủ trả về lỗi $statusCode.');

  final int statusCode;
}

/// Người dùng bấm đăng ký khi form nhiều bước còn thiếu dữ liệu.
class IncompleteRegistrationException extends AppException {
  IncompleteRegistrationException(this.missingFields)
    : super(
        'Thiếu thông tin đăng ký: ${missingFields.join(', ')}. '
        'Vui lòng quay lại và điền đầy đủ.',
      );

  final List<String> missingFields;
}
