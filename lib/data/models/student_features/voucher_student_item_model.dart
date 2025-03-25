import 'package:swallet_mobile/data/repositories/student_features/voucher_student_item.dart';

class VoucherStudentItemModel extends VoucherStudentItem {
  VoucherStudentItemModel({
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
  factory VoucherStudentItemModel.fromJson(Map<String, dynamic> json) {
    return VoucherStudentItemModel(
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['voucherId'] = voucherId;
    data['voucherName'] = voucherName;
    data['voucherImage'] = voucherImage;
    data['voucherCode'] = voucherCode;
    data['index'] = index;
    data['typeId'] = typeId;
    data['typeName'] = typeName;
    data['typeImage'] = typeImage;
    data['studentId'] = studentId;
    data['studentName'] = studentName;
    data['brandId'] = brandId;
    data['brandName'] = brandName;
    data['brandImage'] = brandImage;
    data['campaignDetailId'] = campaignDetailId;
    data['campaignId'] = campaignId;
    data['campaignName'] = campaignName;
    data['campaignImage'] = campaignImage;
    data['campaignStateId'] = campaignStateId;
    data['campaignState'] = campaignState;
    data['campaignStateName'] = campaignStateName;
    data['usedAt'] = usedAt;
    data['price'] = price;
    data['rate'] = rate;
    data['isLocked'] = isLocked;
    data['isBought'] = isBought;
    data['isUsed'] = isUsed;
    data['validOn'] = validOn;
    data['expireOn'] = expireOn;
    data['dateCreated'] = dateCreated;
    data['dateLocked'] = dateLocked;
    data['dateBought'] = dateBought;
    data['dateUsed'] = dateUsed;
    data['condition'] = condition;
    data['description'] = description;
    data['state'] = state;
    data['status'] = status;
    return data;
  }
}
