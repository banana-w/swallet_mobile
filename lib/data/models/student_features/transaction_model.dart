import 'package:swallet_mobile/domain/entities/student_features/transaction.dart';

class TransactionModel extends Transaction {
  const TransactionModel({
    required super.id,
    required super.voucherName,
    required super.activityId,
    required super.walletId,
    required super.amount,
    required super.description,
    required super.createdAt,
    required super.status,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['voucherName'] = voucherName;
    data['activityId'] = activityId;
    data['walletId'] = walletId;
    data['amount'] = amount;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['status'] = status;
    return data;
  }
}