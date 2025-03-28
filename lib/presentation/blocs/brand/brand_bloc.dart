import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:swallet_mobile/data/models/student_features/brand_model.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_model.dart';
import 'package:swallet_mobile/data/models/student_features/voucher_model.dart';
import 'package:swallet_mobile/domain/interface_repositories/student_features/brand_repository.dart';

part 'brand_event.dart';
part 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  final BrandRepository brandRepository;
  BrandBloc({required this.brandRepository}) : super(BrandInitial()) {
    scrollController.addListener(() {
      add(LoadMoreBrands());
    });

    on<LoadBrands>(_onLoadBrands);
    on<LoadMoreBrands>(_onLoadMoreBrands);
    on<LoadBrandById>(_onLoadBrandById);
    on<LoadBrandVouchersById>(_onLoadBrandVouchersById);
    on<LoadBrandCampaignsById>(_onLoadBrandCampaignsById);
  }

  int page = 1;
  ScrollController scrollController = ScrollController();
  var isLoadingMore = false;

  //------------
  Future<void> _onLoadBrands(LoadBrands event, Emitter<BrandState> emit) async {
    emit(BrandLoading());
    try {
      var apiResponse = await brandRepository.fecthBrands(
        page: event.page,
        limit: event.limit,
      );
      if (apiResponse!.totalPages < apiResponse.size) {
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
    try {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        isLoadingMore = true;
        page++;
        var apiResponse = await brandRepository.fecthBrands(page: page);
        if (apiResponse!.result.length == 0) {
          emit(
            BrandsLoaded(
              brands: List.from((this.state as BrandsLoaded).brands)
                ..addAll(apiResponse.result),
              hasReachedMax: true,
            ),
          );
        } else {
          emit(
            BrandsLoaded(
              brands: List.from((this.state as BrandsLoaded).brands)
                ..addAll(apiResponse.result),
            ),
          );
        }
      }
    } catch (e) {
      emit(BrandsFailed(error: e.toString()));
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
      final apiResponse = await brandRepository.fecthCampaignssByBrandId(
        event.page,
        event.limit,
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
