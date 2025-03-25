import 'package:equatable/equatable.dart';

class TransactionStore extends Equatable {
  final String id;
  final String studentId;
  final String studentName;
  final String activity;
  final String storeId;
  final String storeName;
  final double amount;
  final double rate;
  final String walletId;
  final int walletTypeId;
  final String walletType;
  final String walletTypeName;
  final String dateCreated;
  final String description;
  final bool state;
  final bool status;

  const TransactionStore(
      {required this.id,
      required this.studentId,
      required this.studentName,
      required this.activity,
      required this.storeId,
      required this.storeName,
      required this.amount,
      required this.rate,
      required this.walletId,
      required this.walletTypeId,
      required this.walletType,
      required this.walletTypeName,
      required this.dateCreated,
      required this.description,
      required this.state,
      required this.status});
  @override
  List<Object?> get props => [
        id,
        studentId,
        studentName,
        activity,
        storeId,
        storeName,
        amount,
        rate,
        walletId,
        walletTypeId,
        walletType,
        walletTypeName,
        dateCreated,
        description,
        state,
        status
      ];
}
