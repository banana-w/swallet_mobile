part of 'campaign_voucher_bloc.dart';

sealed class CampaignVoucherState extends Equatable {
  const CampaignVoucherState();
}

final class CampaignVoucherInitial extends CampaignVoucherState {
  @override
  List<Object?> get props => [];
}

final class CampaignVoucherLoading extends CampaignVoucherState {
  @override
  List<Object?> get props => [];
}

final class CampaignVouchersLoaded extends CampaignVoucherState {
  final List<CampaignVoucherModel> campaignVouchers;

  const CampaignVouchersLoaded({required this.campaignVouchers});

  @override
  List<Object?> get props => [campaignVouchers];
}

final class CampaignVoucherFailed extends CampaignVoucherState {
  final String error;

  const CampaignVoucherFailed({required this.error});

  @override
  List<Object?> get props => [error];
}

final class CampaignVoucherByIdLoaded extends CampaignVoucherState {
  final CampaignVoucherDetailModel campaignVoucherDetail;

  const CampaignVoucherByIdLoaded({required this.campaignVoucherDetail});

  @override
  List<Object?> get props => [];
}
