import 'package:equatable/equatable.dart';

class CampaignRanking extends Equatable {
  final int rank;
  final String name;
  final String image;
  final double value;

  const CampaignRanking({
    required this.rank,
    required this.name,
    required this.image,
    required this.value,
  });

  @override
  List<Object?> get props => [rank, name, image, value];
}
