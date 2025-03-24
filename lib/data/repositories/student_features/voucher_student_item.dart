import 'package:swallet_mobile/domain/entities/student_features/voucher_student.dart';

class VoucherStudentItem extends VoucherStudent {
  final String campaignImage;
  final String campaignState;
  final int campaignStateId;
  final String campaignStateName;
  final String condition;
  final String usedAt;
  VoucherStudentItem({
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
    required this.campaignImage,
    required this.campaignStateId,
    required this.campaignState,
    required this.campaignStateName,
    required this.usedAt,
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
    required this.condition,
    required super.description,
    required super.state,
    required super.status,
  });

  @override
  List<Object?> get props =>
      super.props..addAll([
        campaignImage,
        campaignState,
        campaignStateId,
        campaignStateName,
        condition,
        usedAt,
      ]);
}
