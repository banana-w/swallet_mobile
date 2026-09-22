part of 'redeem_voucher_bloc.dart';

sealed class RedeemVoucherEvent extends Equatable {
  const RedeemVoucherEvent();
}

final class RedeemCampaignVoucher extends RedeemVoucherEvent {
  final String campaignId;
  final String studentId;
  final String voucherId;
  final int quantity;
  final double cost;

  const RedeemCampaignVoucher({
    required this.campaignId,
    required this.studentId,
    required this.voucherId,
    required this.quantity,
    required this.cost,
  });

  @override
  List<Object?> get props => [campaignId, studentId, voucherId, quantity, cost];
}
