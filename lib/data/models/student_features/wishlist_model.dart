import 'package:swallet_mobile/domain/entities/student_features/wishlist.dart';

class WishListModel extends WishList {
  WishListModel({
    required super.id,
    required super.studentId,
    required super.studentName,
    required super.studentImage,
    required super.brandId,
    required super.brandName,
    required super.brandImage,
    required super.description,
    required super.state,
    required super.status,
  });

  factory WishListModel.fromJson(Map<String, dynamic> json) {
    return WishListModel(
      id: json['id'],
      studentId: json['studentId'] ?? '',
      studentName: json['studentName'] ?? '',
      studentImage: json['studentImage'] ?? '',
      brandId: json['brandId'] ?? '',
      brandName: json['brandName'] ?? '',
      brandImage: json['brandImage'] ?? '',
      description: json['description'] ?? '',
      state: json['state'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['studentId'] = this.studentId;
    data['studentName'] = this.studentName;
    data['studentImage'] = this.studentImage;
    data['brandId'] = this.brandId;
    data['brandName'] = this.brandName;
    data['brandImage'] = this.brandImage;
    data['description'] = this.description;
    data['state'] = this.state;
    data['status'] = this.status;
    return data;
  }
}
