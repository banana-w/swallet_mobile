import 'package:swallet_mobile/domain/entities/student_features/campaign_voucher_detail.dart';

class CampaignVoucherDetailModel extends CampaignVoucherDetail {
  CampaignVoucherDetailModel({
    required super.id,
    required super.voucherId,
    required super.voucherName,
    required super.voucherImage,
    required super.voucherCondition,
    required super.voucherDescription,
    required super.typeId,
    required super.typeName,
    required super.campaignId,
    required super.campaignName,
    required super.price,
    required super.rate,
    required super.quantity,
    required super.fromIndex,
    required super.toIndex,
    required super.dateCreated,
    required super.dateUpdated,
    required super.description,
    required super.state,
    required super.status,
    required super.quantityInStock,
    required super.quantityInBought,
    required super.quantityInUsed,
  });

  factory CampaignVoucherDetailModel.fromJson(Map<String, dynamic> json) {
    return CampaignVoucherDetailModel(
      id: json['id'],
      voucherId: json['voucherId'],
      voucherName: json['voucherName'],
      voucherImage: json['voucherImage'],
      voucherCondition: json['voucherCondition'],
      voucherDescription: json['voucherDescription'],
      typeId: json['typeId'],
      typeName: json['typeName'],
      campaignId: json['campaignId'],
      campaignName: json['campaignName'],
      price: json['price'],
      rate: json['rate'],
      quantity: json['quantity'],
      fromIndex: json['fromIndex'],
      toIndex: json['toIndex'],
      dateCreated: json['dateCreated'],
      dateUpdated: json['dateUpdated'],
      description: json['description'],
      state: json['state'],
      status: json['status'],
      quantityInStock: json['quantityInStock'],
      quantityInBought: json['quantityInBought'],
      quantityInUsed: json['quantityInUsed'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['voucherId'] = voucherId;
    data['voucherName'] = voucherName;
    data['voucherImage'] = voucherImage;
    data['voucherCondition'] = voucherCondition;
    data['voucherDescription'] = voucherDescription;
    data['typeId'] = typeId;
    data['typeName'] = typeName;
    data['campaignId'] = campaignId;
    data['campaignName'] = campaignName;
    data['price'] = price;
    data['rate'] = rate;
    data['quantity'] = quantity;
    data['fromIndex'] = fromIndex;
    data['toIndex'] = toIndex;
    data['dateCreated'] = dateCreated;
    data['dateUpdated'] = dateUpdated;
    data['description'] = description;
    data['state'] = state;
    data['status'] = status;
    data['quantityInStock'] = quantityInStock;
    data['quantityInBought'] = quantityInBought;
    data['quantityInUsed'] = quantityInUsed;
    return data;
  }
}
