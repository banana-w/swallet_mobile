import 'package:swallet_mobile/domain/entities/store_features/campaign_ranking.dart';

class StudentRankingModel extends CampaignRanking {
  const StudentRankingModel({
    required super.rank,
    required super.name,
    required super.image,
    required super.value,
  });

  factory StudentRankingModel.fromJson(Map<String, dynamic> json) {
    return StudentRankingModel(
      rank: json['rank'],
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      value: json['value'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rank'] = rank;
    data['name'] = name;
    data['image'] = image;
    data['value'] = value;
    return data;
  }
}
