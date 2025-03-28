import 'package:swallet_mobile/domain/entities/student_features/campaign_voucher.dart';


class CampaignVoucherDetail extends CampaignVoucher {
  final String voucherCondition;
  final String voucherDescription;
  final String typeId;
  final String typeName;
  final int quantityInBought;
  final int quantityInUsed;

  const CampaignVoucherDetail({
    required this.voucherCondition,
    required this.voucherDescription,
    required this.typeId,
    required this.typeName,
    required this.quantityInBought,
    required this.quantityInUsed,
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
  });

  @override
  List<Object> get props =>
      super.props..addAll([
        voucherCondition,
        voucherDescription,
        typeId,
        typeName,
        quantityInBought,
        quantityInUsed,
      ]);
}
