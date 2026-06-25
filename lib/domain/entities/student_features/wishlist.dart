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

  const WishList({
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
    id,
    studentId,
    studentName,
    studentImage,
    brandId,
    brandName,
    brandImage,
    description,
    state,
    status,
  ];
}
