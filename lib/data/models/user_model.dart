import 'package:swallet_mobile/domain/entities.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.userId,
    required super.name,
    required super.roleId,
    required super.roleName,
    required super.userName,
    required super.phone,
    required super.email,
    required super.avatar,
    required super.fileName,
    required super.isVerify,
    required super.dateCreated,
    required super.dateUpdated,
    required super.dateVerified,
    required super.description,
    required super.state,
    required super.status,
    required super.role,
    required super.stateId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      userId: json['userId'] ?? '',
      name: json['name'] ?? '',
      roleId: json['roleId'],
      role: json['role'],
      roleName: json['roleName'],
      userName: json['userName'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'] ?? '',
      fileName: json['fileName'] ?? '',
      isVerify: json['isVerify'],
      dateCreated: json['dateCreated'],
      dateUpdated: json['dateUpdated'],
      dateVerified: json['dateVerified'] ?? '',
      description: json['description'] ?? '',
      state: json['state'] ?? '',
      stateId: json['stateId'] ?? 0,
      status: json['status'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['roleId'] = this.roleId;
    data['role'] = this.role;
    data['roleName'] = this.roleName;
    data['userName'] = this.userName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    data['fileName'] = this.fileName;
    data['isVerify'] = this.isVerify;
    data['dateCreated'] = this.dateCreated;
    data['dateUpdated'] = this.dateUpdated;
    data['dateVerified'] = this.dateVerified;
    data['description'] = this.description;
    data['state'] = this.state;
    data['stateId'] = this.stateId;
    data['status'] = this.status;
    return data;
  }
}
