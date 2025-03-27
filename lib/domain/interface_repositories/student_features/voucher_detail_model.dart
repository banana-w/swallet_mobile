import 'package:swallet_mobile/data/models/student_features/campaign_model.dart';
import 'package:swallet_mobile/domain/interface_repositories/student_features/voucher.dart';

class VoucherDetailModel extends Voucher {
  final List<CampaignModel> campaigns;
  final String brandImage;
  VoucherDetailModel({
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brandId'] = this.brandId;
    data['brandName'] = this.brandName;
    data['typeId'] = this.typeId;
    data['typeName'] = this.typeName;
    data['voucherName'] = this.voucherName;
    data['price'] = this.price;
    data['rate'] = this.rate;
    data['condition'] = this.condition;
    data['image'] = this.image;
    data['imageName'] = this.imageName;
    data['file'] = this.file;
    data['fileName'] = this.fileName;
    data['dateCreated'] = this.dateCreated;
    data['dateUpdated'] = this.dateUpdated;
    data['description'] = this.description;
    data['state'] = this.state;
    data['status'] = this.status;
    data['numberOfItems'] = this.numberOfItems;
    data['brandImage'] = this.brandImage;
    data['campaigns'] = this.campaigns.map((e) => e.toJson()).toList();
    return data;
  }

  @override
  List<Object> get props => super.props..addAll([this.campaigns]);
}
