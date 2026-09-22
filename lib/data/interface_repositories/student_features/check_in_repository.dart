abstract class CheckInRepository {
  Future<CheckInData> getCheckInData(String studentId);
  Future<CheckInData> checkIn(String studentId);

  /// Check-in bằng mã QR tại một địa điểm, trả về số xu được thưởng.
  ///
  /// Trước đây màn hình quét QR tự gọi thẳng `http.post` và tự khai báo lại
  /// hằng `baseUrl` ngay trong file giao diện.
  Future<int> checkInWithQr({
    required String studentId,
    required String qrCode,
    required double latitude,
    required double longitude,
  });
}

/// Lỗi check-in đã có sẵn thông báo tiếng Việt để hiển thị cho người dùng.
class CheckInException implements Exception {
  const CheckInException(this.message);

  final String message;

  @override
  String toString() => message;
}

class CheckInData {
  final List<bool> checkInHistory;
  final int streak;
  final int points;
  final bool canCheckInToday;
  final int currentDayIndex;
  final int rewardPoints; // Thêm rewardPoints

  CheckInData({
    required this.checkInHistory,
    required this.streak,
    required this.points,
    required this.canCheckInToday,
    required this.currentDayIndex,
    required this.rewardPoints, // Thêm vào constructor
  });

  factory CheckInData.fromJson(Map<String, dynamic> json) {
    return CheckInData(
      checkInHistory: List<bool>.from(json['checkInHistory']),
      streak: json['streak'],
      points: json['points'],
      canCheckInToday: json['canCheckInToday'],
      currentDayIndex: json['currentDayIndex'],
      rewardPoints:
          json['rewardPoints'] ??
          0, // Parse rewardPoints, mặc định là 0 nếu không có
    );
  }
}
