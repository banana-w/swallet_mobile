import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_store_model.dart';
import 'package:swallet_mobile/domain/interface_repositories/student_features/campaign_repository.dart';

part 'campaign_store_event.dart';
part 'campaign_store_state.dart';

class CampaignStoreBloc extends Bloc<CampaignStoreEvent, CampaignStoreState> {
  final CampaignRepository campaignRepository;
  CampaignStoreBloc({required this.campaignRepository})
      : super(CampaignStoreInitial()) {
    on<LoadCampaignStoreById>(_onLoadCampaignStoreById);
  }

  Future<void> _onLoadCampaignStoreById(
      LoadCampaignStoreById event, Emitter<CampaignStoreState> emit) async {
    emit(CampaignStoreLoading());
    try {
      var apiResponse = await campaignRepository.fecthCampaignStoreById(
        event.page,
        event.limit,
        id: event.id,
      );
      emit(CampaignStoreByIdLoaded(campaignStores: apiResponse!.result));
    } catch (e) {
      emit(CampaignStoresFailed(error: e.toString()));
    }
  }
}
