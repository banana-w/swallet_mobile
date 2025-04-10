abstract class CheckInRepository {
  Future<CheckInData> getCheckInData(String studentId);
  Future<CheckInData> checkIn(String studentId);
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
