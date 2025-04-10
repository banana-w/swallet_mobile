import 'package:swallet_mobile/data/models/student_features/campaign_model.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/voucher.dart';

class VoucherDetailModel extends Voucher {
  final List<CampaignModel> campaigns;
  final String brandImage;
  const VoucherDetailModel({
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
    required super.file,
    required super.fileName,
    required super.dateCreated,
    required super.dateUpdated,
    required super.description,
    required super.state,
    required super.status,
    required super.numberOfItems,
    required this.brandImage,
    required this.campaigns,
  });

  factory VoucherDetailModel.fromJson(Map<String, dynamic> json) {
    var campaigns = json['campaigns'] as List<dynamic>;
    List<CampaignModel> campaignModels =
        campaigns.map((detail) => CampaignModel.fromJson(detail)).toList();
    return VoucherDetailModel(
      id: json['id'],
      brandId: json['brandId'],
      brandName: json['brandName'],
      typeId: json['typeId'],
      typeName: json['typeName'],
      voucherName: json['voucherName'],
      price: json['price'],
      rate: json['rate'],
      condition: json['condition'] ?? '',
      image: json['image'] ?? '',
      imageName: json['imageName'] ?? '',
      file: json['file'] ?? '',
      fileName: json['fileName'] ?? '',
      dateCreated: json['dateCreated'] ?? '',
      dateUpdated: json['dateUpdated'] ?? '',
      description: json['description'] ?? '',
      state: json['state'],
      status: json['status'],
      numberOfItems: json['numberOfItems'],
      brandImage: json['brandImage'],
      campaigns: campaignModels,
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
    data['brandImage'] = brandImage;
    data['campaigns'] = campaigns.map((e) => e.toJson()).toList();
    return data;
  }

  @override
  List<Object> get props => super.props..addAll([campaigns]);
}
