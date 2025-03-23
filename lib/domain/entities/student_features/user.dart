import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String userId;
  final String name;
  final int roleId;
  final String role;
  final String roleName;
  final String userName;
  final String phone;
  final String email;
  final String avatar;
  final String fileName;
  final bool isVerify;
  final String dateCreated;
  final String dateUpdated;
  final String dateVerified;
  final String description;
  final int stateId;
  final String state;
  final bool status;

  User({
    required this.id,
    required this.userId,
    required this.name,
    required this.roleId,
    required this.role,
    required this.roleName,
    required this.userName,
    required this.phone,
    required this.email,
    required this.avatar,
    required this.fileName,
    required this.isVerify,
    required this.dateCreated,
    required this.dateUpdated,
    required this.dateVerified,
    required this.description,
    required this.state,
    required this.stateId,
    required this.status,
  });

  @override
  List<Object?> get props => [
    this.id,
    this.userId,
    this.name,
    this.roleId,
    this.role,
    this.roleName,
    this.userName,
    this.phone,
    this.email,
    this.avatar,
    this.fileName,
    this.isVerify,
    this.dateCreated,
    this.dateUpdated,
    this.dateVerified,
    this.description,
    this.state,
    this.stateId,
    this.status,
  ];
}
