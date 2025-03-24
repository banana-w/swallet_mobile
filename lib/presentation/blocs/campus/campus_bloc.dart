import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:swallet_mobile/data/models/api_response.dart';
import 'package:swallet_mobile/data/models/student_features/campus_model.dart';
import 'package:swallet_mobile/domain/interface_repositories/student_features/campus_repository.dart';

part 'campus_event.dart';
part 'campus_state.dart';

class CampusBloc extends Bloc<CampusEvent, CampusState> {
  final CampusRepository campusRepository;

  CampusBloc(this.campusRepository) : super(CampusLoading()) {
    on<LoadCampus>(_onLoadCampusByUniversityId);
  }

  // Future<void> _onLoadCampusByUniversityId(
  //     LoadCampus event, Emitter<CampusState> emit) async {
  //   emit(CampusLoading());
  //   try {
  //     var apiResponse =
  //         await campusRepository.fetchCampus(searchName: event.searchName);
  //     emit(CampusLoaded(campuses: apiResponse!.result.toList()));
  //   } catch (e) {
  //     emit(CampusFailed(error: e.toString()));
  //   }
  // }

  Future<void> _onLoadCampusByUniversityId(
    LoadCampus event,
    Emitter<CampusState> emit,
  ) async {
    emit(CampusLoading());
    try {
      // Kiểm tra searchName có null hay không
      ApiResponse<List<CampusModel>>? apiResponse;
      if (event.searchName != null) {
        // Nếu searchName không null, tìm kiếm theo searchName
        apiResponse = await campusRepository.fetchCampus(
          searchName: event.searchName!,
        );
      } else {
        // Nếu searchName null, lấy tất cả campus
        apiResponse = await campusRepository.fetchCampus(searchName: "");
      }

      // Kiểm tra apiResponse không null trước khi truy cập result
      if (apiResponse != null) {
        emit(CampusLoaded(campuses: apiResponse.result.toList()));
      } else {
        emit(CampusFailed(error: "Failed to load campus data"));
      }
    } catch (e) {
      emit(CampusFailed(error: e.toString()));
    }
  }
}
