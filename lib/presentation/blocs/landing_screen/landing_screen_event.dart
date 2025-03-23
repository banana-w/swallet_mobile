part of 'landing_screen_bloc.dart';

@immutable
abstract class LandingScreenEvent {}

class TabChange extends LandingScreenEvent {
  final int tabIndex;

  TabChange({required this.tabIndex});
}
