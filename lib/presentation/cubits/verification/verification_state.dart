part of 'verification_cubit.dart';

sealed class VerificationState extends Equatable {
  const VerificationState();
}

final class VerificationInitial extends VerificationState {
  @override
  List<Object> get props => [];
}

final class VerificationLoading extends VerificationState {
  @override
  List<Object> get props => [];
}

final class OTPVerificationSuccess extends VerificationState {
  @override
  List<Object> get props => [];
}

final class OTPVerificationFailed extends VerificationState {
  final String error;

  OTPVerificationFailed({required this.error});
  @override
  List<Object> get props => [error];
}
