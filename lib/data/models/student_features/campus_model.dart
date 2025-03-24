import 'package:swallet_mobile/domain/entities/student_features/campus.dart';

class CampusModel extends Campus {
  CampusModel({
    required super.id,
    required super.universityId,
    required super.universityName,
    required super.areaId,
    required super.areaName,
    required super.campusName,
    required super.openingHours,
    required super.closingHours,
    required super.address,
    required super.phone,
    required super.email,
    required super.link,
    required super.image,
    required super.fileName,
    required super.dateCreated,
    required super.dateUpdated,
    required super.description,
    required super.state,
    required super.status,
  });

  factory CampusModel.fromJson(Map<String, dynamic> json) {
    return CampusModel(
      id: json['id'],
      universityId: json['universityId'],
      universityName: json['universityName'],
      areaId: json['areaId'],
      areaName: json['areaName'],
      campusName: json['campusName'],
      openingHours: json['openingHours'],
      closingHours: json['closingHours'],
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      link: json['link'] ?? '',
      image: json['image'] ?? '',
      fileName: json['fileName'] ?? '',
      dateCreated: json['dateCreated'],
      dateUpdated: json['dateUpdated'],
      description: json['description'] ?? '',
      state: json['state'] ?? '',
      status: json['status'] ?? true,
    );
  }
}
