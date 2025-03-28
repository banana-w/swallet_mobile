import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/data/models/lecture_features/lecture_model.dart';
import 'package:swallet_mobile/domain/interface_repositories/lecture_features/lecture_repository.dart';

part 'lecture_event.dart';
part 'lecture_state.dart';

class LectureBloc extends Bloc<LectureEvent, LectureState> {
  final LectureRepository lectureRepository;

  LectureBloc({required this.lectureRepository}) : super(LectureInitial()) {
    // on<UpdateLecture>(_onUpdateLecture);
    on<LoadLectureById>(_onLoadLectureById);
  }

  Future<void> _onLoadLectureById(
    LoadLectureById event,
    Emitter<LectureState> emit,
  ) async {
    emit(LectureByIdLoading());
    try {
      var apiResponse = await lectureRepository.fetchLectureById(
        accountId: event.id,
      );
      emit(LectureByIdSuccess(lectureModel: apiResponse!));
    } catch (e) {
      emit(LectureByIdFailed(error: e.toString()));
    }
  }

  // Future<void> _onUpdateStudent(
  //   UpdateStudent event,
  //   Emitter<StudentState> emit,
  // ) async {
  //   emit(StudentUpding());
  //   try {
  //     var studentModel = await studentRepository.putStudent(
  //       studentId: event.studentId,
  //       fullName: event.fullName,
  //       studentCode: event.studentCode,
  //       dateOfBirth: event.dateOfBirth,
  //       campusId: event.campusId,
  //       gender: event.gender,
  //       address: event.address,
  //       avatar: event.avatar,
  //     );
  //     if (studentModel == null) {
  //       emit(StudentFaled(error: 'Sửa thất bại!'));
  //     } else {
  //       emit(StudentUpdateSuccess(studentModel: studentModel));
  //     }
  //   } catch (e) {
  //     emit(StudentFaled(error: e.toString()));
  //   }
  // }
}
