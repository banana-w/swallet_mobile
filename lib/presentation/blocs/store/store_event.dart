part of 'store_bloc.dart';

sealed class StoreEvent extends Equatable {
  const StoreEvent();
}

final class LoadStoreTransactions extends StoreEvent {
  final int page;
  final int limit;
  final String id;
  final int typeIds;
  const LoadStoreTransactions({
    this.page = 1,
    this.limit = 10,
    required this.id,
    this.typeIds = 0,
  });

  @override
  List<Object?> get props => [page, limit, id, typeIds];
}

final class LoadMoreTransactionStore extends StoreEvent {
  final int page;
  final int limit;
  final int typeIds;
  final ScrollController scrollController;

  const LoadMoreTransactionStore(
    this.scrollController, {
    this.page = 1,
    this.limit = 10,
    this.typeIds = 0,
  });
  @override
  List<Object?> get props => [page, limit, typeIds, scrollController];
}

final class LoadStoreCampaignVouchers extends StoreEvent {
  final int page;
  final int limit;
  final String search;

  const LoadStoreCampaignVouchers({
    this.page = 1,
    this.limit = 100,
    this.search = '',
  });

  @override
  List<Object?> get props => [page, limit, search];
}

final class ScanVoucherCode extends StoreEvent {
  final String storeId;
  final String voucherId;
  final String studentId;
 

  const ScanVoucherCode({
    required this.storeId,
    required this.voucherId,
    required this.studentId,
  });

  @override
  List<Object?> get props => [storeId, voucherId, studentId];
}

final class CreateBonus extends StoreEvent {
  final String storeId;
  final String studentId;
  final double amount;
  final String description;
  final bool state;

  const CreateBonus({
    required this.storeId,
    required this.studentId,
    required this.amount,
    required this.description,
    required this.state,
  });

  @override
  List<Object?> get props => [storeId, studentId, amount, description, state];
}

final class LoadCampaignVoucherDetail extends StoreEvent {
  final String storeId;
  final String campaignVoucherId;

  const LoadCampaignVoucherDetail({
    required this.storeId,
    required this.campaignVoucherId,
  });

  @override
  List<Object?> get props => [storeId, campaignVoucherId];
}

final class UpdateStore extends StoreEvent {
  final String storeId;
  final String areaId;
  final String storeName;
  final String address;
  final String openHours;
  final String closeHours;
  final String description;
  final String avatar;
  final bool state;

  const UpdateStore({
    required this.areaId,
    required this.storeId,
    required this.storeName,
    required this.address,
    required this.openHours,
    required this.closeHours,
    required this.description,
    this.avatar = '',
    required this.state,
  });

  @override
  List<Object?> get props => [
    areaId,
    storeName,
    address,
    openHours,
    closeHours,
    description,
    avatar,
    state,
    address,
  ];
}

final class LoadCampaignVoucherInformation extends StoreEvent {
  final String voucherCode;

  const LoadCampaignVoucherInformation({
    required this.voucherCode,
  });
  @override
  List<Object?> get props => [voucherCode];
}

final class LoadStoreById extends StoreEvent {
  final String accountId;

  const LoadStoreById({required this.accountId});

  @override
  List<Object?> get props => [accountId];
}
