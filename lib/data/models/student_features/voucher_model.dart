import 'package:swallet_mobile/domain/interface_repositories/student_features/voucher.dart';

class VoucherModel extends Voucher {
  VoucherModel({
    required super.id,
    required super.brandId,
    required super.brandName,
    required super.typeId,
    required super.typeName,
    required super.voucherName,
    required super.price,
    required super.rate,
    required super.condition,
    required super.image,
    required super.imageName,
    required super.file,
    required super.fileName,
    required super.dateCreated,
    required super.dateUpdated,
    required super.description,
    required super.state,
    required super.status,
    required super.numberOfItems,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      id: json['id'],
      brandId: json['brandId'],
      brandName: json['brandName'],
      typeId: json['typeId'],
      typeName: json['typeName'],
      voucherName: json['voucherName'],
      price: json['price'],
      rate: json['rate'],
      condition: json['condition'] ?? '',
      image: json['image'] ?? '',
      imageName: json['imageName'] ?? '',
      file: json['file'] ?? '',
      fileName: json['fileName'] ?? '',
      dateCreated: json['dateCreated'] ?? '',
      dateUpdated: json['dateUpdated'] ?? '',
      description: json['description'] ?? '',
      state: json['state'],
      status: json['status'],
      numberOfItems: json['numberOfItems'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['brandId'] = brandId;
    data['brandName'] = brandName;
    data['typeId'] = typeId;
    data['typeName'] = typeName;
    data['voucherName'] = voucherName;
    data['price'] = price;
    data['rate'] = rate;
    data['condition'] = condition;
    data['image'] = image;
    data['imageName'] = imageName;
    data['file'] = file;
    data['fileName'] = fileName;
    data['dateCreated'] = dateCreated;
    data['dateUpdated'] = dateUpdated;
    data['description'] = description;
    data['state'] = state;
    data['status'] = status;
    data['numberOfItems'] = numberOfItems;
    return data;
  }

  // static List<VoucherModel> listCampaign = [
  //   VoucherModel(
  //       name: 'Giảm 30k cho hóa đơn từ 100l - Highland Coffee',
  //       assetImage: 'assets/images/voucher-1.png'),
  //   VoucherModel(
  //       name: 'Giảm 60k cho khách hàng mới - Starbuck Coffee',
  //       assetImage: 'assets/images/voucher2.jpg'),
  //   VoucherModel(
  //       name: 'Giảm 30k cho hóa đơn từ 100l - Highland Coffee',
  //       assetImage: 'assets/images/voucher-1.png'),
  //   VoucherModel(
  //       name: 'Giảm 60k cho khách hàng mới - Starbuck Coffee',
  //       assetImage: 'assets/images/voucher2.jpg'),
  // ];
}
