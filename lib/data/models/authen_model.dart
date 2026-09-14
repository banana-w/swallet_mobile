
import 'package:equatable/equatable.dart';
import 'package:swallet_mobile/domain/entities/account_role.dart';

class AuthenModel extends Equatable {
  final String jwt;
  // final UserModel userModel;
  final bool isVerified;
  final String accountId;
  final String role;
  final String email;

  const AuthenModel({
    required this.jwt,
    required this.accountId,
    required this.isVerified,
    required this.role,
    required this.email,
  });

  factory AuthenModel.fromJson(Map<String, dynamic> json) {
    final jwt = json['token'];
    final accountId = json['accountId'];
    final isVerified = json['isVerify'];
    final role = json['role'];
    final email = json['email'];

    if (jwt == null) throw FormatException('jwt không được null');
    if (accountId == null) throw FormatException('accountId không được null');
    if (isVerified == null) throw FormatException('isVerified không được null');
    if (role == null) throw FormatException('role không được null');

    return AuthenModel(
      jwt: jwt as String,
      accountId: accountId as String,
      isVerified: isVerified as bool,
      role: role as String,
      email: email as String,
    );
  }

  /// Vai trò đã được parse sang enum. Mọi so sánh phân quyền phải dùng getter
  /// này, không so sánh trực tiếp chuỗi [role].
  AccountRole get accountRole => AccountRole.fromApi(role);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = jwt;
    data['accountId'] = accountId;
    data['isVerify'] = isVerified;
    data['role'] = role;
    data['email'] = email;
    return data;
  }

  @override
  List<Object?> get props => [jwt, accountId, isVerified, role];
}
