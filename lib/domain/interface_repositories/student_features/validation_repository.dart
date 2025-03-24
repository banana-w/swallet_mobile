abstract class ValidationRepository {
  const ValidationRepository();

  Future<String> validateEmail({required String email});

  Future<String> validateUserName({required String userName});

  Future<String> validateStudentCode({required String studentCode});

  Future<String> validatePhoneNumber({required String phoneNumber});

  Future<String> validateInviteCode({required String inviteCode});
}
