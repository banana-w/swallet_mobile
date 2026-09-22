import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/data/datasource/api_exceptions.dart';
import 'package:swallet_mobile/data/firebase/notification_service.dart';
import 'package:swallet_mobile/domain/entities/account_role.dart';
import 'package:swallet_mobile/data/models/student_features/create_model/create_authen_model.dart';
import 'package:swallet_mobile/data/interface_repositories/authentication_repository.dart';

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
    // Nút đăng nhập chỉ đổi sang vòng xoay chứ không bị khoá, nên người dùng
    // bấm liên tục là bắn nhiều request đăng nhập song song, mỗi request lại
    // kéo theo một lần điều hướng và một lần đăng ký topic thông báo.
    if (state is AuthenticationInProcess) return;
    emit(AuthenticationInProcess());
    try {
      var authenModel = await authenticationRepository.loginWithAccount(
        event.userName,
        event.password,
      );
      if (authenModel != null) {
        if (authenModel.isVerified) {
          // Nếu đã xác thực (isVerified = true)
          switch (authenModel.accountRole) {
            case AccountRole.student:
              emit(AuthenticationSuccess());
              await _registerNotificationTopics(authenModel.accountId);
            case AccountRole.lecturer:
              emit(AuthenticationLectureSuccess());
            case AccountRole.store:
              emit(AuthenticationStoreSuccess());
            case AccountRole.admin:
            case AccountRole.brand:
            case AccountRole.unknown:
              // Cac vai tro nay truoc day roi vao nhanh else va duoc cap quyen
              // Cua hang. Nay tu choi dang nhap kem thong diep ro rang.
              emit(
                AuthenticationFailed(
                  error: UnsupportedRoleException(authenModel.role).message,
                ),
              );
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
    } on AppException catch (e) {
      emit(AuthenticationFailed(error: e.message));
    } catch (e) {
      emit(AuthenticationFailed(error: e.toString()));
    }
  }

  /// Đăng ký topic thông báo là việc phụ. Trước đây nó nằm thẳng trong khối
  /// `try` của đăng nhập nên chỉ cần Firebase lỗi là trạng thái đã
  /// `AuthenticationSuccess` bị lật thành `AuthenticationFailed`.
  Future<void> _registerNotificationTopics(String accountId) async {
    try {
      await NotificationService.instance.loginStudent(accountId);
    } catch (_) {
      // Mất thông báo đẩy không phải lý do để chặn đăng nhập.
    }
  }

  Future<void> _onRegisterAccount(
    RegisterAccount event,
    Emitter<AuthenticationState> emit,
  ) async {
    // Tạo tài khoản là thao tác không hoàn tác được: chặn bấm nhiều lần.
    if (state is AuthenticationInProcess) return;
    emit(AuthenticationInProcess());
    try {
      var registerCheck = await authenticationRepository.registerAccount(
        event.createAuthenModel,
      );
      if (registerCheck) {
        emit(RegistrationSuccess());
      } else {
        emit(AuthenticationFailed(error: 'Đăng ký thất bại!'));
      }
    } on AppException catch (e) {
      emit(AuthenticationFailed(error: e.message));
    } catch (e) {
      emit(AuthenticationFailed(error: e.toString()));
    }
  }
}
