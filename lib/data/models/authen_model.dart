import 'package:equatable/equatable.dart';
import 'package:swallet_mobile/data/models.dart';

class AuthenModel extends Equatable {
  final String jwt;
  final UserModel userModel;
  final String role;

  const AuthenModel({
    required this.jwt,
    required this.userModel,
    required this.role,
  });

  factory AuthenModel.fromJson(Map<String, dynamic> json) {
    var userModel = UserModel.fromJson(json['user']);
    return AuthenModel(
      jwt: json['jwt'],
      userModel: userModel,
      role: json['role'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jwt'] = this.jwt;
    data['user'] = this.userModel.toJson();
    data['role'] = this.role;
    return data;
  }

  @override
  List<Object?> get props => [jwt, userModel, role];
}
