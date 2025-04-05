class QRCodeHistory {
  final String id; // Sử dụng String cho Ulid
  final String lecturerId;
  final int points;
  final DateTime startOnTime;
  final DateTime expirationTime;
  final String qrCodeData;
  final String qrCodeImageUrl;
  final DateTime createdAt;

  QRCodeHistory({
    required this.id,
    required this.lecturerId,
    required this.points,
    required this.startOnTime,
    required this.expirationTime,
    required this.qrCodeData,
    required this.qrCodeImageUrl,
    required this.createdAt,
  });

  factory QRCodeHistory.fromJson(Map<String, dynamic> json) {
    return QRCodeHistory(
      id: json['id'] as String,
      lecturerId: json['lecturerId'] as String,
      points: json['points'] as int,
      startOnTime: DateTime.parse(json['startOnTime'] as String),
      expirationTime: DateTime.parse(json['expirationTime'] as String),
      qrCodeData: json['qrCodeData'] as String,
      qrCodeImageUrl: json['qrCodeImageUrl'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lecturerId': lecturerId,
      'points': points,
      'startOnTime': startOnTime.toIso8601String(),
      'expirationTime': expirationTime.toIso8601String(),
      'qrCodeData': qrCodeData,
      'qrCodeImageUrl': qrCodeImageUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
