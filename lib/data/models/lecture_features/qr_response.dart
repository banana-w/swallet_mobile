class ScanQRResponse {
  final String studentId;
  final int pointsTransferred;
  final int newBalance;

  ScanQRResponse({
    required this.studentId,
    required this.pointsTransferred,
    required this.newBalance,
  });

  factory ScanQRResponse.fromJson(Map<String, dynamic> json) {
    return ScanQRResponse(
      studentId: json['studentId'] as String,
      pointsTransferred: json['pointsTransferred'] as int,
      newBalance: json['newBalance'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'pointsTransferred': pointsTransferred,
      'newBalance': newBalance,
    };
  }
}
