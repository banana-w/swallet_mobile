import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:swallet_mobile/data/models/student_features/brand_model.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_model.dart';
import 'package:swallet_mobile/data/models/student_features/voucher_model.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/brand_repository.dart';

part 'brand_event.dart';
part 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  final BrandRepository brandRepository;
  final ScrollController scrollController = ScrollController();
  int page = 1;
  bool isLoadingMore = false;
  final bool status;
  BrandBloc({required this.brandRepository, this.status = true})
    : super(BrandInitial()) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        add(LoadMoreBrands());
      }
    });

    on<LoadBrands>(_onLoadBrands);
    on<LoadMoreBrands>(_onLoadMoreBrands);
    on<LoadBrandById>(_onLoadBrandById);
    on<LoadBrandVouchersById>(_onLoadBrandVouchersById);
    on<LoadBrandCampaignsById>(_onLoadBrandCampaignsById);
  }

  //------------
  Future<void> _onLoadBrands(LoadBrands event, Emitter<BrandState> emit) async {
    emit(BrandLoading());
    try {
      var apiResponse = await brandRepository.fetchBrands(
        page: event.page,
        size: event.size, // Thay limit thành size
        status: status, // Thêm status
      );

      if (apiResponse == null) {
        emit(BrandsFailed(error: 'Failed to load brands'));
        return;
      }

      // Kiểm tra nếu đã đạt đến trang cuối
      if (apiResponse.totalPages <= page) {
        emit(
          BrandsLoaded(
            brands: apiResponse.result.toList(),
            hasReachedMax: true,
          ),
        );
      } else {
        emit(BrandsLoaded(brands: apiResponse.result.toList()));
      }
    } catch (e) {
      emit(BrandsFailed(error: e.toString()));
    }
  }

  Future<void> _onLoadMoreBrands(
    LoadMoreBrands event,
    Emitter<BrandState> emit,
  ) async {
    if (isLoadingMore) return; // Tránh gọi nhiều lần khi đang tải

    try {
      isLoadingMore = true;
      page++; // Tăng page để tải trang tiếp theo

      var apiResponse = await brandRepository.fetchBrands(
        page: page,
        size: 10, // Giá trị mặc định cho size, có thể thay đổi
        status: status, // Thêm status
      );

      if (apiResponse == null) {
        emit(BrandsFailed(error: 'Failed to load more brands'));
        return;
      }

      final currentState = state;
      if (currentState is BrandsLoaded) {
        if (apiResponse.result.isEmpty || apiResponse.totalPages <= page) {
          emit(
            BrandsLoaded(
              brands: List.from(currentState.brands)
                ..addAll(apiResponse.result),
              hasReachedMax: true,
            ),
          );
        } else {
          emit(
            BrandsLoaded(
              brands: List.from(currentState.brands)
                ..addAll(apiResponse.result),
              hasReachedMax: false,
            ),
          );
        }
      }
    } catch (e) {
      emit(BrandsFailed(error: e.toString()));
    } finally {
      isLoadingMore = false;
    }
  }

  Future<void> _onLoadBrandById(
    LoadBrandById event,
    Emitter<BrandState> emit,
  ) async {
    emit(BrandLoading());
    try {
      final brandModel = await brandRepository.fecthBrandById(id: event.id);
      emit(BrandByIdLoaded(brand: brandModel!));
    } catch (e) {
      emit(BrandsFailed(error: e.toString()));
    }
  }

  Future<void> _onLoadBrandCampaignsById(
    LoadBrandCampaignsById event,
    Emitter<BrandState> emit,
  ) async {
    emit(BrandLoading());
    try {
      final apiResponse = await brandRepository.fetchCampaignsByBrandId(
        event.page,
        event.size,
        id: event.id,
      );
      emit(BrandCampaignsByIdLoaded(campaignModels: apiResponse!.result));
    } catch (e) {
      emit(BrandsFailed(error: e.toString()));
    }
  }

  Future<void> _onLoadBrandVouchersById(
    LoadBrandVouchersById event,
    Emitter<BrandState> emit,
  ) async {
    emit(BrandLoading());
    try {
      final apiResponse = await brandRepository.fecthVouchersByBrandId(
        event.page,
        event.limit,
        id: event.id,
      );
      emit(BrandVouchersByIdLoaded(vouchers: apiResponse!.result));
    } catch (e) {
      emit(BrandsFailed(error: e.toString()));
    }
  }
}
