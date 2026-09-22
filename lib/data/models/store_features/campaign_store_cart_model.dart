import 'package:equatable/equatable.dart';
import 'package:swallet_mobile/data/models/store_features/campaign_voucher_store_model.dart';

class CampaignStoreCartModel extends Equatable {
  final List<CampaignVoucherStoreModel> campaignVouchers;

  const CampaignStoreCartModel({required this.campaignVouchers});

  /// Gom ưu đãi theo tên chiến dịch để màn danh sách dựng từng nhóm.
  Map<String?, List<CampaignVoucherStoreModel>> voucherCampaign(
    List<CampaignVoucherStoreModel> campaignVouchers,
  ) {
    Map<String?, List<CampaignVoucherStoreModel>> filterCampaign = {};

    for (var campaignVoucher in campaignVouchers) {
      List<CampaignVoucherStoreModel> listItem = [];
      if (!filterCampaign.containsKey(campaignVoucher.campaignName)) {
        listItem.add(campaignVoucher);
        filterCampaign[campaignVoucher.campaignName] = listItem;
        listItem = [];
      } else {
        filterCampaign.forEach((key, value) {
          if (key != null && campaignVoucher.campaignName.contains(key)) {
            value.add(campaignVoucher);
          }
        });
      }
    }
    return filterCampaign;
  }

  @override
  List<Object?> get props => [campaignVouchers];
}
