part of 'brand_bloc.dart';

sealed class BrandState extends Equatable {
  const BrandState();
}

final class BrandInitial extends BrandState {
  @override
  List<Object?> get props => [];
}

final class BrandLoading extends BrandState {
  @override
  List<Object?> get props => [];
}

final class BrandsLoaded extends BrandState {
  final List<BrandModel> brands;
  final bool hasReachedMax;

  BrandsLoaded({required this.brands, this.hasReachedMax = false});
  @override
  List<Object?> get props => [brands, hasReachedMax];
}

final class BrandsFailed extends BrandState {
  final String error;

  BrandsFailed({required this.error});
  @override
  List<Object?> get props => [error];
}

final class BrandByIdLoaded extends BrandState {
  final BrandModel brand;

  BrandByIdLoaded({required this.brand});
  @override
  List<Object?> get props => [brand];
}

final class BrandVouchersByIdLoaded extends BrandState {
  final List<VoucherModel> vouchers;

  BrandVouchersByIdLoaded({required this.vouchers});

  @override
  List<Object?> get props => [vouchers];
}

class BrandCampaignsByIdLoaded extends BrandState {
  final List<CampaignModel> campaignModels;

  const BrandCampaignsByIdLoaded({required this.campaignModels});

  @override
  List<Object?> get props => [campaignModels];
}
