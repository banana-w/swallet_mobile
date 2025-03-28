part of 'notification_bloc.dart';

sealed class NotificationEvent extends Equatable {
  const NotificationEvent();
}

final class AddNewNotification extends NotificationEvent {
  final NotificationModel notificationModel;

  const AddNewNotification({required this.notificationModel});
  @override
  List<Object?> get props => [notificationModel];
}

final class LoadNotification extends NotificationEvent {
  @override
  List<Object?> get props => [];
}

final class ClearNotification extends NotificationEvent {
  @override
  List<Object?> get props => [];
}
