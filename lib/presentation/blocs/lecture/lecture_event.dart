part of 'lecture_bloc.dart';

sealed class LectureEvent extends Equatable {
  const LectureEvent();
}

final class LoadLectureById extends LectureEvent {
  final String id;

  const LoadLectureById({required this.id});

  @override
  List<Object?> get props => [id];
}
