// ignore_for_file: must_be_immutable

import 'package:swallet_mobile/domain/entities.dart';
import 'package:swallet_mobile/domain/entities/student_features/student.dart';

class StudentModel extends Student {
  StudentModel({
    required super.id,
    super.campusId, // nullable
    required super.accountId,
    required super.studentCardFront,
    super.fileNameFront, // nullable
    super.studentCardBack, // nullable
    super.fileNameBack, // nullable
    required super.fullName,
    super.code, // nullable
    super.gender, // nullable
    required super.dateOfBirth,
    required super.address,
    required super.totalIncome,
    required super.totalSpending,
    required super.dateCreated,
    required super.dateUpdated,
    required super.state, // int
    required super.status,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'] as String,
      campusId: json['campusId'] as String?,
      accountId: json['accountId'] as String,
      studentCardFront: json['studentCardFront'] as String,
      fileNameFront: json['fileNameFront'] as String?,
      studentCardBack: json['studentCardBack'] as String?,
      fileNameBack: json['fileNameBack'] as String?,
      fullName: json['fullName'] as String,
      code: json['code'] as String?,
      gender: json['gender'] as int?,
      dateOfBirth: json['dateOfBirth'] as String,
      address: json['address'] as String,
      totalIncome: (json['totalIncome'] as num).toDouble(),
      totalSpending: (json['totalSpending'] as num).toDouble(),
      dateCreated: json['dateCreated'] as String,
      dateUpdated: json['dateUpdated'] as String,
      state: json['state'] as int,
      status: json['status'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['campusId'] = campusId;
    data['accountId'] = accountId;
    data['studentCardFront'] = studentCardFront;
    data['fileNameFront'] = fileNameFront;
    data['studentCardBack'] = studentCardBack;
    data['fileNameBack'] = fileNameBack;
    data['fullName'] = fullName;
    data['code'] = code;
    data['gender'] = gender;
    data['dateOfBirth'] = dateOfBirth;
    data['address'] = address;
    data['totalIncome'] = totalIncome;
    data['totalSpending'] = totalSpending;
    data['dateCreated'] = dateCreated;
    data['dateUpdated'] = dateUpdated;
    data['state'] = state;
    data['status'] = status;
    return data;
  }
}
