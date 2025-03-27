// lucky_wheel_state.dart
import 'package:swallet_mobile/data/models/student_features/lucky_prize_model.dart';

abstract class LuckyWheelState {}

class LuckyWheelLoading extends LuckyWheelState {}

class LuckyWheelLoaded extends LuckyWheelState {
  final List<LuckyPrize> prizes;
  LuckyWheelLoaded(this.prizes);
}

class LuckyWheelError extends LuckyWheelState {
  final String message;
  LuckyWheelError(this.message);
}
