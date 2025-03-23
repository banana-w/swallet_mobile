part of 'landing_screen_bloc.dart';

@immutable
abstract class LandingScreenState {
  final int tabIndex;

  const LandingScreenState({required this.tabIndex});
}

final class LandingScreenInitial extends LandingScreenState {
  const LandingScreenInitial({required super.tabIndex});
}
