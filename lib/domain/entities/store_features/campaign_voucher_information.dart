import 'package:equatable/equatable.dart';

class CampaignVoucherInformation extends Equatable {
  final String id;
  final String voucherId;
  final String voucherName;
  final String voucherImage;
  final String voucherCode;
  final int index;
  final String typeId;
  final String typeName;
  final String typeImage;
  final String studentId;
  final String studentName;
  final String brandId;
  final String brandName;
  final String brandImage;
  final String campaignDetailId;
  final String campaignId;
  final String campaignName;
  final String campaignImage;
  final int campaignStateId;
  final String campaignState;
  final String campaignStateName;
  final String usedAt;
  final double price;
  final double rate;
  final bool isLocked;
  final bool isBought;
  final bool isUsed;
  final String validOn;
  final String expireOn;
  final String dateCreated;
  final String dateLocked;
  final String dateBought;
  final String dateUsed;
  final String condition;
  final String description;
  final bool state;
  final bool status;

  const CampaignVoucherInformation({
    required this.id,
    required this.voucherId,
    required this.voucherName,
    required this.voucherImage,
    required this.voucherCode,
    required this.index,
    required this.typeId,
    required this.typeName,
    required this.typeImage,
    required this.studentId,
    required this.studentName,
    required this.brandId,
    required this.brandName,
    required this.brandImage,
    required this.campaignDetailId,
    required this.campaignId,
    required this.campaignName,
    required this.campaignImage,
    required this.campaignStateId,
    required this.campaignState,
    required this.campaignStateName,
    required this.usedAt,
    required this.price,
    required this.rate,
    required this.isLocked,
    required this.isBought,
    required this.isUsed,
    required this.validOn,
    required this.expireOn,
    required this.dateCreated,
    required this.dateLocked,
    required this.dateBought,
    required this.dateUsed,
    required this.condition,
    required this.description,
    required this.state,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id,
    voucherId,
    voucherName,
    voucherImage,
    voucherCode,
    index,
    typeId,
    typeName,
    typeImage,
    studentId,
    studentName,
    brandId,
    brandName,
    brandImage,
    campaignDetailId,
    campaignId,
    campaignName,
    campaignImage,
    campaignStateId,
    campaignState,
    campaignStateName,
    usedAt,
    price,
    rate,
    isLocked,
    isBought,
    isUsed,
    validOn,
    expireOn,
    dateCreated,
    dateLocked,
    dateBought,
    dateUsed,
    condition,
    description,
    state,
    status,
  ];
}
