import 'package:equatable/equatable.dart';

class BrandVoucher extends Equatable {
  final String brandId;
  final String brandName;
  final String brandImage;
  final List<VoucherGroup> voucherGroups;

  const BrandVoucher({
    required this.brandId,
    required this.brandName,
    required this.brandImage,
    required this.voucherGroups,
  });

  factory BrandVoucher.fromJson(Map<String, dynamic> json) {
    return BrandVoucher(
      brandId: json['brandId'] as String,
      brandName: json['brandName'] as String,
      brandImage: json['brandImage'] as String,
      voucherGroups: (json['voucherGroups'] as List)
          .map((e) => VoucherGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brandId': brandId,
      'brandName': brandName,
      'brandImage': brandImage,
      'voucherGroups': voucherGroups.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [brandId, brandName, brandImage, voucherGroups];
}

class VoucherGroup extends Equatable {
  final String voucherId;
  final String voucherName;
  final String voucherImage;
  final String expireOn;
  final String campaignId;
  final int quantity;
  final int totalQuantity;
  final List<dynamic>? vouchers;

  const VoucherGroup({
    required this.voucherId,
    required this.voucherName,
    required this.voucherImage,
    required this.expireOn,
    required this.campaignId,
    required this.quantity,
    required this.totalQuantity,
    this.vouchers,
  });

  factory VoucherGroup.fromJson(Map<String, dynamic> json) {
    return VoucherGroup(
      voucherId: json['voucherId'] as String,
      voucherName: json['voucherName'] as String,
      voucherImage: json['voucherImage'] as String,
      expireOn: json['expireOn'] as String,
      campaignId: json['campaignId'] as String,
      quantity: json['quantity'] as int,
      totalQuantity: json['totalQuantity'] as int,
      vouchers: json['vouchers'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'voucherId': voucherId,
      'voucherName': voucherName,
      'voucherImage': voucherImage,
      'expireOn': expireOn,
      'campaignId': campaignId,
      'quantity': quantity,
      'totalQuantity': totalQuantity,
      'vouchers': vouchers,
    };
  }

  @override
  List<Object?> get props =>
      [voucherId, voucherName, voucherImage, quantity, totalQuantity, vouchers];
}