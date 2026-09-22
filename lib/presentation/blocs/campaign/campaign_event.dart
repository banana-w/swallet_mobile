part of 'campaign_bloc.dart';

sealed class CampaignEvent extends Equatable {
  const CampaignEvent();
}

final class LoadCampaigns extends CampaignEvent {
  final int page;
  final int limit;

  const LoadCampaigns({this.page = 1, this.limit = 20});
  @override
  List<Object?> get props => [page, limit];
}

/// Tải trang kế tiếp. Số trang và cỡ trang do bloc giữ, tiếp nối lần
/// [LoadCampaigns] gần nhất.
final class LoadMoreCampaigns extends CampaignEvent {
  const LoadMoreCampaigns();

  @override
  List<Object?> get props => [];
}

final class LoadCampaignById extends CampaignEvent {
  final String id;

  const LoadCampaignById({required this.id});

  @override
  List<Object?> get props => [id];
}
