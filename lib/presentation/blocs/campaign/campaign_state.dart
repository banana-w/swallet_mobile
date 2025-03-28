part of 'campaign_bloc.dart';

sealed class CampaignState extends Equatable {
  const CampaignState();
}

final class CampaignInitial extends CampaignState {
  CampaignInitial();

  @override
  List<Object?> get props => [];
}

final class CampaignLoading extends CampaignState {
  CampaignLoading();
  @override
  List<Object?> get props => [];
}

final class CampaignsLoaded extends CampaignState {
  final List<CampaignModel> campaigns;
  final bool hasReachMax;

  CampaignsLoaded({required this.campaigns, this.hasReachMax = false});

  @override
  List<Object?> get props => [campaigns, hasReachMax];
}

final class CampaignPaging extends CampaignState {
  @override
  List<Object?> get props => [];
}

final class CampaignsFailed extends CampaignState {
  final String error;

  CampaignsFailed({required this.error});
  @override
  List<Object?> get props => [error];
}

final class CampaignByIdLoaded extends CampaignState {
  final CampaignDetailModel campaignDetailModel;

  CampaignByIdLoaded({required this.campaignDetailModel});

  @override
  List<Object?> get props => [campaignDetailModel];
}


final class RedeemVoucherLoading extends CampaignState {
  @override
  List<Object?> get props => [];
}

final class RedeemVoucherSuccess extends CampaignState {
  final String text;

  RedeemVoucherSuccess({required this.text});

  @override
  List<Object?> get props => [text];
}

final class RedeemVoucherFailed extends CampaignState {
  final String error;

  RedeemVoucherFailed({required this.error});

  @override
  List<Object?> get props => [error];
}
