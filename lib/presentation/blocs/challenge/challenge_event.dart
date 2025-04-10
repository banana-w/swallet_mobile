part of 'challenge_bloc.dart';

sealed class ChallengeEvent extends Equatable {
  const ChallengeEvent();
}

final class LoadChallenge extends ChallengeEvent {
  @override
  List<Object?> get props => [];
}

final class LoadDailyChallenge extends ChallengeEvent {
  @override
  List<Object?> get props => [];
}

final class ClaimChallengeStudentId extends ChallengeEvent {
  final String studentId;
  final String challengeId;

  const ClaimChallengeStudentId({required this.studentId, required this.challengeId});

  @override
  List<Object?> get props => [studentId, challengeId];
}
