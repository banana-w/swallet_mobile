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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brandId'] = this.brandId;
    data['brandName'] = this.brandName;
    data['typeId'] = this.typeId;
    data['typeName'] = this.typeName;
    data['voucherName'] = this.voucherName;
    data['price'] = this.price;
    data['rate'] = this.rate;
    data['condition'] = this.condition;
    data['image'] = this.image;
    data['imageName'] = this.imageName;
    data['file'] = this.file;
    data['fileName'] = this.fileName;
    data['dateCreated'] = this.dateCreated;
    data['dateUpdated'] = this.dateUpdated;
    data['description'] = this.description;
    data['state'] = this.state;
    data['status'] = this.status;
    data['numberOfItems'] = this.numberOfItems;
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
