import 'package:equatable/equatable.dart';

class WishList extends Equatable {
  final String id;
  final String studentId;
  final String studentName;
  final String studentImage;
  final String brandId;
  final String brandName;
  final String brandImage;
  final String description;
  final bool state;
  final bool status;

  WishList({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.studentImage,
    required this.brandId,
    required this.brandName,
    required this.brandImage,
    required this.description,
    required this.state,
    required this.status,
  });

  @override
  List<Object?> get props => [
    this.id,
    this.studentId,
    this.studentName,
    this.studentImage,
    this.brandId,
    this.brandName,
    this.brandImage,
    this.description,
    this.state,
    this.status,
  ];
}
