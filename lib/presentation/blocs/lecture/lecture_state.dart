part of 'lecture_bloc.dart';

sealed class LectureState extends Equatable {
  const LectureState();
}

final class LectureInitial extends LectureState {
  @override
  List<Object?> get props => [];
}

final class LectureByIdSuccess extends LectureState {
  final LectureModel lectureModel;

  const LectureByIdSuccess({required this.lectureModel});

  @override
  List<Object?> get props => [lectureModel];
}

final class LectureByIdFailed extends LectureState {
  final String error;

  const LectureByIdFailed({required this.error});

  @override
  List<Object?> get props => [error];
}

final class LectureByIdLoading extends LectureState {
  const LectureByIdLoading();
  @override
  List<Object?> get props => [];
}
