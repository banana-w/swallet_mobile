import 'package:equatable/equatable.dart';

class CampaignStore extends Equatable {
  final String id;
  final String brandId;
  final String brandName;
  final String? brandLogo; // Thêm từ JSON, nullable
  final String areaId;
  final String areaName;
  final String? areaImage; // Thêm từ JSON, nullable
  final String accountId;
  final String storeName;
  final String userName;
  final String? avatar; // Nullable vì trong JSON là null
  final String? avatarFileName; // Nullable vì trong JSON là null
  final String? file; // Thêm từ JSON, nullable
  final String? fileName; // Thêm từ JSON, nullable
  final String email;
  final String phone;
  final String address;
  final String? openingHours; // Nullable vì trong JSON là null
  final String? closingHours; // Nullable vì trong JSON là null
  final String dateCreated;
  final String dateUpdated;
  final String description;
  final bool state;
  final bool status;

  const CampaignStore({
    required this.id,
    required this.brandId,
    required this.brandName,
    this.brandLogo, // Không required vì nullable
    required this.areaId,
    required this.areaName,
    this.areaImage, // Không required vì nullable
    required this.accountId,
    required this.storeName,
    required this.userName,
    this.avatar, // Không required vì nullable
    this.avatarFileName, // Không required vì nullable
    this.file, // Không required vì nullable
    this.fileName, // Không required vì nullable
    required this.email,
    required this.phone,
    required this.address,
    this.openingHours, // Không required vì nullable
    this.closingHours, // Không required vì nullable
    required this.dateCreated,
    required this.dateUpdated,
    required this.description,
    required this.state,
    required this.status,
  });


  @override
  List<Object?> get props => [
        id,
        brandId,
        brandName,
        brandLogo,
        areaId,
        areaName,
        areaImage,
        accountId,
        storeName,
        userName,
        avatar,
        avatarFileName,
        file,
        fileName,
        email,
        phone,
        address,
        openingHours,
        closingHours,
        dateCreated,
        dateUpdated,
        description,
        state,
        status,
      ];
}