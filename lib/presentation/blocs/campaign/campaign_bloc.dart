import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_detail_model.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_model.dart';
import 'package:swallet_mobile/domain/interface_repositories/student_features/campaign_repository.dart';

part 'campaign_event.dart';
part 'campaign_state.dart';

class CampaignBloc extends Bloc<CampaignEvent, CampaignState> {
  final CampaignRepository campaignRepository;

  CampaignBloc({required this.campaignRepository}) : super(CampaignInitial()) {
    scrollController.addListener(() {
      add(LoadMoreCampaigns());
    });
    on<LoadCampaigns>(_onLoadCampaigns);
    on<LoadMoreCampaigns>(_onLoadMoreCampaigns);
    on<LoadCampaignById>(_onLoadCampaignById);
    on<RedeemCampaignVoucher>(_onRedeemCampaignVoucher);
  }

  ScrollController scrollController = ScrollController();
  var isLoadingMore = false;

  int page = 1;

  //Function--------
  Future<void> _onLoadCampaigns(
    LoadCampaigns event,
    Emitter<CampaignState> emit,
  ) async {
    emit(CampaignLoading());
    try {
      var apiResponse = await campaignRepository.fecthCampaigns(
        searchName: null,
        page: event.page,
        size: event.limit,
      );
      if (apiResponse!.totalPages < apiResponse.size) {
        emit(
          CampaignsLoaded(
            campaigns: apiResponse.result.toList(),
            hasReachMax: true,
          ),
        );
      } else {
        emit(CampaignsLoaded(campaigns: apiResponse.result.toList()));
      }
    } catch (e) {
      emit(CampaignsFailed(error: e.toString()));
    }
  }

  Future<void> _onLoadMoreCampaigns(
    LoadMoreCampaigns event,
    Emitter<CampaignState> emit,
  ) async {
    try {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if ((state as CampaignsLoaded).hasReachMax) {
          emit(
            CampaignsLoaded(
              campaigns: List.from((state as CampaignsLoaded).campaigns),
              hasReachMax: true,
            ),
          );
        } else {
          isLoadingMore = true;
          page++;
          var apiResponse = await campaignRepository.fecthCampaigns(
            page: page,
            size: event.limit,
          );
          if (apiResponse!.result.isEmpty) {
            emit(
              CampaignsLoaded(
                campaigns: List.from((state as CampaignsLoaded).campaigns)
                  ..addAll(apiResponse.result),
                hasReachMax: true,
              ),
            );
            page = 1;
          } else {
            emit(
              CampaignsLoaded(
                campaigns: List.from((state as CampaignsLoaded).campaigns)
                  ..addAll(apiResponse.result),
              ),
            );
          }
        }
      }
    } catch (e) {
      emit(CampaignsFailed(error: e.toString()));
    }
  }

  Future<void> _onLoadCampaignById(
    LoadCampaignById event,
    Emitter<CampaignState> emit,
  ) async {
    emit(CampaignLoading());
    try {
      var campaignModel = await campaignRepository.fecthCampaignById(
        id: event.id,
      );
      emit(CampaignByIdLoaded(campaignDetailModel: campaignModel!));
    } catch (e) {
      emit(CampaignsFailed(error: e.toString()));
    }
  }

  Future<void> _onRedeemCampaignVoucher(
    RedeemCampaignVoucher event,
    Emitter<CampaignState> emit,
  ) async {
    emit(RedeemVoucherLoading());
    try {
      var result = await campaignRepository.redeemCampaignVoucher(
        campaignId: event.campaignId,
        campaignVoucherId: event.campaignDetailId,
        studentId: event.studentId,
        description: event.description,
        quantity: event.quantity,
      );
      if (result != null) {
        emit(RedeemVoucherFailed(error: result));
      } else {
        emit(RedeemVoucherSuccess(text: 'Thành công'));
      }
    } catch (e) {
      emit(RedeemVoucherFailed(error: 'Giao dịch thất bại!'));
    }
  }
}
