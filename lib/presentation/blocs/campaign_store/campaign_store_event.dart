part of 'campaign_store_bloc.dart';

sealed class CampaignStoreEvent extends Equatable {
  const CampaignStoreEvent();
}

final class LoadCampaignStoreById extends CampaignStoreEvent {
  final String id;
  final int page;
  final int limit;

  const LoadCampaignStoreById({this.page = 1, this.limit = 10, required this.id});
  @override
  List<Object?> get props => [id, page, limit];
}
