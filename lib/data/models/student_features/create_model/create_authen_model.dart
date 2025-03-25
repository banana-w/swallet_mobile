class CreateAuthenModel {
  String? userName;
  String? password;
  String? campusId;
  String? fullName;
  int? gender;
  String? code;
  String? inviteCode;
  String? studentFrontCard;
  String? email;
  String? dateofBirth;
  String? phoneNumber;
  String? address;
  String? description;
  bool? state;

  CreateAuthenModel({
    this.userName,
    this.password,
    this.campusId,
    this.fullName,
    this.gender,
    this.code,
    this.inviteCode,
    this.studentFrontCard,
    this.email,
    this.dateofBirth,
    this.phoneNumber,
    this.address,
    this.description,
    this.state,
  });

  factory CreateAuthenModel.fromJson(Map<String, dynamic> json) {
    return CreateAuthenModel(
      userName: json['userName'],
      password: json['password'],
      campusId: json['campusId'],
      fullName: json['fullName'],
      studentFrontCard: json['studentFrontCard'],
      gender: json['gender'],
      code: json['code'],
      inviteCode: json['inviteCode'],
      email: json['email'],
      dateofBirth: json['dateofBirth'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['password'] = password;
    data['campusId'] = campusId;
    data['phoneNumber'] = phoneNumber;
    data['code'] = code;
    data['dateofBirth'] = dateofBirth;
    data['inviteCode'] = inviteCode;
    data['studentFrontCard'] = studentFrontCard;
    data['fullName'] = fullName;
    data['gender'] = gender;
    data['email'] = email;
    data['description'] = description;
    data['address'] = address;
    data['state'] = state;
    return data;
  }
}
