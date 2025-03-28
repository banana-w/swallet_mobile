// lucky_wheel_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/data/repositories/student_features/lucky_prize_repository.dart';
import 'package:swallet_mobile/presentation/blocs/lucky/lucky_wheel_event.dart';
import 'package:swallet_mobile/presentation/blocs/lucky/lucky_wheel_state.dart';

class LuckyWheelBloc extends Bloc<LuckyWheelEvent, LuckyWheelState> {
  final LuckyPrizeRepository repository;

  LuckyWheelBloc({required this.repository}) : super(LuckyWheelLoading()) {
    on<LoadPrizes>(_onLoadPrizes);
  }

  Future<void> _onLoadPrizes(
    LoadPrizes event,
    Emitter<LuckyWheelState> emit,
  ) async {
    emit(LuckyWheelLoading());
    try {
      final prizes = await repository.getActivePrizes();
      emit(LuckyWheelLoaded(prizes));
    } catch (e) {
      emit(LuckyWheelError(e.toString()));
    }
  }
}
