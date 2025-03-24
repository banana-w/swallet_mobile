part of 'campus_bloc.dart';

sealed class CampusEvent extends Equatable {
  const CampusEvent();
}

final class LoadCampus extends CampusEvent {
  final String universityId;
  final String searchName;

  LoadCampus({required this.universityId, required this.searchName});

  @override
  List<Object?> get props => [universityId];
}
