part of 'campaign_bloc.dart';

sealed class CampaignEvent extends Equatable {
  const CampaignEvent();
}

final class LoadCampaigns extends CampaignEvent {
  final int page;
  final int limit;

  LoadCampaigns({this.page = 1, this.limit = 3});
  @override
  List<Object?> get props => [page, limit];
}

final class LoadMoreCampaigns extends CampaignEvent {
  final int page;
  final int limit;

  LoadMoreCampaigns({this.page = 1, this.limit = 3});
  @override
  List<Object?> get props => [page, limit];
}

final class LoadCampaignById extends CampaignEvent {
  final String id;

  const LoadCampaignById({required this.id});

  @override
  List<Object?> get props => [id];
}

final class RedeemCampaignVoucher extends CampaignEvent {
  final String campaignId;
  final String campaignDetailId;
  final String studentId;
  final int quantity;
  final String description;

  RedeemCampaignVoucher(
      {required this.campaignId,
      required this.campaignDetailId,
      required this.studentId,
      required this.quantity,
      required this.description});

  @override
  List<Object?> get props =>
      [campaignId, campaignDetailId, studentId, quantity, description];
}
