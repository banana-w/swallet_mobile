import 'package:equatable/equatable.dart';

class Campaign extends Equatable {
  final String id;
  final String brandId;
  final String brandName;
  final String brandAcronym;
  final String typeId;
  final String typeName;
  final String campaignName;
  final String image;
  final String imageName;
  final String? file; // Nullable vì trong JSON là null
  final String? fileName; // Nullable vì trong JSON là null
  final String condition;
  final String link;
  final String startOn;
  final String endOn;
  final int duration;
  final double totalIncome;
  final double totalSpending;
  final String dateCreated;
  final String dateUpdated;
  final String description;
  final bool status;

  const Campaign({
    required this.id,
    required this.brandId,
    required this.brandName,
    required this.brandAcronym,
    required this.typeId,
    required this.typeName,
    required this.campaignName,
    required this.image,
    required this.imageName,
    this.file, // Không cần required vì nullable
    this.fileName, // Không cần required vì nullable
    required this.condition,
    required this.link,
    required this.startOn,
    required this.endOn,
    required this.duration,
    required this.totalIncome,
    required this.totalSpending,
    required this.dateCreated,
    required this.dateUpdated,
    required this.description,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        brandId,
        brandName,
        brandAcronym,
        typeId,
        typeName,
        campaignName,
        image,
        imageName,
        file,
        fileName,
        condition,
        link,
        startOn,
        endOn,
        duration,
        totalIncome,
        totalSpending,
        dateCreated,
        dateUpdated,
        description,
        status,
      ];
}
