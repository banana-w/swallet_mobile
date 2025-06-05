import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/check_in_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/student_repository.dart';

part 'check_in_state.dart';
part 'check_in_event.dart';

class CheckInBloc extends Bloc<CheckInEvent, CheckInState> {
  final CheckInRepository checkInRepository;

  CheckInBloc(this.checkInRepository) : super(CheckInLoading()) {
    on<LoadCheckInData>(_onLoadCheckInData);
    on<CheckIn>(_onCheckIn);
  }

  Future<void> _onLoadCheckInData(
    LoadCheckInData event,
    Emitter<CheckInState> emit,
  ) async {
    try {
      emit(CheckInLoading());

      final student = await AuthenLocalDataSource.getStudent();
      final studentId = student?.id;

      if (studentId == null) {
        emit(CheckInError('Không tìm thấy studentId'));
        return;
      }

      final checkInData = await checkInRepository.getCheckInData(studentId);

      emit(
        CheckInLoaded(
          checkInHistory: checkInData.checkInHistory,
          streak: checkInData.streak,
          points: checkInData.points,
          canCheckInToday: checkInData.canCheckInToday,
          currentDayIndex: checkInData.currentDayIndex,
          rewardPoints: checkInData.rewardPoints, // Thêm rewardPoints
        ),
      );
    } catch (e) {
      emit(CheckInError('Lỗi khi tải dữ liệu điểm danh: $e'));
    }
  }

  Future<void> _onCheckIn(CheckIn event, Emitter<CheckInState> emit) async {
    try {
      final student = await AuthenLocalDataSource.getStudent();
      final studentId = student?.id;

      if (studentId == null) {
        emit(CheckInError('Không tìm thấy studentId'));
        return;
      }

      final checkInData = await checkInRepository.checkIn(studentId);

      emit(
        CheckInSuccess(),
      );
      emit(
        CheckInLoaded(
          checkInHistory: checkInData.checkInHistory,
          streak: checkInData.streak,
          points: checkInData.points,
          canCheckInToday: checkInData.canCheckInToday,
          currentDayIndex: checkInData.currentDayIndex,
          rewardPoints: checkInData.rewardPoints, // Thêm rewardPoints
        ),
      );
    } catch (e) {
      emit(CheckInError('Lỗi khi điểm danh: $e'));
    }
  }
}

// class CheckInBloc extends Bloc<CheckInEvent, CheckInState> {
//   final StudentRepository studentRepository;
//   CheckInBloc(this.studentRepository) : super(CheckInLoading()) {
//     on<LoadCheckInData>(_onLoadCheckInData);
//     on<CheckIn>(_onCheckIn);
//   }

//   Future<void> _onLoadCheckInData(
//     LoadCheckInData event,
//     Emitter<CheckInState> emit,
//   ) async {
//     emit(CheckInLoading());

//     // Mở Hive box để lưu trữ dữ liệu điểm danh
//     var box = await Hive.openBox('checkInBox');

//     // Lấy dữ liệu từ Hive
//     List<bool> checkInHistory = List<bool>.from(
//       box.get('checkInHistory') ?? List.filled(7, false),
//     );
//     int streak = box.get('streak') ?? 0;
//     int points = box.get('points') ?? 0;
//     DateTime? lastCheckInDate =
//         box.get('lastCheckInDate') != null
//             ? DateTime.parse(box.get('lastCheckInDate'))
//             : null;

//     // Xác định ngày hiện tại trong chuỗi 7 ngày
//     DateTime now = DateTime.now();
//     int currentDayIndex = 0;
//     bool canCheckInToday = true;

//     if (lastCheckInDate != null) {
//       // Kiểm tra xem có phải ngày mới không
//       bool isSameDay =
//           now.day == lastCheckInDate.day &&
//           now.month == lastCheckInDate.month &&
//           now.year == lastCheckInDate.year;

//       if (isSameDay) {
//         canCheckInToday = false; // Đã điểm danh hôm nay
//       } else {
//         // Kiểm tra xem chuỗi có bị gián đoạn không
//         DateTime yesterday = now.subtract(Duration(days: 1));
//         bool isYesterday =
//             lastCheckInDate.day == yesterday.day &&
//             lastCheckInDate.month == yesterday.month &&
//             lastCheckInDate.year == yesterday.year;

