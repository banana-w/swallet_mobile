class VerifyAuthenModel {
  String? campusId;
  String? accountId;
  String? fullName;
  int? gender;
  String? code;
  String? inviteCode;
  String? studentFrontCard;
  String? studentBackCard;
  String? email;
  String? dateofBirth;
  String? phoneNumber;
  String? address;

  VerifyAuthenModel({
    this.campusId,
    this.fullName,
    this.accountId,
    this.gender,
    this.code,
    this.inviteCode,
    this.studentFrontCard,
    this.studentBackCard,
    this.email,
    this.dateofBirth,
    this.phoneNumber,
    this.address,
  });

  factory VerifyAuthenModel.fromJson(Map<String, dynamic> json) {
    return VerifyAuthenModel(
      campusId: json['campusId'],
      fullName: json['fullName'],
      studentFrontCard: json['studentFrontCard'],
      studentBackCard: json['studentBackCard'],
      gender: json['gender'],
      code: json['code'],
      inviteCode: json['inviteCode'],
      email: json['email'],
      dateofBirth: json['dateofBirth'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      accountId: json['account'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['campusId'] = campusId;
    data['phoneNumber'] = phoneNumber;
    data['code'] = code;
    data['dateofBirth'] = dateofBirth;
    data['inviteCode'] = inviteCode;
    data['studentFrontCard'] = studentFrontCard;
    data['studentBackCard'] = studentBackCard;
    data['fullName'] = fullName;
    data['gender'] = gender;
    data['email'] = email;
    data['address'] = address;
    data['accountId'] = accountId;
    return data;
  }
}
