part of 'campaign_store_bloc.dart';

sealed class CampaignStoreState extends Equatable {
  const CampaignStoreState();

}

final class CampaignStoreInitial extends CampaignStoreState {
    
  @override
  List<Object> get props => [];
}

final class CampaignStoreLoading extends CampaignStoreState {
  const CampaignStoreLoading();
  @override
  List<Object?> get props => [];
}


final class CampaignStoreByIdLoaded extends CampaignStoreState {
  final List<CampaignStoreModel> campaignStores;

  const CampaignStoreByIdLoaded({required this.campaignStores});

  @override
  List<Object?> get props => [campaignStores];
}

final class CampaignStoresFailed extends CampaignStoreState {
  final String error;

  const CampaignStoresFailed({required this.error});
  @override
  List<Object?> get props => [error];
}