//         if (!isYesterday) {
//           // Chuỗi bị gián đoạn, reset
//           checkInHistory = List.filled(7, false);
//           streak = 0;
//           points = 0;
//         }

//         // Cập nhật currentDayIndex
//         currentDayIndex = (streak % 7);
//       }
//     }

//     emit(
//       CheckInLoaded(
//         checkInHistory: checkInHistory,
//         streak: streak,
//         points: points,
//         canCheckInToday: canCheckInToday,
//         currentDayIndex: currentDayIndex,
//       ),
//     );
//   }

//   // Future<void> _onCheckIn(CheckIn event, Emitter<CheckInState> emit) async {
//   //   var box = await Hive.openBox('checkInBox');
//   //   List<bool> checkInHistory = List<bool>.from(
//   //     box.get('checkInHistory') ?? List.filled(7, false),
//   //   );
//   //   int streak = box.get('streak') ?? 0;
//   //   int points = box.get('points') ?? 0;

//   //   // Cập nhật trạng thái điểm danh
//   //   DateTime now = DateTime.now();
//   //   streak += 1;
//   //   int currentDayIndex = (streak - 1) % 7;
//   //   checkInHistory[currentDayIndex] = true;
//   //   points +=
//   //       streak * 10 + 10; // Tính điểm: ngày 1: 10 điểm, ngày 2: 20 điểm, ...

//   //   // Lưu dữ liệu vào Hive
//   //   await box.put('checkInHistory', checkInHistory);
//   //   await box.put('streak', streak);
//   //   await box.put('points', points);
//   //   await box.put('lastCheckInDate', now.toIso8601String());

//   //   emit(
//   //     CheckInLoaded(
//   //       checkInHistory: checkInHistory,
//   //       streak: streak,
//   //       points: points,
//   //       canCheckInToday: false,
//   //       currentDayIndex: currentDayIndex,
//   //     ),
//   //   );
//   // }

//   Future<void> _onCheckIn(CheckIn event, Emitter<CheckInState> emit) async {
//     var box = await Hive.openBox('checkInBox');
//     List<bool> checkInHistory = List<bool>.from(
//       box.get('checkInHistory') ?? List.filled(7, false),
//     );
//     int streak = box.get('streak') ?? 0;
//     int points = box.get('points') ?? 0;

//     // Cập nhật trạng thái điểm danh
//     DateTime now = DateTime.now();
//     streak += 1;
//     int currentDayIndex = (streak - 1) % 7;
//     checkInHistory[currentDayIndex] = true;
//     int pointsEarned =
//         streak * 10; // Tính điểm: ngày 1: 10 điểm, ngày 2: 20 điểm, ...
//     points += pointsEarned;

//     // Lưu dữ liệu vào Hive
//     await box.put('checkInHistory', checkInHistory);
//     await box.put('streak', streak);
//     await box.put('points', points);
//     await box.put('lastCheckInDate', now.toIso8601String());

//     // Lấy studentId từ AuthenLocalDataSource
//     try {
//       final student = await AuthenLocalDataSource.getStudent();
//       final studentId = student?.id;
//       if (student == null || studentId == null) {
//         throw Exception('Không thể lấy thông tin sinh viên');
//       }

//       // Gọi API để cập nhật điểm vào ví
//       await studentRepository.updateWalletByStudentId(studentId, pointsEarned);
//     } catch (e) {
//       // Nếu API thất bại, hiển thị thông báo lỗi
//       emit(CheckInError('Không thể cập nhật điểm vào ví: $e'));
//       return;
//     }

//     // Phát ra trạng thái mới sau khi cập nhật thành công
//     emit(
//       CheckInLoaded(
//         checkInHistory: checkInHistory,
//         streak: streak,
//         points: points,
//         canCheckInToday: false,
//         currentDayIndex: currentDayIndex,
//       ),
//     );
//   }
// }
