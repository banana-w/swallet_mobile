part of 'lecture_bloc.dart';

abstract class LectureEvent {
  const LectureEvent();
}

class LoadLectureById extends LectureEvent {
  final String id;

  LoadLectureById({required this.id});

  @override
  List<Object> get props => [id];
}

class GenerateQRCodeEvent extends LectureEvent {
  final int points;
  final String expirationTime;
  final String startOnTime;
  final int availableHours; // Sửa thành int
  final String lecturerId; // Đổi tên thành lecturerId
  final int maxUsageCount; // Thêm maxUsageCount
  final BuildContext context; // Thêm context

  const GenerateQRCodeEvent({
    required this.points,
    required this.expirationTime,
    required this.startOnTime,
    required this.availableHours,
    required this.lecturerId,
    required this.maxUsageCount,
    required this.context,
  });

  @override
  List<Object?> get props => [
    points,
    expirationTime,
    startOnTime,
    availableHours,
    lecturerId,
    maxUsageCount,
    context,
  ];
}
