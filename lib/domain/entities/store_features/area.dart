import 'package:equatable/equatable.dart';

class Area extends Equatable {
  final String id;
  final String areaName;
  final String image;
  final String fileName;
  final String address;
  final String dateCreated;
  final String dateUpdated;
  final String description;
  final bool state;
  final bool status;

  Area({
    required this.id,
    required this.areaName,
    required this.image,
    required this.fileName,
    required this.address,
    required this.dateCreated,
    required this.dateUpdated,
    required this.description,
    required this.state,
    required this.status,
  });

  @override
  List<Object?> get props => [
    this.id,
    this.areaName,
    this.image,
    this.fileName,
    this.address,
    this.dateCreated,
    this.dateUpdated,
    this.description,
    this.state,
    this.status,
  ];
}
