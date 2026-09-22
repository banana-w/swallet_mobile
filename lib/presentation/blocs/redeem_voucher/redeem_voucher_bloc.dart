import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/campaign_repository.dart';

part 'redeem_voucher_event.dart';
part 'redeem_voucher_state.dart';

/// Bloc riêng cho luồng đổi voucher.
///
/// Trước đây luồng này dùng chung [CampaignBloc] với danh sách chiến dịch, nên
/// mỗi lần thanh toán là state danh sách bị thay bằng `RedeemVoucher*` và màn
/// chiến dịch mất dữ liệu. Tách ra để hai luồng không đè state của nhau.
class RedeemVoucherBloc extends Bloc<RedeemVoucherEvent, RedeemVoucherState> {
  RedeemVoucherBloc({required this.campaignRepository})
    : super(const RedeemVoucherInitial()) {
    on<RedeemCampaignVoucher>(_onRedeemCampaignVoucher);
  }

  final CampaignRepository campaignRepository;

  Future<void> _onRedeemCampaignVoucher(
    RedeemCampaignVoucher event,
    Emitter<RedeemVoucherState> emit,
  ) async {
    // Đây là giao dịch trừ điểm: chặn bấm thanh toán nhiều lần.
    if (state is RedeemVoucherLoading) return;
    emit(const RedeemVoucherLoading());
    try {
      final error = await campaignRepository.redeemCampaignVoucher(
        campaignId: event.campaignId,
        studentId: event.studentId,
        voucherId: event.voucherId,
        cost: event.cost,
        quantity: event.quantity,
      );
      if (error != null) {
        emit(RedeemVoucherFailed(error: error));
      } else {
        emit(const RedeemVoucherSuccess(text: 'Thành công'));
      }
    } catch (_) {
      emit(const RedeemVoucherFailed(error: 'Giao dịch thất bại!'));
    }
  }
}
