import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:swallet_mobile/data/models/authen_model.dart';
import 'package:swallet_mobile/data/models/store_features/store_model.dart';
import 'package:swallet_mobile/data/models/student_features/notification_model.dart';
import 'package:swallet_mobile/data/models/student_features/student_model.dart';

import '../models.dart';

class AuthenLocalDataSource {
  AuthenLocalDataSource();

  static Future<void> saveToken(String token) async {
    final sf = await SharedPreferences.getInstance();
    await sf.setString('token', token);
  }

  static Future<String?> getToken() async {
    final sf = await SharedPreferences.getInstance();
    String? token = sf.getString('token');
    return token;
  }

  static Future<void> saveStudentId(String studentId) async {
    final sf = await SharedPreferences.getInstance();
    await sf.setString('studentId', studentId);
  }

  static Future<void> saveAccountId(String accountId) async {
    final sf = await SharedPreferences.getInstance();
    await sf.setString('accountId', accountId);
  }

  static Future<void> saveIsVerified(bool isVerify) async {
    final sf = await SharedPreferences.getInstance();
    await sf.setString('isVerify', isVerify.toString());
  }

  static Future<String?> getIsVerified() async {
    final sf = await SharedPreferences.getInstance();
    String? verify = sf.getString('isVerify');
    return verify;
  }
  static Future<String?> getStudentId() async {
    final sf = await SharedPreferences.getInstance();
    String? token = sf.getString('studentId');
    return token;
  }

  static Future<void> saveUnsubcribeWishListId(String wishListId) async {
    final sf = await SharedPreferences.getInstance();
    await sf.setString('wishListId', wishListId);
  }

  static Future<String?> getUnsubcribeWishListId() async {
    final sf = await SharedPreferences.getInstance();
    String? token = sf.getString('wishListId');
    return token;
  }

  static Future<void> removeUnsubcribeWishListId() async {
    final sf = await SharedPreferences.getInstance();
    sf.remove('wishListId');
  }

  static Future<void> saveStoreId(String storeId) async {
    final sf = await SharedPreferences.getInstance();
    await sf.setString('storeId', storeId);
  }

  static Future<String?> getStoreId() async {
    final sf = await SharedPreferences.getInstance();
    String? storeId = sf.getString('storeId');
    return storeId;
  }

  static Future<void> saveVerificationId(String verificationId) async {
    final sf = await SharedPreferences.getInstance();
    await sf.setString('verificationId', verificationId);
  }

  static Future<String?> getVerificationId() async {
    final sf = await SharedPreferences.getInstance();
    String? verificationId = sf.getString('verificationId');
    return verificationId;
  }

  static Future<void> saveAuthen(String authenString) async {
    final sf = await SharedPreferences.getInstance();
    await sf.setString('authenString', authenString);
  }

  static Future<AuthenModel?> getAuthen() async {
    final sf = await SharedPreferences.getInstance();
    String? authenString = sf.getString('authenString');
    if (authenString == null) {
      return null;
    } else {
      Map<String, dynamic> json = jsonDecode(authenString);
      AuthenModel? authenModel = AuthenModel.fromJson(json);
      return authenModel;
    }
  }

  static Future<void> saveStudent(String studentString) async {
    final sf = await SharedPreferences.getInstance();
    await sf.setString('studentString', studentString);
  }

  static Future<StudentModel?> getStudent() async {
    final sf = await SharedPreferences.getInstance();
    String? studentString = sf.getString('studentString');
    if (studentString == null) {
      return null;
    } else {
      Map<String, dynamic> json = jsonDecode(studentString);
      StudentModel? studentModel = StudentModel.fromJson(json);
      return studentModel;
    }
  }

  static Future<void> saveStore(String storeString) async {
    final sf = await SharedPreferences.getInstance();
    await sf.setString('storeString', storeString);
  }

  static Future<StoreModel?> getStore() async {
    final sf = await SharedPreferences.getInstance();
    String? storeString = sf.getString('storeString');
    if (storeString == null) {
      return null;
    } else {
      Map<String, dynamic> json = jsonDecode(storeString);
      StoreModel? storeModel = StoreModel.fromJson(json);
      return storeModel;
    }
  }

  static Future<void> saveNotification(String notificationString) async {
    final sf = await SharedPreferences.getInstance();
    await sf.setString('notiString', notificationString);
  }

  static Future<List<NotificationModel>?> getNotifications() async {
    final sf = await SharedPreferences.getInstance();
    String? notiString = sf.getString('notiString');
    if (notiString == null) {
      return null;
    } else {
      final List<dynamic> jsonList = jsonDecode(notiString);
      List<NotificationModel> listNotification =
          jsonList
              .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
              .toList();
      return listNotification;
    }
  }

  static Future<void> saveUser(String userString) async {
    final sf = await SharedPreferences.getInstance();
    await sf.setString('userString', userString);
  }

  static Future<UserModel?> getUser() async {
    final sf = await SharedPreferences.getInstance();
    String? userString = sf.getString('userString');
    if (userString == null) {
      return null;
    } else {
      Map<String, dynamic> json = jsonDecode(userString);
      UserModel? userModel = UserModel.fromJson(json);
      return userModel;
    }
  }

  static Future<void> saveCreateAuthen(String authenString) async {
    final sf = await SharedPreferences.getInstance();
    await sf.setString('createAuthenString', authenString);
  }

  static Future<CreateAuthenModel?> getCreateAuthen() async {
    final sf = await SharedPreferences.getInstance();
    String? authenString = sf.getString('createAuthenString');
    if (authenString == null) {
      return null;
    } else {
      Map<String, dynamic> json = jsonDecode(authenString);
      CreateAuthenModel? createAuthenModel = CreateAuthenModel.fromJson(json);
      return createAuthenModel;
    }
  }

  static Future<void> saveVerifyAuthen(String verifyAuthenString) async {
    final sf = await SharedPreferences.getInstance();
    await sf.setString('verifyAuthenString', verifyAuthenString);
  }

  static Future<VerifyAuthenModel?> getVerifyAuthen() async {
    final sf = await SharedPreferences.getInstance();
    String? verifyAuthenString = sf.getString('verifyAuthenString');
    if (verifyAuthenString == null) {
      return null;
    } else {
      Map<String, dynamic> json = jsonDecode(verifyAuthenString);
      VerifyAuthenModel? verifyAuthenModel = VerifyAuthenModel.fromJson(json);
      return verifyAuthenModel;
    }
  }

  static Future<void> removeAuthen() async {
    final sf = await SharedPreferences.getInstance();
    sf.remove('authenString');
  }

  static Future<void> clearAuthen() async {
    final sf = await SharedPreferences.getInstance();

    await sf.clear();
  }

  static Future<void> clearNotifications() async {
    final sf = await SharedPreferences.getInstance();
    sf.remove('notiString');
  }
}
