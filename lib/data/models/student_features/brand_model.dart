import 'package:swallet_mobile/domain/entities/student_features/brand.dart';

class BrandModel extends Brand {
  BrandModel({
    required super.id,
    required super.accountId,
    required super.brandName,
    required super.acronym,
    required super.userName,
    required super.address,
    // required super.logo,
    // required super.logoFileName,
    required super.coverPhoto,
    required super.coverFileName,
    required super.email,
    required super.phone,
    required super.link,
    required super.openingHours,
    required super.closingHours,
    required super.totalIncome,
    required super.totalSpending,
    required super.dateCreated,
    required super.dateUpdated,
    required super.description,
    required super.state,
    required super.status,
    required super.isFavor,
    required super.numberOfFollowers,
    required super.numberOfCampaigns,
    // required super.greenWalletId,
    // required super.greenWallet,
    // required super.greenWalletName,
    // required super.greenWalletBalance,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'] as String? ?? '',
      accountId: json['accountId'] as String? ?? '',
      brandName: json['brandName'] as String? ?? '',
      acronym: json['acronym'] as String? ?? '',
      userName: json['userName'] as String? ?? '', // Không có trong JSON result
      address: json['address'] as String? ?? '',
      // logo: json['logo'] as String? ?? '', // Không có trong JSON result
      // logoFileName: json['logoFileName'] as String? ?? '', // Không có trong JSON result
      coverPhoto: json['coverPhoto'] as String? ?? '',
      coverFileName: json['coverFileName'] as String? ?? '',
      email: json['email'] as String? ?? '', // Không có trong JSON result
      phone: json['phone'] as String? ?? '', // Không có trong JSON result
      link: json['link'] as String? ?? '',
      openingHours: json['openingHours'] as String? ?? '',
      closingHours: json['closingHours'] as String? ?? '',
      totalIncome: (json['totalIncome'] as num?)?.toDouble() ?? 0.0,
      totalSpending: (json['totalSpending'] as num?)?.toDouble() ?? 0.0,
      dateCreated:
          json['dateCreated'] != null
              ? DateTime.parse(json['dateCreated'] as String).toString()
              : '',
      dateUpdated:
          json['dateUpdated'] != null
              ? DateTime.parse(json['dateUpdated'] as String).toString()
              : '',
      description: json['description'] as String? ?? '',
      state: json['state'] as bool? ?? true,
      status: json['status'] as bool? ?? true,
      isFavor: json['isFavor'] as bool? ?? false, // Không có trong JSON result
      numberOfFollowers:
          json['numberOfFollowers'] as int? ?? 0, // Không có trong JSON result
      numberOfCampaigns:
          json['numberOfCampaigns'] as int? ?? 0, // Không có trong JSON result
      // greenWalletId: json['greenWalletId'] as String? ?? '', // Không có trong JSON result
      // greenWallet: json['greenWallet'] as String? ?? '', // Không có trong JSON result
      // greenWalletName: json['greenWalletName'] as String? ?? '', // Không có trong JSON result
      // greenWalletBalance: (json['greenWalletBalance'] as num?)?.toDouble() ?? 0.0, // Không có trong JSON result
    );
  }

  BrandModel copyWith({
    String? id,
    String? accountId,
    String? brandName,
    String? acronym,
    String? userName,
    String? address,
    String? logo,
    String? logoFileName,
    String? coverPhoto,
    String? coverFileName,
    String? email,
    String? phone,
    String? link,
    String? openingHours,
    String? closingHours,
    double? totalIncome,
    double? totalSpending,
    String? dateCreated,
    String? dateUpdated,
    String? description,
    bool? state,
    bool? status,
    bool? isFavor,
    int? numberOfFollowers,
    int? numberOfCampaigns,
    int? greenWalletId,
    String? greenWallet,
    String? greenWalletName,
    double? greenWalletBalance,
  }) {
    return BrandModel(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      brandName: brandName ?? this.brandName,
      acronym: acronym ?? this.acronym,
      userName: userName ?? this.userName,
      address: address ?? this.address,
      // logo: logo ?? this.logo,
      // logoFileName: logoFileName ?? this.logoFileName,
      coverPhoto: coverPhoto ?? this.coverPhoto,
      coverFileName: coverFileName ?? this.coverFileName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      link: link ?? this.link,
      openingHours: openingHours ?? this.openingHours,
      closingHours: closingHours ?? this.closingHours,
      totalIncome: totalIncome ?? this.totalIncome,
      totalSpending: totalSpending ?? this.totalSpending,
      dateCreated: dateCreated ?? this.dateCreated,
      dateUpdated: dateUpdated ?? this.dateUpdated,
      description: description ?? this.description,
      state: state ?? this.state,
      status: status ?? this.status,
      isFavor: isFavor ?? this.isFavor,
      numberOfFollowers: numberOfFollowers ?? this.numberOfFollowers,
      numberOfCampaigns: numberOfCampaigns ?? this.numberOfCampaigns,
      // greenWalletId: greenWalletId ?? this.greenWalletId,
      // greenWallet: greenWallet ?? this.greenWallet,
      // greenWalletName: greenWalletName ?? this.greenWalletName,
      // greenWalletBalance: greenWalletBalance ?? this.greenWalletBalance,
    );
  }
}
