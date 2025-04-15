part of 'check_in_bloc.dart';

class CheckInState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckInLoading extends CheckInState {}

class CheckInSuccess extends CheckInState {}


class CheckInLoaded extends CheckInState {
  final List<bool> checkInHistory; // Lịch sử điểm danh (7 ngày)
  final int streak; // Chuỗi điểm danh liên tục
  final int points; // Tổng điểm thưởng
  final bool canCheckInToday; // Có thể điểm danh hôm nay không
  final int currentDayIndex; // Index của ngày hiện tại trong chuỗi 7 ngày
  final int rewardPoints; // Phần thưởng nhận được hôm nay

  CheckInLoaded({
    required this.checkInHistory,
    required this.streak,
    required this.points,
    required this.canCheckInToday,
    required this.currentDayIndex,
    required this.rewardPoints, // Thêm rewardPoints
  });

  @override
  List<Object?> get props => [
    checkInHistory,
    streak,
    points,
    canCheckInToday,
    currentDayIndex,
    rewardPoints, // Thêm vào props
  ];
}

class CheckInError extends CheckInState {
  final String message;

  CheckInError(this.message);

  @override
  List<Object?> get props => [message];
}
