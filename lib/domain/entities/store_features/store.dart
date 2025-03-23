import 'package:equatable/equatable.dart';

class Store extends Equatable {
  final String id;
  final String brandId;
  final String brandName;
  final String brandLogo;
  final String areaId;
  final String areaName;
  final String areaImage;
  final String accountId;
  final String storeName;
  final String userName;
  final String avatar;
  final String avatarFileName;
  final String file;
  final String fileName;
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
  final int numberOfCampaigns;
  final int numberOfVouchers;
  final int numberOfBonuses;
  final double amountOfBonuses;

  Store({
    required this.id,
    required this.brandId,
    required this.brandName,
    required this.brandLogo,
    required this.areaId,
    required this.areaName,
    required this.areaImage,
    required this.accountId,
    required this.storeName,
    required this.userName,
    required this.avatar,
    required this.avatarFileName,
    required this.file,
    required this.fileName,
    required this.email,
    required this.phone,
    required this.address,
    required this.openingHours,
    required this.closingHours,
    required this.dateCreated,
    required this.dateUpdated,
    required this.description,
    required this.state,
    required this.status,
    required this.numberOfCampaigns,
    required this.numberOfVouchers,
    required this.numberOfBonuses,
    required this.amountOfBonuses,
  });

  @override
  List<Object?> get props => [
    this.id,
    this.brandId,
    this.brandName,
    this.brandLogo,
    this.areaId,
    this.areaName,
    this.areaImage,
    this.accountId,
    this.storeName,
    this.userName,
    this.avatar,
    this.avatarFileName,
    this.file,
    this.fileName,
    this.email,
    this.phone,
    this.address,
    this.openingHours,
    this.closingHours,
    this.dateCreated,
    this.dateUpdated,
    this.description,
    this.state,
    this.status,
    this.numberOfCampaigns,
    this.numberOfVouchers,
    this.numberOfBonuses,
    this.amountOfBonuses,
  ];
}
