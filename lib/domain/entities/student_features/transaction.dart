import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final String id;
  final String voucherName;
  final String activityId;
  final String walletId;
  final double amount;
  final String description;
  final String createdAt;
  final bool status;

  const Transaction({
    required this.id,
    required this.voucherName,
    required this.activityId,
    required this.walletId,
    required this.amount,
    required this.description,
    required this.createdAt,
    required this.status,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      voucherName: json['voucherName'] as String,
      activityId: json['activityId'] as String,
      walletId: json['walletId'] as String,
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      createdAt: json['createdAt'] as String,
      status: json['status'] as bool,
    );
  }

  @override
  List<Object?> get props => [
        id,
        voucherName,
        activityId,
        walletId,
        amount,
        description,
        createdAt,
        status,
      ];
}