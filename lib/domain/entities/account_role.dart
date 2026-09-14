/// Vai trò của tài khoản trong hệ thống.
///
/// Backend trả `role` là chuỗi hiển thị tiếng Việt ('Sinh viên', 'Giáo
/// viên', ...). Chuỗi đó chỉ được phép hiểu đúng MỘT lần tại đây, phần còn lại
/// của app so sánh bằng enum. Việc này xử lý luôn hai lỗi mà cách so sánh chuỗi
/// trực tiếp mắc phải:
///
/// 1. Vai trò lạ (Admin, Brand) rơi vào nhánh `else` và được cấp quyền Cửa hàng.
/// 2. Cùng một chữ "Giáo viên" nhưng file này lưu dạng NFC (á = U+00E1), file
///    kia lưu dạng NFD (a + U+0301) nên `==`/`contains` trả về false dù nhìn
///    bằng mắt là giống hệt. [_normalize] khử dấu về ASCII nên cả hai dạng —
///    và cả chuỗi không dấu — đều khớp.
enum AccountRole {
  student,
  lecturer,
  store,
  brand,
  admin,
  unknown;

  static AccountRole fromApi(String? raw) {
    final value = _normalize(raw ?? '');
    if (value.isEmpty) return AccountRole.unknown;

    if (_matchesAny(value, const ['sinh vien', 'student'])) {
      return AccountRole.student;
    }
    if (_matchesAny(value, const [
      'giao vien',
      'giang vien',
      'lecturer',
      'teacher',
    ])) {
      return AccountRole.lecturer;
    }
    if (_matchesAny(value, const ['admin', 'quan tri'])) {
      return AccountRole.admin;
    }
    if (_matchesAny(value, const ['brand', 'thuong hieu', 'nhan hang'])) {
      return AccountRole.brand;
    }
    if (_matchesAny(value, const [
      'cua hang',
      'store',
      'merchant',
      'shop',
    ])) {
      return AccountRole.store;
    }
    return AccountRole.unknown;
  }

  static bool _matchesAny(String value, List<String> keys) =>
      keys.any(value.contains);

  /// Chuyển về chữ thường không dấu, chấp nhận cả NFC lẫn NFD.
  static String _normalize(String input) {
    final buffer = StringBuffer();
    for (final rune in input.trim().toLowerCase().runes) {
      // Dấu tổ hợp của dạng NFD (U+0300..U+036F) -> bỏ hẳn.
      if (rune >= 0x0300 && rune <= 0x036F) continue;
      buffer.write(_asciiFolding[rune] ?? String.fromCharCode(rune));
    }
    return buffer.toString();
  }

  static final Map<int, String> _asciiFolding = _buildAsciiFolding();

  static Map<int, String> _buildAsciiFolding() {
    const groups = <String, String>{
      'a': 'àáảãạăằắẳẵặâầấẩẫậ',
      'e': 'èéẻẽẹêềếểễệ',
      'i': 'ìíỉĩị',
      'o': 'òóỏõọôồốổỗộơờớởỡợ',
      'u': 'ùúủũụưừứửữự',
      'y': 'ỳýỷỹỵ',
      'd': 'đ',
    };
    final folding = <int, String>{};
    groups.forEach((ascii, accented) {
      for (final rune in accented.runes) {
        folding[rune] = ascii;
      }
    });
    return folding;
  }

  /// Ba vai trò có giao diện riêng trên app. Admin và Brand chỉ dùng trên web
  /// nên phải bị chặn ngay ở bước đăng nhập.
  bool get isSupportedOnMobile =>
      this == AccountRole.student ||
      this == AccountRole.lecturer ||
      this == AccountRole.store;
}
