part of 'campaign_bloc.dart';

sealed class CampaignState extends Equatable {
  const CampaignState();
}

final class CampaignInitial extends CampaignState {
  const CampaignInitial();

  @override
  List<Object?> get props => [];
}

final class CampaignLoading extends CampaignState {
  const CampaignLoading();
  @override
  List<Object?> get props => [];
}

final class CampaignsLoaded extends CampaignState {
  final List<CampaignModel> campaigns;
  final bool hasReachMax;

  const CampaignsLoaded({required this.campaigns, this.hasReachMax = false});

  @override
  List<Object?> get props => [campaigns, hasReachMax];
}

final class CampaignsFailed extends CampaignState {
  final String error;

  const CampaignsFailed({required this.error});
  @override
  List<Object?> get props => [error];
}

final class CampaignByIdLoaded extends CampaignState {
  final CampaignDetailModel campaignDetailModel;

  const CampaignByIdLoaded({required this.campaignDetailModel});

  @override
  List<Object?> get props => [campaignDetailModel];
}
