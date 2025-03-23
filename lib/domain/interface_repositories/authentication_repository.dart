import 'package:swallet_mobile/data/models.dart';
import 'package:swallet_mobile/data/models/authen_model.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  Future<AuthenModel?> loginWithAccount(String userName, String password);

  Future<bool> registerAccount(CreateAuthenModel createAuthenModel);

  // Future<bool> verifyAccount(VerifyAuthenModel verifyAuthenModel);
}
