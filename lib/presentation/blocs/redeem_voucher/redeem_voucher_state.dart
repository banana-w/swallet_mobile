part of 'redeem_voucher_bloc.dart';

sealed class RedeemVoucherState extends Equatable {
  const RedeemVoucherState();

  @override
  List<Object?> get props => [];
}

final class RedeemVoucherInitial extends RedeemVoucherState {
  const RedeemVoucherInitial();
}

final class RedeemVoucherLoading extends RedeemVoucherState {
  const RedeemVoucherLoading();
}

final class RedeemVoucherSuccess extends RedeemVoucherState {
  final String text;

  const RedeemVoucherSuccess({required this.text});

  @override
  List<Object?> get props => [text];
}

final class RedeemVoucherFailed extends RedeemVoucherState {
  final String error;

  const RedeemVoucherFailed({required this.error});

  @override
  List<Object?> get props => [error];
}
