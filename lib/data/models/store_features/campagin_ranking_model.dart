import 'package:swallet_mobile/domain/entities/store_features/campaign_ranking.dart';

class CampaignRankingModel extends CampaignRanking {
  CampaignRankingModel({
    required super.rank,
    required super.name,
    required super.image,
    required super.value,
  });

  factory CampaignRankingModel.fromJson(Map<String, dynamic> json) {
    return CampaignRankingModel(
      rank: json['rank'],
      name: json['name'],
      image: json['image'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rank'] = this.rank;
    data['name'] = this.name;
    data['image'] = this.image;
    data['value'] = this.value;
    return data;
  }
}
