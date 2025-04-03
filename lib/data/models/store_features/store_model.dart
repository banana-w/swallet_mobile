import 'package:swallet_mobile/domain/entities/store_features/store.dart';

class StoreModel extends Store {
  const StoreModel({
    required super.id,
    required super.brandId,
    required super.brandName,
    required super.brandLogo, // Giá trị mặc định không null
    required super.areaId,
    required super.areaName,
    required super.areaImage, // Giá trị mặc định không null
    required super.accountId,
    required super.storeName,
    required super.userName,
    required super.avatar, // Giá trị mặc định không null
    required super.avatarFileName, // Giá trị mặc định không null
    required super.file, // Giá trị mặc định không null
    required super.fileName, // Giá trị mặc định không null
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
    required super.numberOfCampaigns, // Giá trị mặc định không null
    required super.numberOfVouchers, // Giá trị mặc định không null
    required super.numberOfBonuses, // Giá trị mặc định không null
    required super.amountOfBonuses, // Giá trị mặc định không null
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'] as String,
      brandId: json['brandId'] as String,
      brandName: json['brandName'] as String,
      brandLogo: json['brandLogo'] as String? ?? 'assets/images/bean_logo.jpg',
      areaId: json['areaId'] as String,
      areaName: json['areaName'] as String,
      areaImage: json['areaImage'] as String? ?? 'assets/images/bean_logo.jpg',
      accountId: json['accountId'] as String,
      storeName: json['storeName'] as String,
      userName: json['userName'] as String,
      avatar: json['avatar'] as String? ?? 'assets/images/bean_logo.jpg',
      avatarFileName: json['avatarFileName'] as String? ?? 'bean_logo.jpg',
      file: json['file'] as String? ?? 'bean_logo.jpg',
      fileName: json['fileName'] as String? ?? 'bean_logo.jpg',
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      openingHours: json['openingHours'] as String,
      closingHours: json['closingHours'] as String,
      dateCreated: json['dateCreated'] as String,
      dateUpdated: json['dateUpdated'] as String,
      description: json['description'] as String,
      state: json['state'] as bool,
      status: json['status'] as bool,
      numberOfCampaigns:
          json['numberOfCampaigns'] as int? ?? 0, // Giá trị null thì dùng 0
      numberOfVouchers:
          json['numberOfVouchers'] as int? ?? 0, // Giá trị null thì dùng 0
      numberOfBonuses:
          json['numberOfBonuses'] as int? ?? 0, // Giá trị null thì dùng 0
      amountOfBonuses:
          (json['amountOfBonuses'] as num?)?.toDouble() ??
          0.0, // Giá trị null thì dùng 0.0
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
