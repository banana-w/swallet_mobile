abstract class VerificationRepository {
  const VerificationRepository();

  Future<bool> verifyEmailCode(String accountId, String email, String code);
  Future<bool> verifyStudent(String studenId, String email, String code);
  Future<bool> resendEmail(String email);
}