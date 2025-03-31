import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_voucher_model.dart';
import 'package:swallet_mobile/domain/entities/student_features/campaign_voucher_detail_model.dart';
import 'package:swallet_mobile/domain/interface_repositories/student_features/campaign_repository.dart';

part 'campaign_voucher_event.dart';
part 'campaign_voucher_state.dart';

class CampaignVoucherBloc
    extends Bloc<CampaignVoucherEvent, CampaignVoucherState> {
  final CampaignRepository campaignRepository;
  CampaignVoucherBloc({required this.campaignRepository})
      : super(CampaignVoucherInitial()) {
    on<LoadCampaignVoucher>(_onLoadCampaignVouchers);
    on<LoadCampaignVoucherById>(_onLoadCampaignVoucherById);
  }

  Future<void> _onLoadCampaignVouchers(
      LoadCampaignVoucher event, Emitter<CampaignVoucherState> emit) async {
    emit(CampaignVoucherLoading());
    try {
      var apiResponse = await campaignRepository
          .fecthCampaignVouchersById(event.page, event.limit, id: event.id);
      emit(CampaignVouchersLoaded(
          campaignVouchers: apiResponse!));
    } catch (e) {
      emit(CampaignVoucherFailed(error: e.toString()));
    }
  }

  Future<void> _onLoadCampaignVoucherById(
      LoadCampaignVoucherById event, Emitter<CampaignVoucherState> emit) async {
    emit(CampaignVoucherLoading());
    try {
      var campaignVoucherDetail =
          await campaignRepository.fecthCampaignVoucherDetailById(
              campaignId: event.campaignId,
              campaignVoucherId: event.campaignVoucherId);
      if (campaignVoucherDetail != null) {
        emit(CampaignVoucherByIdLoaded(
            campaignVoucherDetail: campaignVoucherDetail));
      }
    } catch (e) {
      emit(CampaignVoucherFailed(error: e.toString()));
    }
  }
}
