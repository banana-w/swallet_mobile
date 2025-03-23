import 'package:equatable/equatable.dart';

class Student extends Equatable {
  final String id;
  final String? campusId; // nullable vì API trả về null
  final String accountId;
  final String studentCardFront;
  final String? fileNameFront; // nullable vì API trả về null
  final String? studentCardBack; // nullable vì API trả về null
  final String? fileNameBack; // nullable vì API trả về null
  final String fullName;
  final String? code; // nullable vì API trả về null
  final int? gender; // nullable vì API trả về null
  final String dateOfBirth;
  final String address;
  final double totalIncome;
  final double totalSpending;
  final String dateCreated;
  final String dateUpdated;
  final int state; // thay đổi từ String thành int để khớp với API
  final bool status;

  Student({
    required this.id,
    this.campusId, // không required vì có thể null
    required this.accountId,
    required this.studentCardFront,
    this.fileNameFront, // không required vì có thể null
    this.studentCardBack, // không required vì có thể null
    this.fileNameBack, // không required vì có thể null
    required this.fullName,
    this.code, // không required vì có thể null
    this.gender, // không required vì có thể null
    required this.dateOfBirth,
    required this.address,
    required this.totalIncome,
    required this.totalSpending,
    required this.dateCreated,
    required this.dateUpdated,
    required this.state,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id,
    campusId,
    accountId,
    studentCardFront,
    fileNameFront,
    studentCardBack,
    fileNameBack,
    fullName,
    code,
    gender,
    dateOfBirth,
    address,
    totalIncome,
    totalSpending,
    dateCreated,
    dateUpdated,
    state,
    status,
  ];
}
