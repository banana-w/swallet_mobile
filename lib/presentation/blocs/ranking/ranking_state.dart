part of 'ranking_bloc.dart';

sealed class RankingState extends Equatable {
  const RankingState();
}

final class RankingInitial extends RankingState {
  @override
  List<Object?> get props => [];
}

final class CampaignRankingLoading extends RankingState {
  @override
  List<Object?> get props => [];
}

final class CampaignRankingLoaded extends RankingState {
  final List<CampaignRankingModel> campaignRankings;

  CampaignRankingLoaded({required this.campaignRankings});

  @override
  List<Object?> get props => [campaignRankings];
}

final class StudentRankingLoading extends RankingState {
  @override
  List<Object?> get props => [];
}

final class StudentRankingLoaded extends RankingState {
  final List<StudentRankingModel> studentRankings;

  StudentRankingLoaded({required this.studentRankings});

  @override
  List<Object?> get props => [studentRankings];
}

final class RankingFailed extends RankingState {
  final String error;

  RankingFailed({required this.error});

  @override
  List<Object?> get props => [error];
}
