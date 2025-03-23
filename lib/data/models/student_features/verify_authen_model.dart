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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['campusId'] = this.campusId;
    data['phoneNumber'] = this.phoneNumber;
    data['code'] = this.code;
    data['dateofBirth'] = this.dateofBirth;
    data['inviteCode'] = this.inviteCode;
    data['studentFrontCard'] = this.studentFrontCard;
    data['studentBackCard'] = this.studentBackCard;
    data['fullName'] = this.fullName;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['address'] = this.address;
    data['accountId'] = this.accountId;
    return data;
  }
}
