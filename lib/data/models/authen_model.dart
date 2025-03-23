import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:swallet_mobile/data/models.dart';

class AuthenModel extends Equatable {
  final String jwt;
  // final UserModel userModel;
  final bool isVerified;
  final String accountId;
  final String role;

  const AuthenModel({
    required this.jwt,
    required this.accountId,
    required this.isVerified,
    required this.role,
  });

  // factory AuthenModel.fromJson(Map<String, dynamic> json) {

  //   return AuthenModel(
  //     jwt: json['jwt'],
  //     accountId: json['accountId'],
  //     isVerified: json['isVerified'],
  //     role: json['role'],
  //   );
  // }

  factory AuthenModel.fromJson(Map<String, dynamic> json) {
    final jwt = json['token'];
    final accountId = json['accountId'];
    final isVerified = json['isVerify'];
    final role = json['role'];

    if (jwt == null) throw FormatException('jwt không được null');
    if (accountId == null) throw FormatException('accountId không được null');
    if (isVerified == null) throw FormatException('isVerified không được null');
    if (role == null) throw FormatException('role không được null');

    return AuthenModel(
      jwt: jwt as String,
      accountId: accountId as String,
      isVerified: isVerified as bool,
      role: role as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = jwt;
    data['accountId'] = accountId;
    data['isVerify'] = isVerified;
    data['role'] = role;
    return data;
  }

  @override
  List<Object?> get props => [jwt, accountId, isVerified, role];
}
