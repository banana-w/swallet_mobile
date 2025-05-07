import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/challenge_repository.dart';
import 'package:swallet_mobile/data/models/student_features/location_model.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final ChallengeRepository challengeRepository;

  LocationBloc(this.challengeRepository) : super(LocationInitial()) {
    on<LoadLocation>(_onLoadLocation);
    on<AddLocation>(_onAddLocation);
  }

  Future<void> _onLoadLocation(
    LoadLocation event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoading());
    try {
      final locations = await AuthenLocalDataSource.getLocations();

      if (locations == null) {
        emit(LocationLoaded(locations: []));
      } else {
        emit(LocationLoaded(locations: locations));
      }
    } catch (e) {
      emit(LocationFailed(error: e.toString()));
    }
  }

  Future<void> _onAddLocation(
    AddLocation event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoading());
    try {
      var locations = await challengeRepository.fetchLocation();
      await AuthenLocalDataSource.saveLocation(locations!);
    } catch (e) {
      emit(LocationFailed(error: e.toString()));
    }
  }
}
