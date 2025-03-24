import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/datasource/authen_local_datasource.dart';

part 'verification_state.dart';

// class VerificationCubit extends Cubit<VerificationState> {
//   final VerificationRepository verificationRepository;
//   VerificationCubit(this.verificationRepository) : super(VerificationInitial());

//   void loadingVerification() {
//     emit(VerificationInitial());
//   }

//   Future<bool?> verifyOTP(String smsOTP) async {
//     emit(VerificationLoading());
//     try {
//       final verificationId = await AuthenLocalDataSource.getVerificationId();
//       if (verificationId == null) {
//         emit(OTPVerificationFailed(error: 'Mã không hợp lệ'));
//       } else {
//         final check =
//             await verificationRepository.verifyOTP(verificationId, smsOTP);
//         if (check) {
//           emit(OTPVerificationSuccess());
//           return check;
//         } else {
//           emit(OTPVerificationFailed(error: 'Mã không hợp lệ'));
//           return false;
//         }
//       }
//     } catch (e) {
//       emit(OTPVerificationFailed(error: 'Mã không hợp lệ'));
//     }
//     return false;
//   }
// }
