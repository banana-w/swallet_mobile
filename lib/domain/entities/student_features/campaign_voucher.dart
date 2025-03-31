import 'package:equatable/equatable.dart';

class CampaignVoucher extends Equatable {
  final String id;
  final String brandId;
  final String brandName;
  final String typeId;
  final String typeName;
  final String voucherName;
  final double price;
  final double rate;
  final String condition;
  final String image;
  final String imageName;
  final String? file; // Nullable vì có thể là null
  final String? fileName; // Nullable vì có thể là null
  final String dateCreated;
  final String dateUpdated;
  final String description;
  final bool state;
  final bool status;
  final int numberOfItems;
  final int? numberOfItemsAvailable; // Nullable vì trong JSON là null

  const CampaignVoucher({
    required this.id,
    required this.brandId,
    required this.brandName,
    required this.typeId,
    required this.typeName,
    required this.voucherName,
    required this.price,
    required this.rate,
    required this.condition,
    required this.image,
    required this.imageName,
    this.file,
    this.fileName,
    required this.dateCreated,
    required this.dateUpdated,
    required this.description,
    required this.state,
    required this.status,
    required this.numberOfItems,
    this.numberOfItemsAvailable,
  });

  factory CampaignVoucher.fromJson(Map<String, dynamic> json) {
    return CampaignVoucher(
      id: json['id'] as String,
      brandId: json['brandId'] as String,
      brandName: json['brandName'] as String,
      typeId: json['typeId'] as String,
      typeName: json['typeName'] as String,
      voucherName: json['voucherName'] as String,
      price: (json['price'] as num).toDouble(),
      rate: (json['rate'] as num).toDouble(),
      condition: json['condition'] as String,
      image: json['image'] as String,
      imageName: json['imageName'] as String,
      file: json['file'] as String?,
      fileName: json['fileName'] as String?,
      dateCreated: json['dateCreated'] as String,
      dateUpdated: json['dateUpdated'] as String,
      description: json['description'] as String,
      state: json['state'] as bool,
      status: json['status'] as bool,
      numberOfItems: json['numberOfItems'] as int,
      numberOfItemsAvailable: json['numberOfItemsAvailable'] as int?,
    );
  }

  @override
  List<Object?> get props => [
        id,
        brandId,
        brandName,
        typeId,
        typeName,
        voucherName,
        price,
        rate,
        condition,
        image,
        imageName,
        file,
        fileName,
        dateCreated,
        dateUpdated,
        description,
        state,
        status,
        numberOfItems,
        numberOfItemsAvailable,
      ];
}
