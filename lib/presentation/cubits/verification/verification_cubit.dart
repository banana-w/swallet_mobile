import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/domain/interface_repositories/student_features/verification_repository.dart';

part 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  final VerificationRepository verificationRepository;
  VerificationCubit(this.verificationRepository) : super(VerificationInitial());

  void loadingVerification() {
    emit(VerificationInitial());
  }

  Future<bool?> verifyEmailCode(String email, String code) async {
    emit(VerificationLoading());
    try {
      final authenModel = await AuthenLocalDataSource.getAuthen();
      // final email = authenModel?.email;
      // if (email == null) {
      //   emit(OTPVerificationFailed(error: 'Mã không hợp lệ'));
      // }
      final check = await verificationRepository.verifyEmailCode(
        authenModel!.accountId,
        email,
        code,
      );
      if (check) {
        emit(OTPVerificationSuccess());
        return check;
      } else {
        emit(OTPVerificationFailed(error: 'Mã không hợp lệ'));
        return false;
      }
    } catch (e) {
      emit(OTPVerificationFailed(error: e.toString()));
    }
    return false;
  }

  Future<bool?> verifyStudent(
    String studentId,
    String email,
    String code,
  ) async {
    emit(VerificationLoading());
    try {
      final check = await verificationRepository.verifyStudent(
        studentId,
        email,
        code,
      );
      if (check) {
        emit(OTPVerificationSuccess());
        return check;
      } else {
        emit(OTPVerificationFailed(error: 'Mã không hợp lệ'));
        return false;
      }
    } catch (e) {
      emit(OTPVerificationFailed(error: e.toString()));
    }
    return false;
  }

  Future<bool?> resendVerificationEmail(String email) async {
    emit(SendMailLoading());
    try {
      final check = await verificationRepository.resendEmail(email);
      if (check) {
        emit(VerificationInitial());
        return check;
      } else {
        emit(OTPVerificationFailed(error: 'Không thể gửi lại email'));
        return false;
      }
    } catch (e) {
      emit(OTPVerificationFailed(error: e.toString()));
    }
    return false;
  }
}
