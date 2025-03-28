import 'package:swallet_mobile/domain/entities/store_features/campaign_voucher_information.dart';

class CampaignVoucherInformationModel extends CampaignVoucherInformation {
  CampaignVoucherInformationModel({
    required super.id,
    required super.voucherId,
    required super.voucherName,
    required super.voucherImage,
    required super.voucherCode,
    required super.index,
    required super.typeId,
    required super.typeName,
    required super.typeImage,
    required super.studentId,
    required super.studentName,
    required super.brandId,
    required super.brandName,
    required super.brandImage,
    required super.campaignDetailId,
    required super.campaignId,
    required super.campaignName,
    required super.campaignImage,
    required super.campaignStateId,
    required super.campaignState,
    required super.campaignStateName,
    required super.usedAt,
    required super.price,
    required super.rate,
    required super.isLocked,
    required super.isBought,
    required super.isUsed,
    required super.validOn,
    required super.expireOn,
    required super.dateCreated,
    required super.dateLocked,
    required super.dateBought,
    required super.dateUsed,
    required super.condition,
    required super.description,
    required super.state,
    required super.status,
  });

  factory CampaignVoucherInformationModel.fromJson(Map<String, dynamic> json) {
    return CampaignVoucherInformationModel(
      id: json['id'],
      voucherId: json['voucherId'],
      voucherName: json['voucherName'],
      voucherImage: json['voucherImage'],
      voucherCode: json['voucherCode'],
      index: json['index'],
      typeId: json['typeId'],
      typeName: json['typeName'],
      typeImage: json['typeImage'],
      studentId: json['studentId'],
      studentName: json['studentName'],
      brandId: json['brandId'],
      brandName: json['brandName'],
      brandImage: json['brandImage'],
      campaignDetailId: json['campaignDetailId'],
      campaignId: json['campaignId'],
      campaignName: json['campaignName'],
      campaignImage: json['campaignImage'],
      campaignStateId: json['campaignStateId'],
      campaignState: json['campaignState'],
      campaignStateName: json['campaignStateName'],
      usedAt: json['usedAt'] ?? '',
      price: json['price'],
      rate: json['rate'],
      isLocked: json['isLocked'],
      isBought: json['isBought'],
      isUsed: json['isUsed'],
      validOn: json['validOn'],
      expireOn: json['expireOn'],
      dateCreated: json['dateCreated'],
      dateLocked: json['dateLocked'],
      dateBought: json['dateBought'],
      dateUsed: json['dateUsed'] ?? '',
      condition: json['condition'],
      description: json['description'],
      state: json['state'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['voucherId'] = this.voucherId;
    data['voucherName'] = this.voucherName;
    data['voucherImage'] = this.voucherImage;
    data['voucherCode'] = this.voucherCode;
    data['index'] = this.index;
    data['typeId'] = this.typeId;
    data['typeName'] = this.typeName;
    data['typeImage'] = this.typeImage;
    data['studentId'] = this.studentId;
    data['studentName'] = this.studentName;
    data['brandId'] = this.brandId;
    data['brandName'] = this.brandName;
    data['brandImage'] = this.brandImage;
    data['campaignDetailId'] = this.campaignDetailId;
    data['campaignId'] = this.campaignId;
    data['campaignName'] = this.campaignName;
    data['campaignImage'] = this.campaignImage;
    data['campaignStateId'] = this.campaignStateId;
    data['campaignState'] = this.campaignState;
    data['campaignStateName'] = this.campaignStateName;
    data['usedAt'] = this.usedAt;
    data['price'] = this.price;
    data['rate'] = this.rate;
    data['isLocked'] = this.isLocked;
    data['isBought'] = this.isBought;
    data['isUsed'] = this.isUsed;
    data['validOn'] = this.validOn;
    data['expireOn'] = this.expireOn;
    data['dateCreated'] = this.dateCreated;
    data['dateLocked'] = this.dateLocked;
    data['dateBought'] = this.dateBought;
    data['dateUsed'] = this.dateUsed;
    data['condition'] = this.condition;
    data['description'] = this.description;
    data['state'] = this.state;
    data['status'] = this.status;
    return data;
  }
}
