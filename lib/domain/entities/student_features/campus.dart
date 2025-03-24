import 'package:equatable/equatable.dart';

class Campus extends Equatable {
  final String id;
  final String universityId;
  final String universityName;
  final String areaId;
  final String areaName;
  final String campusName;
  final String openingHours;
  final String closingHours;
  final String address;
  final String phone;
  final String email;
  final String link;
  final String image;
  final String fileName;
  final String dateCreated;
  final String dateUpdated;
  final String description;
  final bool state;
  final bool status;

  Campus(
      {required this.id,
      required this.universityId,
      required this.universityName,
      required this.areaId,
      required this.areaName,
      required this.campusName,
      required this.openingHours,
      required this.closingHours,
      required this.address,
      required this.phone,
      required this.email,
      required this.link,
      required this.image,
      required this.fileName,
      required this.dateCreated,
      required this.dateUpdated,
      required this.description,
      required this.state,
      required this.status});

  @override
  List<Object?> get props => [
        this.id,
        this.universityId,
        this.universityName,
        this.areaId,
        this.areaName,
        this.campusName,
        this.openingHours,
        this.closingHours,
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
        this.status
      ];
}
