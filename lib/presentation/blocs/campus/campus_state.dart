part of 'campus_bloc.dart';

sealed class CampusState extends Equatable {
  const CampusState();
}


final class CampusLoading extends CampusState {
  @override
  List<Object?> get props => [];
}

final class CampusLoaded extends CampusState {
  final List<CampusModel> campuses;

  CampusLoaded({required this.campuses});
  @override
  List<Object?> get props => [campuses];
}

final class CampusFailed extends CampusState {
  final String error;

  CampusFailed({required this.error});
  
  @override
  List<Object?> get props => [error];
  
}
