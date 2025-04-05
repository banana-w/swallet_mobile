import 'package:equatable/equatable.dart'; // Optional: Dùng Equatable để so sánh object

class LectureModel extends Equatable {
  final String id;
  final String accountId;
  final String fullName;
  final String email;
  final String phone;
  final List<String> campusName;
  final double balance;
  final DateTime? dateCreated;
  final DateTime? dateUpdated;
  final bool? state;
  final bool? status;

  const LectureModel({
    required this.id,
    required this.accountId,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.campusName,
    required this.balance,
    this.dateCreated,
    this.dateUpdated,
    this.state,
    this.status,
  });

  // Parse từ JSON
  factory LectureModel.fromJson(Map<String, dynamic> json) {
    return LectureModel(
      id: json['id'] as String,
      accountId: json['accountId'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      campusName: (json['campusName'] as List<dynamic>).cast<String>(),
      balance: (json['balance'] as num).toDouble(),
      dateCreated:
          json['dateCreated'] != null
              ? DateTime.parse(json['dateCreated'] as String)
              : null,
      dateUpdated:
          json['dateUpdated'] != null
              ? DateTime.parse(json['dateUpdated'] as String)
              : null,
      state: json['state'] as bool?,
      status: json['status'] as bool?,
    );
  }

  // Chuyển thành JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountId': accountId,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'campusName': campusName,
      'balance': balance,
      'dateCreated': dateCreated?.toIso8601String(),
      'dateUpdated': dateUpdated?.toIso8601String(),
      'state': state,
      'status': status,
    };
  }

  // Dùng Equatable để so sánh object (optional)
  @override
  List<Object?> get props => [
    id,
    accountId,
    fullName,
    email,
    phone,
    campusName,
    balance,
    dateCreated,
    dateUpdated,
    state,
    status,
  ];

  // Tùy chọn: Thêm toString để debug dễ hơn
  @override
  String toString() {
    return 'LectureModel(id: $id, accountId: $accountId, fullName: $fullName, email: $email, phone: $phone, campusName: $campusName, balance: $balance, dateCreated: $dateCreated, dateUpdated: $dateUpdated, state: $state, status: $status)';
  }
}
