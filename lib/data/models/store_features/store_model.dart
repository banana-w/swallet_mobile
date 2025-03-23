import 'package:swallet_mobile/domain/entities/store_features/store.dart';

class StoreModel extends Store {
  StoreModel({
    required super.id,
    required super.brandId,
    required super.brandName,
    required super.brandLogo,
    required super.areaId,
    required super.areaName,
    required super.areaImage,
    required super.accountId,
    required super.storeName,
    required super.userName,
    required super.avatar,
    required super.avatarFileName,
    required super.file,
    required super.fileName,
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
    required super.numberOfCampaigns,
    required super.numberOfVouchers,
    required super.numberOfBonuses,
    required super.amountOfBonuses,
  });
  factory StoreModel.fromJson(Map<String, dynamic> json) {
    double amountOfBonuses = 0;
    if (json['amountOfBonuses'] != 0) {
      amountOfBonuses = json['amountOfBonuses'];
    }

    return StoreModel(
      id: json['id'],
      brandId: json['brandId'],
      brandName: json['brandName'],
      brandLogo: json['brandLogo'] ?? '',
      areaId: json['areaId'],
      areaName: json['areaName'] ?? '',
      areaImage: json['areaImage'] ?? '',
      accountId: json['accountId'] ?? '',
      storeName: json['storeName'] ?? '',
      userName: json['userName'] ?? '',
      avatar: json['avatar'] ?? '',
      avatarFileName: json['avatarFileName'] ?? '',
      file: json['file'] ?? '',
      fileName: json['fileName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      openingHours: json['openingHours'] ?? '',
      closingHours: json['closingHours'] ?? '',
      dateCreated: json['dateCreated'] ?? '',
      dateUpdated: json['dateUpdated'] ?? '',
      description: json['description'] ?? '',
      state: json['state'],
      status: json['status'],
      numberOfCampaigns: json['numberOfCampaigns'],
      numberOfVouchers: json['numberOfVouchers'],
      numberOfBonuses: json['numberOfBonuses'],
      amountOfBonuses: amountOfBonuses,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brandId'] = this.brandId;
    data['brandName'] = this.brandName;
    data['brandLogo'] = this.brandLogo;
    data['areaId'] = this.areaId;
    data['areaName'] = this.areaName;
    data['areaImage'] = this.areaImage;
    data['accountId'] = this.accountId;
    data['storeName'] = this.storeName;
    data['userName'] = this.userName;
    data['avatar'] = this.avatar;
    data['avatarFileName'] = this.avatarFileName;
    data['file'] = this.file;
    data['fileName'] = this.fileName;
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
    data['numberOfCampaigns'] = this.numberOfCampaigns;
    data['numberOfVouchers'] = this.numberOfVouchers;
    data['numberOfBonuses'] = this.numberOfBonuses;
    data['amountOfBonuses'] = this.amountOfBonuses;
    return data;
  }
}
