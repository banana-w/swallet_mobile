import 'package:swallet_mobile/domain/interface_repositories/student_features/campaign.dart';

class CampaignDetail extends Campaign {
  final String brandLogo;
  final int numberOfItemsUsed;
  final double usageCost;
  final double totalCost;
  final String typeImage;

  CampaignDetail({
    required this.brandLogo,
    required this.numberOfItemsUsed,
    required this.totalCost,
    required this.usageCost,
    required this.typeImage,
    required super.id,
    required super.brandId,
    required super.brandName,
    required super.brandAcronym,
    required super.typeId,
    required super.typeName,
    required super.campaignName,
    required super.image,
    required super.imageName,
    required super.file,
    required super.fileName,
    required super.condition,
    required super.link,
    required super.startOn,
    required super.endOn,
    required super.duration,
    required super.totalIncome,
    required super.totalSpending,
    required super.dateCreated,
    required super.dateUpdated,
    required super.description,
    required super.status,
  });

  @override
  List<Object?> get props =>
      super.props..addAll([
        brandLogo,
        numberOfItemsUsed,
        usageCost,
        totalCost,
        typeImage,
      ]);
}
