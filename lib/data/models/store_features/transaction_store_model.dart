import 'package:swallet_mobile/domain/entities/store_features/transaction_store.dart';

class TransactionStoreModel extends TransactionStore {
  TransactionStoreModel({
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['studentId'] = this.studentId;
    data['studentName'] = this.studentName;
    data['activity'] = this.activity;
    data['storeId'] = this.storeId;
    data['storeName'] = this.storeName;
    data['amount'] = this.amount;
    data['rate'] = this.rate;
    data['walletId'] = this.walletId;
    data['walletTypeId'] = this.walletTypeId;
    data['walletType'] = this.walletType;
    data['walletTypeName'] = this.walletTypeName;
    data['dateCreated'] = this.dateCreated;
    data['description'] = this.description;
    data['state'] = this.state;
    data['status'] = this.status;
    return data;
  }
}
