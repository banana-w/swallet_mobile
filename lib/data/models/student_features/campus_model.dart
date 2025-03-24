import 'package:swallet_mobile/domain/entities/student_features/campus.dart';

class CampusModel extends Campus {
  const CampusModel({
    required super.id,
    required super.areaId,
    required super.areaName,
    required super.campusName,
    super.address,
    super.phone,
    super.email,
    super.link,
    super.image,
    super.fileName,
    super.dateCreated,
    super.dateUpdated,
    super.description,
    super.state,
    super.status,
    super.numberOfStudents,
  });

  factory CampusModel.fromJson(Map<String, dynamic> json) {
    return CampusModel(
      id: json['id'],
      areaId: json['areaId'],
      areaName: json['areaName'],
      campusName: json['campusName'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      link: json['link'],
      image: json['image'],
      fileName: json['fileName'],
      dateCreated: json['dateCreated'],
      dateUpdated: json['dateUpdated'],
      description: json['description'],
      state: json['state'],
      status: json['status'],
      numberOfStudents: json['numberOfStudents'],
    );
  }
}
