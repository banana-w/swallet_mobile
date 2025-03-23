// ignore_for_file: must_be_immutable

import 'package:swallet_mobile/domain/entities.dart';
import 'package:swallet_mobile/domain/entities/student_features/student.dart';

class StudentModel extends Student {
  StudentModel({
    required super.id,
    required super.universityId,
    required super.universityName,
    required super.universityImage,
    required super.userName,
    required super.campusId,
    required super.campusName,
    required super.campusImage,
    required super.accountId,
    required super.studentCardFront,
    required super.fileNameFront,
    required super.fullName,
    required super.code,
    required super.gender,
    required super.inviteCode,
    required super.email,
    required super.dateOfBirth,
    required super.phone,
    required super.avatar,
    required super.imageName,
    required super.address,
    required super.totalIncome,
    required super.totalSpending,
    required super.dateCreated,
    required super.dateUpdated,
    required super.dateVerified,
    required super.isVerify,
    required super.stateId,
    required super.state,
    required super.stateName,
    required super.status,
    required super.greenWalletId,
    required super.greenWallet,
    required super.greenWalletName,
    required super.greenWalletBalance,
    required super.redWalletId,
    required super.redWallet,
    required super.redWalletName,
    required super.redWalletBalance,
    required super.following,
    required super.inviter,
    required super.invitee,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'],
      universityId: json['universityId'] ?? '',
      universityName: json['universityName'] ?? '',
      universityImage: json['universityImage'] ?? '',
      campusId: json['campusId'] ?? '',
      campusName: json['campusName'] ?? '',
      campusImage: json['campusImage'] ?? '',
      accountId: json['accountId'] ?? '',
      userName: json['userName'] ?? '',
      studentCardFront: json['studentCardFront'] ?? '',
      fileNameFront: json['fileNameFront'] ?? '',
      fullName: json['fullName'] ?? '',
      code: json['code'] ?? '',
      gender: json['gender'] ?? '',
      inviteCode: json['inviteCode'] ?? '',
      email: json['email'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      phone: json['phone'] ?? '',
      avatar: json['avatar'] ?? '',
      imageName: json['imageName'] ?? '',
      address: json['address'] ?? '',
      totalIncome: json['totalIncome'] ?? 0,
      totalSpending: json['totalSpending'] ?? 0,
      dateCreated: json['dateCreated'] ?? '',
      dateUpdated: json['dateUpdated'] ?? '',
      dateVerified: json['dateVerified'] ?? '',
      isVerify: json['isVerify'] ?? true,
      stateId: json['stateId'] ?? 0,
      state: json['state'] ?? '',
      stateName: json['stateName'] ?? '',
      status: json['status'] ?? true,
      greenWalletId: json['greenWalletId'] ?? 0,
      greenWallet: json['greenWallet'] ?? '',
      greenWalletName: json['greenWalletName'] ?? '',
      greenWalletBalance: json['greenWalletBalance'] ?? 0,
      redWalletId: json['redWalletId'] ?? 0,
      redWallet: json['redWallet'] ?? '',
      redWalletName: json['redWalletName'] ?? '',
      redWalletBalance: json['redWalletBalance'] ?? 0,
      following: json['following'] ?? '',
      inviter: json['inviter'] ?? '',
      invitee: json['invitee'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['universityId'] = this.universityId;
    data['universityName'] = this.universityName;
    data['universityImage'] = this.universityImage;
    data['campusId'] = this.campusId;
    data['campusName'] = this.campusName;
    data['campusImage'] = this.campusImage;
    data['accountId'] = this.accountId;
    data['userName'] = this.userName;
    data['studentCardFront'] = this.studentCardFront;
    data['fileNameFront'] = this.fileNameFront;
    data['fullName'] = this.fullName;
    data['code'] = this.code;
    data['gender'] = this.gender;
    data['inviteCode'] = this.inviteCode;
    data['email'] = this.email;
    data['dateOfBirth'] = this.dateOfBirth;
    data['phone'] = this.phone;
    data['avatar'] = this.avatar;
    data['imageName'] = this.imageName;
    data['address'] = this.address;
    data['totalIncome'] = this.totalIncome;
    data['totalSpending'] = this.totalSpending;
    data['dateCreated'] = this.dateCreated;
    data['dateUpdated'] = this.dateUpdated;
    data['dateVerified'] = this.dateVerified;
    data['isVerify'] = this.isVerify;
    data['stateId'] = this.stateId;
    data['state'] = this.state;
    data['stateName'] = this.stateName;
    data['status'] = this.status;
    data['greenWalletId'] = this.greenWalletId;
    data['greenWallet'] = this.greenWallet;
    data['greenWalletName'] = this.greenWalletName;
    data['greenWalletBalance'] = this.greenWalletBalance;
    data['redWalletId'] = this.redWalletId;
    data['redWallet'] = this.redWallet;
    data['redWalletName'] = this.redWalletName;
    data['redWalletBalance'] = this.redWalletBalance;
    data['following'] = this.following;
    data['inviter'] = this.inviter;
    data['invitee'] = this.invitee;
    return data;
  }
}
