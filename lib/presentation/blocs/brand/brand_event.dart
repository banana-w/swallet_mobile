part of 'brand_bloc.dart';

sealed class BrandEvent extends Equatable {
  const BrandEvent();
}

final class LoadBrands extends BrandEvent {
  final int page;
  final int limit;

  LoadBrands({ this.page = 1,  this.limit = 10});
  
  @override
  List<Object?> get props => [page, limit];
}

final class LoadMoreBrands extends BrandEvent {
  @override
  List<Object?> get props => [];
}

final class LoadBrandById extends BrandEvent {
  final String id;

  LoadBrandById({required this.id});

  @override
  List<Object?> get props => [id];
}

final class LoadBrandVouchersById extends BrandEvent {
  final int page;
  final int limit;
  final String id;

  LoadBrandVouchersById({this.page = 1, this.limit = 5, required this.id});

  @override
  List<Object?> get props => [page, limit, id];
}

final class LoadBrandCampaignsById extends BrandEvent {
  final int page;
  final int limit;
  final String id;

  LoadBrandCampaignsById({this.page = 1, this.limit = 5, required this.id});

  @override
  List<Object?> get props => [page, limit, id];
}
