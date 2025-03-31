import 'package:swallet_mobile/domain/entities/student_features/campaign_voucher.dart';

class CampaignVoucherModel extends CampaignVoucher {
  const CampaignVoucherModel({
    required super.id,
    required super.brandId,
    required super.brandName,
    required super.typeId,
    required super.typeName,
    required super.voucherName,
    required super.price,
    required super.rate,
    required super.condition,
    required super.image,
    required super.imageName,
    super.file, // Nullable
    super.fileName, // Nullable
    required super.dateCreated,
    required super.dateUpdated,
    required super.description,
    required super.state,
    required super.status,
    required super.numberOfItems,
    super.numberOfItemsAvailable, // Nullable
  });

  factory CampaignVoucherModel.fromJson(Map<String, dynamic> json) {
    return CampaignVoucherModel(
      id: json['id'] as String,
      brandId: json['brandId'] as String,
      brandName: json['brandName'] as String,
      typeId: json['typeId'] as String,
      typeName: json['typeName'] as String,
      voucherName: json['voucherName'] as String,
      price: (json['price'] as num).toDouble(),
      rate: (json['rate'] as num).toDouble(),
      condition: json['condition'] as String,
      image: json['image'] as String,
      imageName: json['imageName'] as String,
      file: json['file'] as String?,
      fileName: json['fileName'] as String?,
      dateCreated: json['dateCreated'] as String,
      dateUpdated: json['dateUpdated'] as String,
      description: json['description'] as String,
      state: json['state'] as bool,
      status: json['status'] as bool,
      numberOfItems: json['numberOfItems'] as int,
      numberOfItemsAvailable: json['numberOfItemsAvailable'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['brandId'] = brandId;
    data['brandName'] = brandName;
    data['typeId'] = typeId;
    data['typeName'] = typeName;
    data['voucherName'] = voucherName;
    data['price'] = price;
    data['rate'] = rate;
    data['condition'] = condition;
    data['image'] = image;
    data['imageName'] = imageName;
    data['file'] = file;
    data['fileName'] = fileName;
    data['dateCreated'] = dateCreated;
    data['dateUpdated'] = dateUpdated;
    data['description'] = description;
    data['state'] = state;
    data['status'] = status;
    data['numberOfItems'] = numberOfItems;
    return data;
  }
}
