import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/data/models/lecture_features/lecture_model.dart';
import 'package:swallet_mobile/data/interface_repositories/lecture_features/lecture_repository.dart';

part 'lecture_event.dart';
part 'lecture_state.dart';

class LectureBloc extends Bloc<LectureEvent, LectureState> {
  final LectureRepository lectureRepository;

  LectureBloc({required this.lectureRepository})
    : super(const LectureInitial()) {
    on<LoadLectureById>(_onLoadLectureById);
    on<GenerateQRCodeEvent>(_onGenerateQRCode);
  }

  Future<void> _onLoadLectureById(
    LoadLectureById event,
    Emitter<LectureState> emit,
  ) async {
    emit(const LectureLoading());
    try {
      final lecture = await lectureRepository.fetchLectureById(
        accountId: event.id,
      );
      if (lecture != null) {
        emit(LectureLoaded(lecture));
      } else {
        emit(const LectureLoadFailed('Lecture not found'));
      }
    } catch (e) {
      emit(LectureLoadFailed(e.toString()));
    }
  }

  Future<void> _onGenerateQRCode(
    GenerateQRCodeEvent event,
    Emitter<LectureState> emit,
  ) async {
    emit(const QRCodeGenerating());
    try {
      final qrCodeData = await lectureRepository.generateQRCode(
        points: event.points,
        availableHours: event.availableHours,
        lecturerId: event.lecturerId,
        maxUsageCount: event.maxUsageCount, // Thêm maxUsageCount
        context: event.context, // Thêm context
      );
      emit(QRCodeGenerated(qrCodeData)); // qrCodeData là Map
    } catch (e) {
      emit(QRCodeGenerationFailed(e.toString()));
    }
  }
}
