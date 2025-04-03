import 'package:equatable/equatable.dart';

class TransactResultModel extends Equatable {
  final String id;
  final String brandId;
  final String brandName;
  final String storeId;
  final String storeName;
  final String studentId;
  final String studentName;
  final double amount;
  final String dateCreated;
  final String dateUpdated;
  final String description;
  final bool state;
  final bool status;

  const TransactResultModel({
    required this.id,
    required this.brandId,
    required this.brandName,
    required this.storeId,
    required this.storeName,
    required this.studentId,
    required this.studentName,
    required this.amount,
    required this.dateCreated,
    required this.dateUpdated,
    required this.description,
    required this.state,
    required this.status,
  });

  factory TransactResultModel.fromJson(Map<String, dynamic> json) {
    return TransactResultModel(
      id: json['id'],
      brandId: json['brandId'],
      brandName: json['brandName'],
      storeId: json['storeId'],
      storeName: json['storeName'],
      studentId: json['studentId'],
      studentName: json['studentName'],
      amount: json['amount'],
      dateCreated: json['dateCreated'],
      dateUpdated: json['dateUpdated'],
      description: json['description'],
      state: json['state'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['brandId'] = brandId;
    data['brandName'] = brandName;
    data['storeId'] = storeId;
    data['storeName'] = storeName;
    data['studentId'] = studentId;
    data['studentName'] = studentName;
    data['amount'] = amount;
    data['dateCreated'] = dateCreated;
    data['dateUpdated'] = dateUpdated;
    data['description'] = description;
    data['state'] = state;
    data['status'] = status;
    return data;
  }

  @override
  List<Object?> get props => [
    id,
    brandId,
    brandName,
    storeId,
    storeName,
    studentId,
    studentName,
    amount,
    dateCreated,
    dateUpdated,
    description,
    state,
    status,
  ];
}
