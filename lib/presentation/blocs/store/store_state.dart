part of 'store_bloc.dart';

sealed class StoreState extends Equatable {
  const StoreState();
}

final class StoreInitial extends StoreState {
  @override
  List<Object> get props => [];
}

final class StoreTransactionLoading extends StoreState {
  @override
  List<Object?> get props => [];
}

final class StoreTransactionsLoaded extends StoreState {
  final List<TransactionStoreModel>? transactions;
  final List<TransactionStoreModel>? activityTransactions;
  final List<TransactionStoreModel>? bonusTransactions;
  final bool hasReachedMax;

  const StoreTransactionsLoaded(
    this.transactions,
    this.activityTransactions,
    this.bonusTransactions, {
    this.hasReachedMax = false,
  });

  @override
  List<Object?> get props => [
    transactions,
    activityTransactions,
    bonusTransactions,
    hasReachedMax,
  ];
}

final class StoreFailed extends StoreState {
  final String error;

  const StoreFailed({required this.error});

  @override
  List<Object?> get props => [error];
}

final class StoreCampaignVoucherLoading extends StoreState {
  @override
  List<Object?> get props => [];
}

final class StoreCampaignVoucherLoaded extends StoreState {
  final CampaignStoreCartModel campaignStoreCart;
  // final bool hasReach

  const StoreCampaignVoucherLoaded({required this.campaignStoreCart});

  @override
  List<Object?> get props => [campaignStoreCart];
}

final class ScanVoucherSuccess extends StoreState {
  final String result;

  const ScanVoucherSuccess({required this.result});

  @override
  List<Object?> get props => [result];
}

final class ScanVoucherLoading extends StoreState {
  @override
  List<Object?> get props => [];
}

final class ScanVoucherFailed extends StoreState {
  final String error;

  const ScanVoucherFailed({required this.error});

  @override
  List<Object?> get props => [error];
}

final class CreateBonusLoading extends StoreState {
  @override
  List<Object?> get props => [];
}

final class CreateBonusSucess extends StoreState {
  final TransactResultModel transactModel;

  CreateBonusSucess({required this.transactModel});

  @override
  List<Object?> get props => [];
}

final class CreateBonusFailed extends StoreState {
  final String error;

  const CreateBonusFailed({required this.error});

  @override
  List<Object?> get props => [error];
}

final class StoreCampaignVoucherDetailLoading extends StoreState {
  @override
  List<Object?> get props => [];
}

final class StoreCampaignVoucherDetailLoaded extends StoreState {
  final CampaignVoucherDetailModel campaignVoucherDetailModel;

  const StoreCampaignVoucherDetailLoaded({
    required this.campaignVoucherDetailModel,
  });

  @override
  List<Object?> get props => [campaignVoucherDetailModel];
}

final class StoreCampaignVoucherDetailFailed extends StoreState {
  final String error;

  const StoreCampaignVoucherDetailFailed({required this.error});

  @override
  List<Object?> get props => [error];
}

final class StoreUpding extends StoreState {
  @override
  List<Object?> get props => [];
}

final class StoreUpdateSuccess extends StoreState {
  final StoreModel storeModel;

  const StoreUpdateSuccess({required this.storeModel});

  @override
  List<Object?> get props => [storeModel];
}

final class StoreUpdateFailed extends StoreState {
  final String error;

  const StoreUpdateFailed({required this.error});

  @override
  List<Object?> get props => [error];
}

final class StoreCampaignVoucherInforLoading extends StoreState {
  @override
  List<Object?> get props => [];
}

final class StoreCampaigVoucherInforSuccess extends StoreState {
  final CampaignVoucherInformationModel campaignVoucherInformationModel;

  StoreCampaigVoucherInforSuccess({
    required this.campaignVoucherInformationModel,
  });

  @override
  List<Object?> get props => [campaignVoucherInformationModel];
}

final class StoreCampaignVoucherInforFailed extends StoreState {
  final String error;

  const StoreCampaignVoucherInforFailed({required this.error});

  @override
  List<Object?> get props => [error];
}

final class StoreByIdLoaed extends StoreState {
  final StoreModel storeModel;

  const StoreByIdLoaed({required this.storeModel});

  @override
  List<Object?> get props => [storeModel];
}

final class StoreByIdLoading extends StoreState {
  @override
  List<Object?> get props => [];
}
