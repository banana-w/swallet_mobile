part of 'role_app_bloc.dart';

sealed class RoleAppEvent extends Equatable {
  const RoleAppEvent();
}

final class RoleAppStart extends RoleAppEvent {
  const RoleAppStart();
  @override
  List<Object?> get props => [];
}

final class RoleAppEnd extends RoleAppEvent {
  const RoleAppEnd();
  @override
  List<Object?> get props => [];
}
