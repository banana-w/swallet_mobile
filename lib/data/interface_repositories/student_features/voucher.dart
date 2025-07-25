import 'package:equatable/equatable.dart';

class Voucher extends Equatable {
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
  final String file;
  final String fileName;
  final String dateCreated;
  final String dateUpdated;
  final String description;
  final bool state;
  final bool status;
  final int numberOfItems;

  const Voucher(
      {required this.id,
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
      required this.file,
      required this.fileName,
      required this.dateCreated,
      required this.dateUpdated,
      required this.description,
      required this.state,
      required this.status,
      required this.numberOfItems});

  @override
  List<Object> get props => [
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
        numberOfItems
      ];
}
