part of 'ranking_bloc.dart';

sealed class RankingEvent extends Equatable {
  const RankingEvent();
}

final class LoadCampaignRanking extends RankingEvent {
  @override
  List<Object?> get props => [];
}


final class LoadStudentRanking extends RankingEvent {
  @override
  List<Object?> get props => [];
}

