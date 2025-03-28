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

  TransactResultModel({
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brandId'] = this.brandId;
    data['brandName'] = this.brandName;
    data['storeId'] = this.storeId;
    data['storeName'] = this.storeName;
    data['studentId'] = this.studentId;
    data['studentName'] = this.studentName;
    data['amount'] = this.amount;
    data['dateCreated'] = this.dateCreated;
    data['dateUpdated'] = this.dateUpdated;
    data['description'] = this.description;
    data['state'] = this.state;
    data['status'] = this.status;
    return data;
  }

  @override
  List<Object?> get props => [
    this.id,
    this.brandId,
    this.brandName,
    this.storeId,
    this.storeName,
    this.studentId,
    this.studentName,
    this.amount,
    this.dateCreated,
    this.dateUpdated,
    this.description,
    this.state,
    this.status,
  ];
}
