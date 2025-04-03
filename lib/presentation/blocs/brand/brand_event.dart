part of 'brand_bloc.dart';

sealed class BrandEvent extends Equatable {
  const BrandEvent();
}

final class LoadBrands extends BrandEvent {
  final int page;
  final int size; // Thay limit thành size

  const LoadBrands({required this.page, this.size = 10});

  @override
  List<Object?> get props => [page, size];
}

final class LoadMoreBrands extends BrandEvent {
  @override
  List<Object?> get props => [];
}

final class LoadBrandById extends BrandEvent {
  final String id;

  const LoadBrandById({required this.id});

  @override
  List<Object?> get props => [id];
}

final class LoadBrandVouchersById extends BrandEvent {
  final int page;
  final int limit;
  final String id;

  const LoadBrandVouchersById({this.page = 1, this.limit = 5, required this.id});

  @override
  List<Object?> get props => [page, limit, id];
}

final class LoadBrandCampaignsById extends BrandEvent {
  final int page;
  final int size; // Thay limit thành size
  final String id;

  const LoadBrandCampaignsById({
    required this.page,
    required this.size,
    required this.id,
  });

  @override
  List<Object?> get props => [page, size, id];
}
