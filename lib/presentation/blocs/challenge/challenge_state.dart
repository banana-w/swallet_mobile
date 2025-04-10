part of 'challenge_bloc.dart';

sealed class ChallengeState extends Equatable {
  const ChallengeState();
}

final class ChallengeInitial extends ChallengeState {
  @override
  List<Object> get props => [];
}

final class ChallengeLoading extends ChallengeState {
  @override
  List<Object> get props => [];
}

final class ChallengesLoaded extends ChallengeState {
  final List<ChallengeModel> challenge;
  final bool isClaimed;

  const ChallengesLoaded({required this.challenge, this.isClaimed = false});
  @override
  List<Object> get props => [challenge, isClaimed];
}

final class ChallengeFailed extends ChallengeState {
  final String error;

  const ChallengeFailed({required this.error});

  @override
  List<Object> get props => [error];
}

final class ClaimLoading extends ChallengeState {
  @override
  List<Object> get props => [];
}
