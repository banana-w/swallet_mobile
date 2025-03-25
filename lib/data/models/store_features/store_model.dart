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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['brandId'] = brandId;
    data['brandName'] = brandName;
    data['brandLogo'] = brandLogo;
    data['areaId'] = areaId;
    data['areaName'] = areaName;
    data['areaImage'] = areaImage;
    data['accountId'] = accountId;
    data['storeName'] = storeName;
    data['userName'] = userName;
    data['avatar'] = avatar;
    data['avatarFileName'] = avatarFileName;
    data['file'] = file;
    data['fileName'] = fileName;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['openingHours'] = openingHours;
    data['closingHours'] = closingHours;
    data['dateCreated'] = dateCreated;
    data['dateUpdated'] = dateUpdated;
    data['description'] = description;
    data['state'] = state;
    data['status'] = status;
    data['numberOfCampaigns'] = numberOfCampaigns;
    data['numberOfVouchers'] = numberOfVouchers;
    data['numberOfBonuses'] = numberOfBonuses;
    data['amountOfBonuses'] = amountOfBonuses;
    return data;
  }
}
