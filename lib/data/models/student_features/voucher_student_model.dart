import 'package:swallet_mobile/domain/entities/student_features/voucher_student.dart';

class VoucherStudentModel extends VoucherStudent {
  const VoucherStudentModel({
    required super.id,
    required super.voucherId,
    required super.voucherName,
    required super.voucherImage,
    required super.voucherCode,
    super.typeId,
    required super.typeName,
    super.typeImage,
    required super.studentId,
    required super.studentName,
    super.brandId,
    super.brandName,
    super.brandImage,
    required super.campaignDetailId,
    required super.campaignId,
    required super.campaignName,
    required super.price,
    required super.isLocked,
    required super.isBought,
    required super.isUsed,
    required super.validOn,
    required super.expireOn,
    super.dateCreated,
    super.dateLocked,
    super.dateBought,
    super.dateUsed,
    required super.description,
    required super.state,
    required super.status,
  });

  factory VoucherStudentModel.fromJson(Map<String, dynamic> json) {
    return VoucherStudentModel(
      id: json['id'] as String,
      voucherId: json['voucherId'] as String,
      voucherName: json['voucherName'] as String,
      voucherImage: json['voucherImage'] as String,
      voucherCode: json['voucherCode'] as String,
      typeId: json['typeId'] as String?,
      typeName: json['typeName'] as String,
      typeImage: json['typeImage'] as String?,
      studentId: json['studentId'] as String,
      studentName: json['studentName'] as String,
      brandId: json['brandId'] as String?,
      brandName: json['brandName'] as String?,
      brandImage: json['brandImage'] as String?,
      campaignDetailId: json['campaignDetailId'] as String,
      campaignId: json['campaignId'] as String,
      campaignName: json['campaignName'] as String,
      price: (json['price'] as num).toDouble(),
      isLocked: json['isLocked'] as bool,
      isBought: json['isBought'] as bool,
      isUsed: json['isUsed'] as bool,
      validOn: json['validOn'] as String,
      expireOn: json['expireOn'] as String,
      dateCreated: json['dateCreated'] as String?,
      dateLocked: json['dateLocked'] as String?,
      dateBought: json['dateBought'] as String?,
      dateUsed: json['dateUsed'] as String?,
      description: json['description'] as String,
      state: json['state'] as bool,
      status: json['status'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['voucherId'] = voucherId;
    data['voucherName'] = voucherName;
    data['voucherImage'] = voucherImage;
    data['voucherCode'] = voucherCode;
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
    data['price'] = price;
    data['isLocked'] = isLocked;
    data['isBought'] = isBought;
    data['isUsed'] = isUsed;
    data['validOn'] = validOn;
    data['expireOn'] = expireOn;
    data['dateCreated'] = dateCreated;
    data['dateLocked'] = dateLocked;
    data['dateBought'] = dateBought;
    data['dateUsed'] = dateUsed;
    data['description'] = description;
    data['state'] = state;
    data['status'] = status;
    return data;
  }
}