import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/data/models/api_response.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_detail_model.dart';
import 'package:swallet_mobile/data/models/student_features/campaign_model.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/campaign_repository.dart';

part 'campaign_event.dart';
part 'campaign_state.dart';

class CampaignBloc extends Bloc<CampaignEvent, CampaignState> {
  final CampaignRepository campaignRepository;

  CampaignBloc({required this.campaignRepository})
    : super(const CampaignInitial()) {
    on<LoadCampaigns>(_onLoadCampaigns);
    on<LoadMoreCampaigns>(_onLoadMoreCampaigns);
    on<LoadCampaignById>(_onLoadCampaignById);
  }

  static const String _loadError = 'Không tải được dữ liệu chiến dịch.';

  int _page = 1;
  int _pageSize = 20;
  bool _isLoadingMore = false;

  //Function--------
  Future<void> _onLoadCampaigns(
    LoadCampaigns event,
    Emitter<CampaignState> emit,
  ) async {
    emit(const CampaignLoading());
    // Mọi lần tải lại đều bắt đầu lại từ đầu, nếu không trang kế tiếp sẽ lệch.
    _page = event.page;
    _pageSize = event.limit;
    _isLoadingMore = false;
    try {
      final apiResponse = await campaignRepository.fecthCampaigns(
        searchName: null,
        page: event.page,
        size: event.limit,
      );
      if (apiResponse == null) {
        return emit(const CampaignsFailed(error: _loadError));
      }
      emit(
        CampaignsLoaded(
          campaigns: apiResponse.result,
          hasReachMax: _hasReachedMax(apiResponse),
        ),
      );
    } catch (e) {
      emit(CampaignsFailed(error: e.toString()));
    }
  }

  Future<void> _onLoadMoreCampaigns(
    LoadMoreCampaigns event,
    Emitter<CampaignState> emit,
  ) async {
    final current = state;
    if (current is! CampaignsLoaded || current.hasReachMax || _isLoadingMore) {
      return;
    }
    _isLoadingMore = true;
    try {
      final apiResponse = await campaignRepository.fecthCampaigns(
        page: _page + 1,
        size: _pageSize,
      );
      // Trang kế tiếp lỗi thì giữ nguyên danh sách đang có, chỉ dừng tải thêm.
      if (apiResponse == null) {
        return emit(
          CampaignsLoaded(campaigns: current.campaigns, hasReachMax: true),
        );
      }
      _page++;
      emit(
        CampaignsLoaded(
          campaigns: [...current.campaigns, ...apiResponse.result],
          hasReachMax: _hasReachedMax(apiResponse),
        ),
      );
    } catch (_) {
      emit(CampaignsLoaded(campaigns: current.campaigns, hasReachMax: true));
    } finally {
      _isLoadingMore = false;
    }
  }

  bool _hasReachedMax(ApiResponse<List<CampaignModel>> response) =>
      response.result.isEmpty ||
      (response.totalPages > 0 && _page >= response.totalPages);

  Future<void> _onLoadCampaignById(
    LoadCampaignById event,
    Emitter<CampaignState> emit,
  ) async {
    emit(const CampaignLoading());
    try {
      final campaignModel = await campaignRepository.fecthCampaignById(
        id: event.id,
      );
      if (campaignModel == null) {
        return emit(const CampaignsFailed(error: _loadError));
      }
      emit(CampaignByIdLoaded(campaignDetailModel: campaignModel));
    } catch (e) {
      emit(CampaignsFailed(error: e.toString()));
    }
  }
}
