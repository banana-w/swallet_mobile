part of 'role_app_bloc.dart';

sealed class RoleAppEvent extends Equatable {
  const RoleAppEvent();
}

final class RoleAppStart extends RoleAppEvent {
  RoleAppStart();
  @override
  List<Object?> get props => [];
}

final class RoleAppEnd extends RoleAppEvent {
  RoleAppEnd();
  @override
  List<Object?> get props => [];
}
