import 'package:swallet_mobile/domain/entities/student_features/campaign_store.dart';

class CampaignStoreModel extends CampaignStore {
  const CampaignStoreModel({
    required super.id,
    required super.brandId,
    required super.brandName,
    super.brandLogo, // Thêm từ JSON, nullable
    required super.areaId,
    required super.areaName,
    super.areaImage, // Thêm từ JSON, nullable
    required super.accountId,
    required super.storeName,
    required super.userName,
    super.avatar, // Nullable, không required
    super.avatarFileName, // Nullable, không required
    super.file, // Thêm từ JSON, nullable
    super.fileName, // Thêm từ JSON, nullable
    required super.email,
    required super.phone,
    required super.address,
    super.openingHours, // Nullable, không required
    super.closingHours, // Nullable, không required
    required super.dateCreated,
    required super.dateUpdated,
    required super.description,
    required super.state,
    required super.status,
  });

  factory CampaignStoreModel.fromJson(Map<String, dynamic> json) {
    return CampaignStoreModel(
      id: json['id'] as String,
      brandId: json['brandId'] as String,
      brandName: json['brandName'] as String,
      brandLogo: json['brandLogo'] as String?,
      areaId: json['areaId'] as String,
      areaName: json['areaName'] as String,
      areaImage: json['areaImage'] as String?,
      accountId: json['accountId'] as String,
      storeName: json['storeName'] as String,
      userName: json['userName'] as String? ?? '', // Giá trị mặc định nếu null
      avatar: json['avatar'] as String?, // Không cần giá trị mặc định vì nullable
      avatarFileName: json['avatarFileName'] as String?, // Không cần giá trị mặc định
      file: json['file'] as String?,
      fileName: json['fileName'] as String?,
      email: json['email'] as String? ?? '', // Giá trị mặc định nếu null
      phone: json['phone'] as String? ?? '', // Giá trị mặc định nếu null
      address: json['address'] as String? ?? '', // Giá trị mặc định nếu null
      openingHours: json['openingHours'] as String?, // Không cần giá trị mặc định
      closingHours: json['closingHours'] as String?, // Không cần giá trị mặc định
      dateCreated: json['dateCreated'] as String? ?? '', // Giá trị mặc định nếu null
      dateUpdated: json['dateUpdated'] as String? ?? '', // Giá trị mặc định nếu null
      description: json['description'] as String? ?? '', // Giá trị mặc định nếu null
      state: json['state'] as bool,
      status: json['status'] as bool,
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
    return data;
  }
}