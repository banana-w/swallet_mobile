import 'package:swallet_mobile/domain/entities/store_features/campaign_voucher_store.dart';

class CampaignVoucherStoreModel extends CampaignVoucherStore {
  CampaignVoucherStoreModel({
    required super.id,
    required super.voucherId,
    required super.voucherName,
    required super.voucherImage,
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

  factory CampaignVoucherStoreModel.fromJson(Map<String, dynamic> json) {
    return CampaignVoucherStoreModel(
      id: json['id'],
      voucherId: json['voucherId'],
      voucherName: json['voucherName'],
      voucherImage: json['voucherImage'] ?? '',
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['voucherId'] = this.voucherId;
    data['voucherName'] = this.voucherName;
    data['voucherImage'] = this.voucherImage;
    data['campaignId'] = this.campaignId;
    data['campaignName'] = this.campaignName;
    data['price'] = this.price;
    data['rate'] = this.rate;
    data['quantity'] = this.quantity;
    data['fromIndex'] = this.fromIndex;
    data['toIndex'] = this.toIndex;
    data['dateCreated'] = this.dateCreated;
    data['dateUpdated'] = this.dateUpdated;
    data['description'] = this.description;
    data['state'] = this.state;
    data['status'] = this.status;
    data['quantityInStock'] = this.quantityInStock;
    data['quantityInBought'] = this.quantityInBought;
    data['quantityInUsed'] = this.quantityInUsed;
    return data;
  }
}
