import 'package:equatable/equatable.dart';
import 'package:swallet_mobile/data/models/store_features/campaign_voucher_store_model.dart';

import '../../models.dart';

class CampaignStoreCartModel extends Equatable {
  final List<CampaignVoucherStoreModel> campaignVouchers;

  CampaignStoreCartModel({required this.campaignVouchers});

  Map voucherCampaign(List<CampaignVoucherStoreModel> campaignVouchers) {
    Map<String?, List<CampaignVoucherStoreModel>> filterCampaign = {};

    campaignVouchers.forEach((campaignVoucher) {
      List<CampaignVoucherStoreModel> listItem = [];
      if (!filterCampaign.containsKey(campaignVoucher.campaignName)) {
        listItem.add(campaignVoucher);
        filterCampaign[campaignVoucher.campaignName] = listItem;
        listItem = [];
      } else {
        filterCampaign.forEach((key, value) {
          if (campaignVoucher.campaignName.contains(key!)) {
            value.add(campaignVoucher);
          }
        });
      }
    });
    return filterCampaign;
  }

  @override
  List<Object?> get props => [campaignVouchers];
}
