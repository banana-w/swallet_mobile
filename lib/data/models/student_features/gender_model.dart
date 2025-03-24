import 'package:equatable/equatable.dart';

class GenderModel extends Equatable {
  final int id;
  final String name;

  GenderModel({required this.id, required this.name});
  
  @override
  List<Object?> get props => [id,name];

  static final genders = <GenderModel>[
    GenderModel(id: 1, name: 'Nữ'),
    GenderModel(id: 2, name: 'Nam')
  ];
}
