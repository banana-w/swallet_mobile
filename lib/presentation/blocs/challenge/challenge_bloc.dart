import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/data/models/student_features/challenge_model.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/challenge_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/student_repository.dart';
part 'challenge_event.dart';
part 'challenge_state.dart';

class ChallengeBloc extends Bloc<ChallengeEvent, ChallengeState> {
  final ChallengeRepository challengeRepository;
  final StudentRepository studentRepository;

  ChallengeBloc({
    required this.challengeRepository,
    required this.studentRepository,
  }) : super(ChallengeInitial()) {
    on<LoadChallenge>(_onLoadChallenges);
    on<LoadDailyChallenge>(_onLoadDailyChallenges);
    on<ClaimChallengeStudentId>(_onClaimChallenge);
    on<ClaimChallengeStudentIdDaily>(_onClaimChallengeDaily);
  }

  Future<void> _onLoadChallenges(
    LoadChallenge event,
    Emitter<ChallengeState> emit,
  ) async {
    emit(ChallengeLoading());
    try {
      var apiResponse = await challengeRepository.fecthChallenges();
      emit(ChallengesLoaded(challenge: apiResponse!.result.toList()));
    } catch (e) {
      emit(ChallengeFailed(error: e.toString()));
    }
  }

  Future<void> _onLoadDailyChallenges(
    LoadDailyChallenge event,
    Emitter<ChallengeState> emit,
  ) async {
    emit(ChallengeLoading());
    try {
      var apiResponse = await challengeRepository.fecthDailyChallenges();
      emit(ChallengesLoaded(challenge: apiResponse!.result.toList()));
    } catch (e) {
      emit(ChallengeFailed(error: e.toString()));
    }
  }

  Future<void> _onClaimChallenge(
    ClaimChallengeStudentId event,
    Emitter<ChallengeState> emit,
  ) async {
    emit(ClaimLoading());
    try {
      var isSuccess = await studentRepository.postChallengeStudentId(
        challengeId: event.challengeId,
        studentId: event.studentId,
        type: 2,
      );
      if (isSuccess!) {
        var apiResponse = await challengeRepository.fecthChallenges();
        emit(
          ChallengesLoaded(
            challenge: apiResponse!.result.toList(),
            isClaimed: true,
          ),
        );
      } else {
        emit(ChallengeFailed(error: 'Failed'));
      }
    } catch (e) {
      emit(ChallengeFailed(error: e.toString()));
    }
  }

  Future<void> _onClaimChallengeDaily(
    ClaimChallengeStudentIdDaily event,
    Emitter<ChallengeState> emit,
  ) async {
    emit(ClaimLoading());
    try {
      final isSuccess = await studentRepository.postChallengeStudentId(
        challengeId: event.challengeId,
        studentId: event.studentId,
        type: 1,
      );

      if (isSuccess == true) {
        // Explicit comparison
        final apiResponse = await challengeRepository.fecthDailyChallenges();
        if (apiResponse?.result != null) {
          emit(
            ChallengesLoaded(
              challenge: apiResponse!.result.toList(),
              isClaimed: true, // Make sure this is set to true
            ),
          );
        }
      } else {
        emit(const ChallengeFailed(error: 'Claim failed'));
      }
    } catch (e) {
      emit(ChallengeFailed(error: e.toString()));
    }
  }
}
