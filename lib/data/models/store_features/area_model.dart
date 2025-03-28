import 'package:swallet_mobile/domain/entities/store_features/area.dart';

class AreaModel extends Area {
  AreaModel({
    required super.id,
    required super.areaName,
    required super.image,
    required super.fileName,
    required super.address,
    required super.dateCreated,
    required super.dateUpdated,
    required super.description,
    required super.state,
    required super.status,
  });

  factory AreaModel.fromJson(Map<String, dynamic> json) {
    return AreaModel(
      id: json['id'],
      areaName: json['areaName'] ?? '',
      image: json['image'] ?? '',
      fileName: json['fileName'] ?? '',
      address: json['address'] ?? '',
      dateCreated: json['dateCreated'] ?? '',
      dateUpdated: json['dateUpdated'] ?? '',
      description: json['description'] ?? '',
      state: json['state'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['areaName'] = this.areaName;
    data['image'] = this.image;
    data['fileName'] = this.fileName;
    data['address'] = this.address;
    data['dateCreated'] = this.dateCreated;
    data['dateUpdated'] = this.dateUpdated;
    data['description'] = this.description;
    data['state'] = this.state;
    data['status'] = this.status;
    return data;
  }
}
