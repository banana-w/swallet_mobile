import 'package:swallet_mobile/domain/entities/student_features/wishlist.dart';

class WishListModel extends WishList {
  const WishListModel({
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['studentId'] = studentId;
    data['studentName'] = studentName;
    data['studentImage'] = studentImage;
    data['brandId'] = brandId;
    data['brandName'] = brandName;
    data['brandImage'] = brandImage;
    data['description'] = description;
    data['state'] = state;
    data['status'] = status;
    return data;
  }
}
