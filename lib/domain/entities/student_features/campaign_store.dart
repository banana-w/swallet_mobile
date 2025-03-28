import 'package:equatable/equatable.dart';

class CampaignStore extends Equatable {
  final String id;
  final String brandId;
  final String brandName;
  final String areaId;
  final String areaName;
  final String accountId;
  final String storeName;
  final String userName;
  final String avatar;
  final String avatarFileName;
  final String email;
  final String phone;
  final String address;
  final String openingHours;
  final String closingHours;
  final String dateCreated;
  final String dateUpdated;
  final String description;
  final bool state;
  final bool status;

  CampaignStore(
      {required this.id,
      required this.brandId,
      required this.brandName,
      required this.areaId,
      required this.areaName,
      required this.accountId,
      required this.storeName,
      required this.userName,
      required this.avatar,
      required this.avatarFileName,
      required this.email,
      required this.phone,
      required this.address,
      required this.openingHours,
      required this.closingHours,
      required this.dateCreated,
      required this.dateUpdated,
      required this.description,
      required this.state,
      required this.status});

  @override
  List<Object?> get props => [
        this.id,
        this.brandId,
        this.brandName,
        this.areaId,
        this.areaName,
        this.accountId,
        this.storeName,
        this.userName,
        this.avatar,
        this.avatarFileName,
        this.email,
        this.phone,
        this.address,
        this.openingHours,
        this.closingHours,
        this.dateCreated,
        this.dateUpdated,
        this.description,
        this.state,
        this.status
      ];
}
