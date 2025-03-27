
import 'package:swallet_mobile/domain/entities/student_features/user.dart';

class UserModel extends User {
  const UserModel({
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['name'] = name;
    data['roleId'] = roleId;
    data['role'] = role;
    data['roleName'] = roleName;
    data['userName'] = userName;
    data['phone'] = phone;
    data['email'] = email;
    data['avatar'] = avatar;
    data['fileName'] = fileName;
    data['isVerify'] = isVerify;
    data['dateCreated'] = dateCreated;
    data['dateUpdated'] = dateUpdated;
    data['dateVerified'] = dateVerified;
    data['description'] = description;
    data['state'] = state;
    data['stateId'] = stateId;
    data['status'] = status;
    return data;
  }
}
