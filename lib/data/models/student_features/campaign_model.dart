import 'package:swallet_mobile/domain/interface_repositories/student_features/campaign.dart';

class CampaignModel extends Campaign {
  CampaignModel({
    required super.id,
    required super.brandId,
    required super.brandName,
    required super.brandAcronym,
    required super.typeId,
    required super.typeName,
    required super.campaignName,
    required super.image,
    required super.imageName,
    super.file,
    super.fileName,
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

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    return CampaignModel(
      id: json['id'],
      brandId: json['brandId'] ?? '',
      brandName: json['brandName'] ?? '',
      brandAcronym: json['brandAcronym'] ?? '',
      typeId: json['typeId'] ?? '',
      typeName: json['typeName'] ?? '',
      campaignName: json['campaignName'] ?? '',
      image: json['image'] ?? '',
      imageName: json['imageName'] ?? '',
      file: json['file'] ?? '',
      fileName: json['fileName'] ?? '',
      condition: json['condition'] ?? '',
      link: json['link'] ?? '',
      startOn: json['startOn'] ?? '',
      endOn: json['endOn'] ?? '',
      duration: json['duration'] ?? 0,
      totalIncome: json['totalIncome'] ?? 0,
      totalSpending: json['totalSpending'] ?? 0,
      dateCreated: json['dateCreated'] ?? '',
      dateUpdated: json['dateUpdated'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['brandId'] = brandId;
    data['brandName'] = brandName;
    data['brandAcronym'] = brandAcronym;
    data['typeId'] = typeId;
    data['typeName'] = typeName;
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
    return data;
  }
}
