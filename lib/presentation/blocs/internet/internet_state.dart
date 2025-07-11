part of 'internet_bloc.dart';

sealed class InternetState extends Equatable {
  const InternetState();
}

final class InternetInitial extends InternetState {
  @override
  List<Object?> get props => [];
}

final class Connected extends InternetState {
  final String message;

  const Connected({required this.message});

  @override
  List<Object?> get props => [];
}

final class NotConnected extends InternetState {
  final String message;

  const NotConnected({required this.message});

  @override
  List<Object?> get props => [];
}

