import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/domain/interface_repositories/student_features/validation_repository.dart';


part 'validation_state.dart';

class ValidationCubit extends Cubit<ValidationState> {
  final ValidationRepository validationRepository;
  ValidationCubit(this.validationRepository) : super(ValidationInitial());

  void loadingValidation() {
    emit(ValidationInitial());
  }

  Future<String?> validateEmail(String email) async {
    emit(ValidationInProcess());
    try {
      final check = await validationRepository.validateEmail(email: email);
      // print(check);
      if (true) {
        emit(CheckEmailSuccess());
        return '';
      } else {
        emit(CheckEmailFailed(error: check, check: false));
        return check;
      }
    } catch (e) {}
    return null;
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
    } catch (e) {}
    return null;
  }

  Future<String?> validateStudentCode(String studentCode) async {
    emit(ValidationInProcess());
    try {
      var check = await validationRepository.validateStudentCode(
        studentCode: studentCode,
      );
      // print(check);
      if (check == '') {
        emit(CheckStudentCodeSuccess());
        return '';
      } else {
        emit(CheckStudentCodeFailed(error: check, check: false));
        return check;
      }
    } catch (e) {}
    return null;
  }

  Future<String?> validatePhoneNumber(String phone) async {
    emit(ValidationInProcess());
    try {
      var check = await validationRepository.validatePhoneNumber(
        phoneNumber: phone,
      );
      // print(check);
      if (check == '') {
        emit(CheckPhoneSuccess());
        return '';
      } else {
        emit(CheckPhoneFailed(error: check, check: false));
        return check;
      }
    } catch (e) {}
    return null;
  }

  Future<String?> validateInviteCode(String inviteCode) async {
    emit(ValidationInProcess());
    try {
      var check = await validationRepository.validateInviteCode(
        inviteCode: inviteCode,
      );
      // print(check);
      if (check == '') {
        emit(CheckInvitedCodeSuccess());
        return '';
      } else {
        emit(CheckInvitedCodeFailed(error: check, check: false));
        return check;
      }
    } catch (e) {}
    return null;
  }
}
