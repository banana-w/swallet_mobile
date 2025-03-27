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
    required super.currentStateId,
    required super.currentState,
    required super.currentStateName,
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
      file: json['file'] != null ? json['file'] : '',
      fileName: json['fileName'] != null ? json['fileName'] : '',
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
      currentStateId: json['currentStateId'] ?? 0,
      currentState: json['currentState'] ?? '',
      currentStateName: json['currentStateName'] ?? '',
      status: json['status'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brandId'] = this.brandId;
    data['brandName'] = this.brandName;
    data['brandAcronym'] = this.brandAcronym;
    data['typeId'] = this.typeId;
    data['typeName'] = this.typeName;
    data['campaignName'] = this.campaignName;
    data['image'] = this.image;
    data['imageName'] = this.imageName;
    data['file'] = this.file;
    data['fileName'] = this.fileName;
    data['condition'] = this.condition;
    data['link'] = this.link;
    data['startOn'] = this.startOn;
    data['endOn'] = this.endOn;
    data['duration'] = this.duration;
    data['totalIncome'] = this.totalIncome;
    data['totalSpending'] = this.totalSpending;
    data['dateCreated'] = this.dateCreated;
    data['dateUpdated'] = this.dateUpdated;
    data['description'] = this.description;
    data['currentStateId'] = this.currentStateId;
    data['currentState'] = this.currentState;
    data['currentStateName'] = this.currentStateName;
    data['status'] = this.status;
    return data;
  }
}
