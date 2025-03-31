part of 'campaign_voucher_bloc.dart';

sealed class CampaignVoucherEvent extends Equatable {
  const CampaignVoucherEvent();
}

final class LoadCampaignVoucher extends CampaignVoucherEvent {
  final int page;
  final int limit;
  final String id;
  const LoadCampaignVoucher({this.page = 1, this.limit = 10, required this.id});

  @override
  List<Object?> get props => [page, limit, id];
}

final class LoadCampaignVoucherById extends CampaignVoucherEvent {
  final String campaignId;
  final String campaignVoucherId;

  const LoadCampaignVoucherById(
      {required this.campaignId, required this.campaignVoucherId});

  @override
  List<Object?> get props => [campaignId, campaignVoucherId];
}
