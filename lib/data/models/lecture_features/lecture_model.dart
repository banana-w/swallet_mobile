import 'package:equatable/equatable.dart'; // Optional: Dùng Equatable để so sánh object

class LectureModel extends Equatable {
  final String id;
  final String accountId;
  final String fullName;
  final DateTime dateCreated;
  final DateTime dateUpdated;
  final bool state;
  final bool status;

  const LectureModel({
    required this.id,
    required this.accountId,
    required this.fullName,
    required this.dateCreated,
    required this.dateUpdated,
    required this.state,
    required this.status,
  });

  // Parse từ JSON
  factory LectureModel.fromJson(Map<String, dynamic> json) {
    return LectureModel(
      id: json['id'] as String,
      accountId: json['accountId'] as String,
      fullName: json['fullName'] as String,
      dateCreated: DateTime.parse(json['dateCreated'] as String),
      dateUpdated: DateTime.parse(json['dateUpdated'] as String),
      state: json['state'] as bool,
      status: json['status'] as bool,
    );
  }

  // Chuyển thành JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountId': accountId,
      'fullName': fullName,
      'dateCreated': dateCreated.toIso8601String(),
      'dateUpdated': dateUpdated.toIso8601String(),
      'state': state,
      'status': status,
    };
  }

  // Dùng Equatable để so sánh object (optional)
  @override
  List<Object> get props => [
    id,
    accountId,
    fullName,
    dateCreated,
    dateUpdated,
    state,
    status,
  ];

  // Tùy chọn: Thêm toString để debug dễ hơn
  @override
  String toString() {
    return 'LectureModel(id: $id, accountId: $accountId, fullName: $fullName, dateCreated: $dateCreated, dateUpdated: $dateUpdated, state: $state, status: $status)';
  }
}
