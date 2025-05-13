part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {
  const LocationEvent();
}

// final class AddNewNotification extends LocationEvent {
//   final LocationModel notificationModel;

//   const AddNewNotification({required this.notificationModel});
//   @override
//   List<Object?> get props => [notificationModel];
// }

final class LoadLocation extends LocationEvent {
  @override
  List<Object?> get props => [];
}
final class AddLocation extends LocationEvent {
  @override
  List<Object?> get props => [];
}

