import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/validation_repository.dart';

part 'validation_state.dart';

/// Kiểm tra trùng lặp các trường khi đăng ký / xác minh.
///
/// Mọi hàm trả về chuỗi rỗng khi hợp lệ, và trả về thông báo lỗi khi không.
/// Trước đây năm hàm ở đây đều kết thúc bằng `catch (e) {}` rồi `return null`:
/// mất mạng hay lỗi server là cubit im lặng, form gọi nó thấy giá trị khác ''
/// nên dừng lại mà không báo gì — nút bấm trông như hỏng.
class ValidationCubit extends Cubit<ValidationState> {
  final ValidationRepository validationRepository;
  ValidationCubit(this.validationRepository) : super(ValidationInitial());

  static const _networkError = 'Không kiểm tra được, vui lòng thử lại';

  void loadingValidation() {
    emit(ValidationInitial());
  }

  Future<String?> validateEmail(String email) async {
    emit(ValidationInProcess());
    try {
      final check = await validationRepository.validateEmail(email: email);
      // CẢNH BÁO: `if (true)` — kết quả từ server đang bị bỏ qua, mọi email
      // đều được coi là hợp lệ. Giữ nguyên hành vi hiện tại, chưa tự ý bật lại.
      if (true) {
        emit(CheckEmailSuccess());
        return '';
      } else {
        emit(CheckEmailFailed(error: check, check: false));
        return check;
      }
    } catch (_) {
      emit(const CheckEmailFailed(error: _networkError, check: false));
      return _networkError;
    }
  }

  Future<String?> validateStudentEmail(String email) async {
    emit(ValidationInProcess());
    try {
      final check = await validationRepository.validateStudentEmail(
        email: email,
      );
      // CẢNH BÁO: `if (true)` — xem chú thích ở validateEmail.
      if (true) {
        emit(CheckEmailSuccess());
        return '';
      } else {
        emit(CheckEmailFailed(error: check, check: false));
        return check;
      }
    } catch (_) {
      emit(const CheckEmailFailed(error: _networkError, check: false));
      return _networkError;
    }
  }

  Future<String?> validateUserName(String userName) async {
    emit(ValidationInProcess());
    try {
      final check = await validationRepository.validateUserName(
        userName: userName,
      );
      if (check == '') {
        emit(CheckUserNameSuccess());
        return check;
      } else {
        emit(CheckUserNameFailed(error: check, check: false));
        return check;
      }
    } catch (_) {
      emit(const CheckUserNameFailed(error: _networkError, check: false));
      return _networkError;
    }
  }

  Future<String?> validateStudentCode(String studentCode) async {
    emit(ValidationInProcess());
    try {
      // Trước đây gọi nhầm validateUserName (endpoint /validUsername): mã số
      // sinh viên bị đem đi kiểm tra xem có trùng tên đăng nhập nào không.
      final check = await validationRepository.validateStudentCode(
        studentCode: studentCode,
      );
      if (check == '') {
        emit(CheckStudentCodeSuccess());
        return '';
      } else {
        emit(CheckStudentCodeFailed(error: check, check: false));
        return check;
      }
    } catch (_) {
      emit(const CheckStudentCodeFailed(error: _networkError, check: false));
      return _networkError;
    }
  }

  Future<String?> validatePhoneNumber(String phone) async {
    emit(ValidationInProcess());
    try {
      // Trước đây cũng gọi nhầm validateUserName thay vì endpoint /phone.
      final check = await validationRepository.validatePhoneNumber(
        phoneNumber: phone,
      );
      if (check == '') {
        emit(CheckPhoneSuccess());
        return '';
      } else {
        emit(CheckPhoneFailed(error: check, check: false));
        return check;
      }
    } catch (_) {
      emit(const CheckPhoneFailed(error: _networkError, check: false));
      return _networkError;
    }
  }

  Future<String?> validateInviteCode(String inviteCode) async {
    emit(ValidationInProcess());
    try {
      if (inviteCode.isEmpty) {
        emit(CheckInvitedCodeSuccess());
        return '';
      }
      final check = await validationRepository.validateInviteCode(
        inviteCode: inviteCode,
      );
      if (check == '') {
        emit(CheckInvitedCodeSuccess());
        return '';
      } else {
        emit(CheckInvitedCodeFailed(error: check, check: false));
        return check;
      }
    } catch (_) {
      emit(const CheckInvitedCodeFailed(error: _networkError, check: false));
      return _networkError;
    }
  }
}
