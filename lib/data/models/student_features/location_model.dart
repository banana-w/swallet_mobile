import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String id;
  final String name;
  final String address;

  const Location({
    required this.id,
    required this.name,
    required this.address,
  });

  @override
  List<Object> get props => [id, name, address];
}

class LocationModel extends Location {
  const LocationModel({
    required super.id,
    required super.name,
    required super.address,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
    };
  }
}

