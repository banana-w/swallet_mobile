import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/authen_model.dart';
import 'package:swallet_mobile/data/models/store_features/store_model.dart';
import 'package:swallet_mobile/data/models/student_features/student_model.dart';
import 'package:swallet_mobile/domain/interface_repositories/store_features/store_repository.dart';
import 'package:swallet_mobile/domain/interface_repositories/student_features/student_repository.dart';

part 'role_app_event.dart';
part 'role_app_state.dart';

class RoleAppBloc extends Bloc<RoleAppEvent, RoleAppState> {
  final StudentRepository studentRepository;
  final StoreRepository storeRepository;
  RoleAppBloc(this.studentRepository, this.storeRepository)
    : super(RoleAppLoading()) {
    on<RoleAppStart>(_onStartRoleApp);
    on<RoleAppEnd>(_onEndRoleApp);
  }

  Future<void> _onStartRoleApp(
    RoleAppStart event,
    Emitter<RoleAppState> emit,
  ) async {
    emit(RoleAppLoading());
    try {
      final authenModel = await AuthenLocalDataSource.getAuthen();
      final isVerifyAfter = await AuthenLocalDataSource.getIsVerified();

      bool isVerify = authenModel!.isVerified;
      String role = authenModel.role;
      String userId = authenModel.accountId;
      if (isVerify || isVerifyAfter == "true") {
        if (userId != '') {
          final student = await studentRepository.fetchStudentById(
            id: authenModel.accountId,
          );
          if (role == 'Sinh viên') {
            if (student?.state == 2) {
              emit(Verified(authenModel: authenModel, studentModel: student!));
            } else {
              emit(Unverified(authenModel: authenModel, studentModel: student!));
            }
          } else {
            final store = await storeRepository.fetchStoreById(
              storeId: authenModel.accountId,
            );
            emit(StoreRole(authenModel: authenModel, storeModel: store!));
          }
        } else {
          emit(RoleAppLoading());
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onEndRoleApp(
    RoleAppEnd event,
    Emitter<RoleAppState> emit,
  ) async {
    try {
      final studentId = await AuthenLocalDataSource.getStudentId();
      if (studentId == null) {
        AuthenLocalDataSource.removeAuthen();
        AuthenLocalDataSource.clearAuthen();
      } else {
        AuthenLocalDataSource.removeAuthen();
        AuthenLocalDataSource.clearAuthen();
      }

      // emit(Unknown());
    } catch (e) {
      print(e);
    }
  }
}
