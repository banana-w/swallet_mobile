import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'landing_screen_event.dart';
part 'landing_screen_state.dart';

class LandingScreenBloc extends Bloc<LandingScreenEvent, LandingScreenState> {
  LandingScreenBloc() : super(const LandingScreenInitial(tabIndex: 3)) {
    on<LandingScreenEvent>((event, emit) {
      if (event is TabChange) {
        emit(LandingScreenInitial(tabIndex: event.tabIndex));
      }
    });
  }
}
