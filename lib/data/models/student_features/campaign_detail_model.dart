import 'package:swallet_mobile/domain/entities/student_features/campaign_detail.dart';

class CampaignDetailModel extends CampaignDetail {
  CampaignDetailModel({
    required super.brandLogo,
    required super.numberOfItemsUsed,
    required super.totalCost,
    required super.usageCost,
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
    required super.typeImage,
  });

  factory CampaignDetailModel.fromJson(Map<String, dynamic> json) {
    return CampaignDetailModel(
      id: json['id'],
      brandId: json['brandId'],
      brandName: json['brandName'] ?? '',
      brandAcronym: json['brandAcronym'] ?? '',
      brandLogo: json['brandLogo'] ?? '',
      typeId: json['typeId'],
      typeName: json['typeName'] ?? '',
      typeImage: json['typeImage'] ?? '',
      campaignName: json['campaignName'] ?? '',
      image: json['image'] ?? '',
      imageName: json['imageName'] ?? '',
      file: json['file'] ?? '',
      fileName: json['fileName'] ?? '',
      condition: json['condition'] ?? '',
      link: json['link'] ?? '',
      startOn: json['startOn'] ?? '',
      endOn: json['endOn'] ?? '',
      duration: json['duration'],
      totalIncome: json['totalIncome'] ?? 0,
      totalSpending: json['totalSpending'] ?? 0,
      dateCreated: json['dateCreated'],
      dateUpdated: json['dateUpdated'],
      description: json['description'],
      status: json['status'],
      numberOfItemsUsed: json['numberOfItemsUsed'],
      usageCost: json['usageCost'],
      totalCost: json['totalCost'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['brandId'] = brandId;
    data['brandName'] = brandName;
    data['brandAcronym'] = brandAcronym;
    data['brandLogo'] = brandLogo;
    data['typeId'] = typeId;
    data['typeName'] = typeName;
    data['typeImage'] = typeImage;
    data['campaignName'] = campaignName;
    data['image'] = image;
    data['imageName'] = imageName;
    data['file'] = file;
    data['fileName'] = fileName;
    data['condition'] = condition;
    data['link'] = link;
    data['startOn'] = startOn;
    data['endOn'] = endOn;
    data['duration'] = duration;
    data['totalIncome'] = totalIncome;
    data['totalSpending'] = totalSpending;
    data['dateCreated'] = dateCreated;
    data['dateUpdated'] = dateUpdated;
    data['description'] = description;
    data['status'] = status;
    data['numberOfItemsUsed'] = numberOfItemsUsed;
    data['usageCost'] = usageCost;
    data['totalCost'] = totalCost;
    return data;
  }
}
