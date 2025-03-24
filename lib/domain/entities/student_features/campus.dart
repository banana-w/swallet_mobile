import 'package:equatable/equatable.dart';

class Campus extends Equatable {
  final String id;
  final String areaId;
  final String areaName;
  final String campusName;
  final String? address;
  final String? phone;
  final String? email;
  final String? link;
  final String? image;
  final String? fileName;
  final String? dateCreated;
  final String? dateUpdated;
  final String? description;
  final bool? state;
  final bool? status;
  final int? numberOfStudents;

  const Campus({
    required this.id,
    required this.areaId,
    required this.areaName,
    required this.campusName,
    this.address,
    this.phone,
    this.email,
    this.link,
    this.image,
    this.fileName,
    this.dateCreated,
    this.dateUpdated,
    this.description,
    this.state,
    this.status,
    this.numberOfStudents,
  });

  @override
  List<Object?> get props => [
        id,
        areaId,
        areaName,
        campusName,
        address,
        phone,
        email,
        link,
        image,
        fileName,
        dateCreated,
        dateUpdated,
        description,
        state,
        status,
        numberOfStudents,
      ];
}
