part of 'location_bloc.dart';

sealed class LocationState extends Equatable {
  const LocationState();
}

final class LocationLoading extends LocationState {
  @override
  List<Object?> get props => [];
}

final class LocationLoaded extends LocationState {
  final List<LocationModel> locations;

  const LocationLoaded({required this.locations});

  @override
  List<Object?> get props => [locations];
}

final class LocationInitial extends LocationState {
  @override
  List<Object?> get props => [];
}

final class LocationFailed extends LocationState {
  final String error;

  const LocationFailed({required this.error});

  @override
  List<Object?> get props => [error];
}