import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/data/models/student_features/create_model/create_authen_model.dart';
import 'package:swallet_mobile/data/models/student_features/verify_authen_model.dart';
import 'package:swallet_mobile/domain/interface_repositories/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;
  AuthenticationBloc({required this.authenticationRepository})
    : super(AuthenticationInitial()) {
    on<StartAuthen>(_onStartAuthen);
    on<LoginAccount>(_onLoginAccount);
    on<RegisterAccount>(_onRegisterAccount);
    // on<VerifyAccount>(_onVerifyAccount);
  }
  Future<void> _onStartAuthen(
    StartAuthen event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationInitial());
  }

  //Admin = 1
  //Lecturer = 2
  //Brand = 3
  //Store = 4
  //Student = 5

  Future<void> _onLoginAccount(
    LoginAccount event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationInProcess());
    try {
      var authenModel = await authenticationRepository.loginWithAccount(
        event.userName,
        event.password,
      );
      if (authenModel != null) {
        if (authenModel.isVerified) {
          // Nếu đã xác thực (isVerified = true)
          if (authenModel.role == 'Sinh viên') {
            emit(AuthenticationSuccess());
          } else if (authenModel.role.contains('Giáo viên')) {
            emit(AuthenticationLectureSuccess());
          } else {
            emit(AuthenticationStoreSuccess());
          }
        } else {
          // Nếu chưa xác thực (isVerified = false)
          emit(AuthenticationSuccessButNotVerified());
        }
      } else {
        emit(
          AuthenticationFailed(error: 'Tài khoản hoặc mật khẩu không đúng!'),
        );
      }
    } catch (e) {
      emit(AuthenticationFailed(error: e.toString()));
    }
  }

  Future<void> _onRegisterAccount(
    RegisterAccount event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationInProcess());
    try {
      var registerCheck = await authenticationRepository.registerAccount(
        event.createAuthenModel,
      );
      if (registerCheck) {
        emit(AuthenticationSuccess());
      } else {
        emit(AuthenticationFailed(error: 'Đăng ký thất bại!'));
      }
    } catch (e) {
      emit(AuthenticationFailed(error: e.toString()));
    }
  }

  // Future<void> _onVerifyAccount(
  //   VerifyAccount event,
  //   Emitter<AuthenticationState> emit,
  // ) async {
  //   emit(AuthenticationInProcess());
  //   try {
  //     var verifyCheck = await authenticationRepository.verifyAccount(
  //       event.verifyAuthenModel,
  //     );
  //     if (verifyCheck) {
  //       emit(AuthenticationSuccess());
  //     } else {
  //       emit(AuthenticationFailed(error: 'Đăng ký thất bại!'));
  //     }
  //   } catch (e) {
  //     emit(AuthenticationFailed(error: e.toString()));
  //   }
  // }
}
