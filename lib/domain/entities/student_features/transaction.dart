import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final String id;
  final String name;
  final String transId;
  final String walletId;
  final double amount;
  final String description;
  final String createdAt;
  final bool status;

  const Transaction({
    required this.id,
    required this.name,
    required this.transId,
    required this.walletId,
    required this.amount,
    required this.description,
    required this.createdAt,
    required this.status,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      name: json['name'] as String,
      transId: json['transId'] as String,
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
        name,
        transId,
        walletId,
        amount,
        description,
        createdAt,
        status,
      ];
}