import 'package:swallet_mobile/domain/entities/store_features/transaction_store.dart';

class TransactionStoreModel extends TransactionStore {
  const TransactionStoreModel({
    required super.id,
    required super.studentId,
    required super.studentName,
    required super.activity,
    required super.storeId,
    required super.storeName,
    required super.amount,
    required super.rate,
    required super.walletId,
    required super.walletTypeId,
    required super.walletType,
    required super.walletTypeName,
    required super.dateCreated,
    required super.description,
    required super.state,
    required super.status,
  });

  factory TransactionStoreModel.fromJson(Map<String, dynamic> json) {
    return TransactionStoreModel(
      id: json['id'],
      studentId: json['studentId'],
      studentName: json['studentName'],
      activity: json['activity'],
      storeId: json['storeId'],
      storeName: json['storeName'],
      amount: json['amount'],
      rate: json['rate'],
      walletId: json['walletId'],
      walletTypeId: json['walletTypeId'],
      walletType: json['walletType'],
      walletTypeName: json['walletTypeName'],
      dateCreated: json['dateCreated'],
      description: json['description'],
      state: json['state'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['studentId'] = studentId;
    data['studentName'] = studentName;
    data['activity'] = activity;
    data['storeId'] = storeId;
    data['storeName'] = storeName;
    data['amount'] = amount;
    data['rate'] = rate;
    data['walletId'] = walletId;
    data['walletTypeId'] = walletTypeId;
    data['walletType'] = walletType;
    data['walletTypeName'] = walletTypeName;
    data['dateCreated'] = dateCreated;
    data['description'] = description;
    data['state'] = state;
    data['status'] = status;
    return data;
  }
}
