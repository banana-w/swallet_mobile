import 'package:swallet_mobile/domain/entities/student_features/campaign_store.dart';

class CampaignStoreModel extends CampaignStore {
  CampaignStoreModel({
    required super.id,
    required super.brandId,
    required super.brandName,
    required super.areaId,
    required super.areaName,
    required super.accountId,
    required super.storeName,
    required super.userName,
    required super.avatar,
    required super.avatarFileName,
    required super.email,
    required super.phone,
    required super.address,
    required super.openingHours,
    required super.closingHours,
    required super.dateCreated,
    required super.dateUpdated,
    required super.description,
    required super.state,
    required super.status,
  });

  factory CampaignStoreModel.fromJson(Map<String, dynamic> json) {
    return CampaignStoreModel(
      id: json['id'],
      brandId: json['brandId'],
      brandName: json['brandName'],
      areaId: json['areaId'],
      areaName: json['areaName'],
      accountId: json['accountId'],
      storeName: json['storeName'],
      userName: json['userName'] ?? '',
      avatar: json['avatar'] ?? '',
      avatarFileName: json['avatarFileName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      openingHours: json['openingHours'],
      closingHours: json['closingHours'],
      dateCreated: json['dateCreated'] ?? '',
      dateUpdated: json['dateUpdated'] ?? '',
      description: json['description'] ?? '',
      state: json['state'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brandId'] = this.brandId;
    data['brandName'] = this.brandName;
    data['areaId'] = this.areaId;
    data['areaName'] = this.areaName;
    data['accountId'] = this.accountId;
    data['storeName'] = this.storeName;
    data['userName'] = this.userName;
    data['avatar'] = this.avatar;
    data['avatarFileName'] = this.avatarFileName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['openingHours'] = this.openingHours;
    data['closingHours'] = this.closingHours;
    data['dateCreated'] = this.dateCreated;
    data['dateUpdated'] = this.dateUpdated;
    data['description'] = this.description;
    data['state'] = this.state;
    data['status'] = this.status;
    return data;
  }
}
