import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/lecture_features/qr_response';
import 'package:swallet_mobile/data/models/student_features/student_model.dart';
import 'package:swallet_mobile/data/models/student_features/transaction_model.dart';
import 'package:swallet_mobile/data/models/student_features/voucher_student_item_model.dart';
import 'package:swallet_mobile/data/models/student_features/voucher_student_model.dart';
import 'package:swallet_mobile/domain/interface_repositories/student_features/student_repository.dart';
part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentRepository studentRepository;

  StudentBloc({required this.studentRepository}) : super(StudentInitial()) {
    on<LoadStudentVouchers>(_onLoadStudentVouchers);
    on<ScanLectureQR>(_onScanLectureQR);
    // on<LoadMoreStudentVouchers>(_onLoadMoreVouchers);
    on<LoadStudentTransactions>(_onLoadStudentTransactions);
    // on<LoadStudentOrders>(_onLoadStudentOrder);
    on<LoadMoreTransactions>(_onLoadMoreTransactions);
    on<LoadMoreActivityTransactions>(_onLoadMoreActivityTransactions);
    // on<LoadMoreBonusTransactions>(_onLoadMoreBonusTransactions);
    // on<LoadMoreChallengeTransactions>(_onLoadMoreChallengeTransactions);
    // on<LoadMoreOrderTransactions>(_onLoadMoreOrderTransactions);
    // on<LoadMoreOrders>(_onLoadMoreOrders);
    // on<LoadVoucherItem>(_onLoadvoucherItem);
    on<UpdateStudent>(_onUpdateStudent);
    on<LoadStudentById>(_onLoadStudentById);
    on<UpdateVerification>(_onUpdateVerification);
    // on<LoadOrderDetailById>(_onLoadOrderDetailBydId);
    // on<HideUsedVouchers>(_onHideUsedVoucher);
    on<SkipUpdateVerification>(_onSKipUpdateVerification);
  }
  var isLoadingMore = false;
  int pageTransaction = 1;
  int pageActivityTransaction = 1;
  int pageBonusTransaction = 1;
  int pageChallengeTransaction = 1;
  int pageOrderTransaction = 1;

  int pageOrder = 1;

  int pageVouchers = 1;
  var isLoadingMoreOrder = false;

  // --------------------

  Future<void> _onScanLectureQR(
    ScanLectureQR event,
    Emitter<StudentState> emit,
  ) async {
    emit(const QRScanLoading());
    try {
      final response = await studentRepository.scanLectureQR(
        qrCode: event.qrCode,
        studentId: event.studentId,
      );
      emit(QRScanSuccess(response));
    } catch (e) {
      emit(QRScanFailed(e.toString()));
    }
  }

  Future<void> _onLoadStudentVouchers(
    LoadStudentVouchers event,
    Emitter<StudentState> emit,
  ) async {
    emit(StudentVoucherLoading());
    try {
      var apiResponse = await studentRepository.fetchVoucherStudentId(
        event.page,
        event.limit,
        event.search,
        event.isUsed,
        id: event.id,
      );
      if (apiResponse!.totalPages == apiResponse.result.length) {
        var vouchers = apiResponse.result.toList();
        emit(
          StudentVouchersLoaded(voucherModels: vouchers, hasReachedMax: true),
        );
      } else {
        var vouchers = apiResponse.result.toList();
        emit(StudentVouchersLoaded(voucherModels: vouchers));
      }
    } catch (e) {
      emit(StudentFaled(error: e.toString()));
    }
  }

  // Future<void> _onHideUsedVoucher(
  //     HideUsedVouchers event, Emitter<StudentState> emit) async {
  //   try {
  //     var vouchers = (this.state as StudentVouchersLoaded).voucherModels;
  //     var notUseVouchers = vouchers.where((v) => v.isUsed == false).toList();

  //     emit(StudentVouchersLoaded(voucherModels: notUseVouchers));
  //   } catch (e) {
  //     emit(StudentFaled(error: e.toString()));
  //   }
  // }

  // Future<void> _onLoadMoreVouchers(
  //     LoadMoreStudentVouchers event, Emitter<StudentState> emit) async {
  //   try {
  //     if (event.scrollController.position.pixels ==
  //         event.scrollController.position.maxScrollExtent) {
  //       if ((this.state as StudentVouchersLoaded).hasReachedMax) {
  //         List<VoucherStudentModel> vouchers =
  //             List.from((this.state as StudentVouchersLoaded).voucherModels);
  //         emit(StudentVouchersLoaded(
  //             voucherModels: vouchers, hasReachedMax: true));
  //       } else {
  //         isLoadingMore = true;
  //         pageVouchers++;
  //         var apiResponse = await studentRepository.fetchVoucherStudentId(
  //             pageVouchers,
  //             event.limit,
  //             event.search,
  //             id: event.id,
  //             event.isUsed);
  //         if (apiResponse!.result.length == 0) {
  //           List<VoucherStudentModel> vouchers =
  //               List.from((this.state as StudentVouchersLoaded).voucherModels)
  //                 ..addAll(apiResponse.result);
  //           emit(StudentVouchersLoaded(
  //               voucherModels: vouchers, hasReachedMax: true));
  //           this.pageVouchers = 1;
  //         } else {
  //           List<VoucherStudentModel> vouchers =
  //               List.from((this.state as StudentVouchersLoaded).voucherModels)
  //                 ..addAll(apiResponse.result);
  //           emit(StudentVouchersLoaded(voucherModels: vouchers));
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     emit(StudentFaled(error: e.toString()));
  //   }
  // }

  Future<void> _onLoadStudentTransactions(
    LoadStudentTransactions event,
    Emitter<StudentState> emit,
  ) async {
    emit(StudentTransactionLoading());
    try {
      var apiResponse = await studentRepository.fetchTransactionsStudentId(
        event.page,
        event.limit,
        event.typeIds,
        '',
        id: event.id,
      );
      if (apiResponse!.total < apiResponse.size) {
        emit(
          StudentTransactionsLoaded(
            transactions: apiResponse.result,
            hasReachedMax: true,
          ),
        );
      } else {
        emit(StudentTransactionsLoaded(transactions: apiResponse.result));
      }
    } catch (e) {
      emit(StudentFaled(error: e.toString()));
    }
  }

  Future<void> _onLoadMoreTransactions(
    LoadMoreTransactions event,
    Emitter<StudentState> emit,
  ) async {
    try {
      final student = await AuthenLocalDataSource.getStudent();
      if (event.scrollController.position.pixels ==
          event.scrollController.position.maxScrollExtent) {
        isLoadingMore = true;
        pageTransaction++;
        var apiResponse = await studentRepository.fetchTransactionsStudentId(
          pageTransaction,
          event.limit,
          event.typeIds,
          '',
          id: student!.id,
        );
        if (apiResponse!.result.isEmpty) {
          emit(
            StudentTransactionsLoaded(
              transactions: List.from(
                (state as StudentTransactionsLoaded).transactions,
              )..addAll(apiResponse.result),
              hasReachedMax: true,
            ),
          );
        } else {
          emit(
            StudentTransactionsLoaded(
              transactions: List.from(
                (state as StudentTransactionsLoaded).transactions,
              )..addAll(apiResponse.result),
            ),
          );
        }
      }
    } catch (e) {
      emit(StudentFaled(error: e.toString()));
    }
  }

  // Future<void> _onLoadMoreOrders(
  //     LoadMoreOrders event, Emitter<StudentState> emit) async {
  //   try {
  //     final studentId = await AuthenLocalDataSource.getStudentId();
  //     if ((this.state as StudentOrdersLoaded).hasReachedMax) {
  //       emit(StudentOrdersLoaded(
  //           orderModels:
  //               List.from((this.state as StudentOrdersLoaded).orderModels),
  //           hasReachedMax: true));
  //     } else {
  //       if (event.scrollController.position.pixels ==
  //           event.scrollController.position.maxScrollExtent) {
  //         isLoadingMoreOrder = true;
  //         pageOrder++;
  //         var apiResponse = await studentRepository
  //             .fetchOrdersStudentId(pageOrder, event.limit, id: studentId!);
  //         if (apiResponse!.result.length == 0) {
  //           emit(StudentOrdersLoaded(
  //               orderModels:
  //                   List.from((this.state as StudentOrdersLoaded).orderModels)
  //                     ..addAll(apiResponse.result),
  //               hasReachedMax: true));
  //           pageOrder = 1;
  //         } else {
  //           emit(StudentOrdersLoaded(
  //               orderModels:
  //                   List.from((this.state as StudentOrdersLoaded).orderModels)
  //                     ..addAll(apiResponse.result)));
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     emit(StudentFaled(error: e.toString()));
  //   }
  // }

  Future<void> _onLoadMoreActivityTransactions(
    LoadMoreActivityTransactions event,
    Emitter<StudentState> emit,
  ) async {
    try {
      final student = await AuthenLocalDataSource.getStudent();
      if (event.scrollController.position.pixels ==
          event.scrollController.position.maxScrollExtent) {
        isLoadingMore = true;
        pageActivityTransaction++;
        var apiResponse = await studentRepository.fetchTransactionsStudentId(
          pageActivityTransaction,
          event.limit,
          event.typeIds,
          '',
          id: student!.id,
        );
        if (apiResponse!.result.isEmpty) {
          emit(
            StudentTransactionsLoaded(
              transactions: List.from(
                (state as StudentTransactionsLoaded).transactions,
              )..addAll(apiResponse.result),
              hasReachedMax: true,
            ),
          );
        } else {
          emit(
            StudentTransactionsLoaded(
              transactions: List.from(
                (state as StudentTransactionsLoaded).transactions,
              )..addAll(apiResponse.result),
            ),
          );
        }
      }
    } catch (e) {
      emit(StudentFaled(error: e.toString()));
    }
  }

  // Future<void> _onLoadMoreBonusTransactions(
  //     LoadMoreBonusTransactions event, Emitter<StudentState> emit) async {
  //   try {
  //     final studentId = await AuthenLocalDataSource.getStudentId();
  //     if (event.scrollController.position.pixels ==
  //         event.scrollController.position.maxScrollExtent) {
  //       isLoadingMore = true;
  //       pageBonusTransaction++;
  //       var apiResponse = await studentRepository.fetchTransactionsStudentId(
  //           pageBonusTransaction, event.limit, event.typeIds,
  //           id: studentId!);
  //       if (apiResponse!.result.length == 0) {
  //         emit(StudentTransactionsLoaded(
  //             transactions: List.from(
  //                 (this.state as StudentTransactionsLoaded).transactions)
  //               ..addAll(apiResponse.result),
  //             hasReachedMax: true));
  //       } else {
  //         emit(StudentTransactionsLoaded(
  //             transactions: List.from(
  //                 (this.state as StudentTransactionsLoaded).transactions)
  //               ..addAll(apiResponse.result)));
  //       }
  //     }
  //   } catch (e) {
  //     emit(StudentFaled(error: e.toString()));
  //   }
  // }

  // Future<void> _onLoadMoreChallengeTransactions(
  //     LoadMoreChallengeTransactions event, Emitter<StudentState> emit) async {
  //   try {
  //     final studentId = await AuthenLocalDataSource.getStudentId();
  //     if (event.scrollController.position.pixels ==
  //         event.scrollController.position.maxScrollExtent) {
  //       isLoadingMore = true;
  //       pageChallengeTransaction++;
  //       var apiResponse = await studentRepository.fetchTransactionsStudentId(
  //           pageChallengeTransaction, event.limit, event.typeIds,
  //           id: studentId!);
  //       if (apiResponse!.result.length == 0) {
  //         emit(StudentTransactionsLoaded(
  //             transactions: List.from(
  //                 (this.state as StudentTransactionsLoaded).transactions)
  //               ..addAll(apiResponse.result),
  //             hasReachedMax: true));
  //       } else {
  //         emit(StudentTransactionsLoaded(
  //             transactions: List.from(
  //                 (this.state as StudentTransactionsLoaded).transactions)
  //               ..addAll(apiResponse.result)));
  //       }
  //     }
  //   } catch (e) {
  //     emit(StudentFaled(error: e.toString()));
  //   }
  // }

  // Future<void> _onLoadMoreOrderTransactions(
  //     LoadMoreOrderTransactions event, Emitter<StudentState> emit) async {
  //   try {
  //     final studentId = await AuthenLocalDataSource.getStudentId();
  //     if (event.scrollController.position.pixels ==
  //         event.scrollController.position.maxScrollExtent) {
  //       isLoadingMore = true;
  //       pageOrderTransaction++;
  //       var apiResponse = await studentRepository.fetchTransactionsStudentId(
  //           pageOrderTransaction, event.limit, event.typeIds,
  //           id: studentId!);
  //       if (apiResponse!.result.length == 0) {
  //         emit(StudentTransactionsLoaded(
  //             transactions: List.from(
  //                 (this.state as StudentTransactionsLoaded).transactions)
  //               ..addAll(apiResponse.result),
  //             hasReachedMax: true));
  //       } else {
  //         emit(StudentTransactionsLoaded(
  //             transactions: List.from(
  //                 (this.state as StudentTransactionsLoaded).transactions)
  //               ..addAll(apiResponse.result)));
  //       }
  //     }
  //   } catch (e) {
  //     emit(StudentFaled(error: e.toString()));
  //   }
  // }

  // Future<void> _onLoadStudentOrder(
  //     LoadStudentOrders event, Emitter<StudentState> emit) async {
  //   emit(StudentOrderLoading());
  //   try {
  //     var apiResponse = await studentRepository
  //         .fetchOrdersStudentId(event.page, event.limit, id: event.id);
  //     if (apiResponse!.pageSize > apiResponse.totalCount) {
  //       emit(StudentOrdersLoaded(
  //           orderModels: apiResponse.result, hasReachedMax: true));
  //     } else {
  //       emit(StudentOrdersLoaded(orderModels: apiResponse.result));
  //     }
  //   } catch (e) {
  //     emit(StudentFaled(error: e.toString()));
  //   }
  // }

  Future<void> _onUpdateStudent(
    UpdateStudent event,
    Emitter<StudentState> emit,
  ) async {
    emit(StudentUpding());
    try {
      var studentModel = await studentRepository.putStudent(
        studentId: event.studentId,
        fullName: event.fullName,
        studentCode: event.studentCode,
        dateOfBirth: event.dateOfBirth,
        campusId: event.campusId,
        gender: event.gender,
        address: event.address,
        avatar: event.avatar,
      );
      if (studentModel == null) {
        emit(StudentFaled(error: 'Sửa thất bại!'));
      } else {
        emit(StudentUpdateSuccess(studentModel: studentModel));
      }
    } catch (e) {
      emit(StudentFaled(error: e.toString()));
    }
  }

  // Future<void> _onLoadvoucherItem(
  //     LoadVoucherItem event, Emitter<StudentState> emit) async {
  //   emit(StudentVoucherItemLoading());
  //   try {
  //     var apiResponse = await studentRepository.fetchVoucherItemByStudentId(
  //         studentId: event.studentId, voucherId: event.voucherId);
  //     emit(StudentVoucherItemLoaded(voucherStudentItemModel: apiResponse!));
  //   } catch (e) {
  //     emit(StudentFaled(error: e.toString()));
  //   }
  // }

  Future<void> _onLoadStudentById(
    LoadStudentById event,
    Emitter<StudentState> emit,
  ) async {
    emit(StudentByIdLoading());
    try {
      var apiResponse = await studentRepository.fetchStudentById(
        id: event.accountId,
      );
      emit(StudentByIdSuccess(studentMode: apiResponse!));
    } catch (e) {
      emit(StudentByIdFailed(error: e.toString()));
    }
  }

  Future<void> _onUpdateVerification(
    UpdateVerification event,
    Emitter<StudentState> emit,
  ) async {
    emit(StudentUpdatingVerification());
    try {
      var studentModel = await studentRepository.putVerification(
        studentId: event.studentId,
        studentCardFont: event.studentCardFront,
      );
      if (studentModel == null) {
        emit(StudentFaled(error: 'Xác minh thất bại!'));
      } else {
        emit(StudentUpdateVerificationSuccess(studentModel: studentModel));
      }
    } catch (e) {
      emit(StudentFaled(error: e.toString()));
    }
  }

  Future<void> _onSKipUpdateVerification(
    SkipUpdateVerification event,
    Emitter<StudentState> emit,
  ) async {
    var studentModel = await AuthenLocalDataSource.getStudent();
    emit(StudentUpdateVerificationSuccess(studentModel: studentModel!));
  }

  // Future<void> _onLoadOrderDetailBydId(
  //     LoadOrderDetailById event, Emitter<StudentState> emit) async {
  //   emit(StudentOrderDetailLoading());
  //   try {
  //     var apiResponse = await studentRepository.fetchOrderDetailByStudentId(
  //         studentId: event.studentId, orderId: event.orderId);
  //     if (apiResponse != null) {
  //       emit(StudentOrderDetailLoaded(orderDetailModel: apiResponse));
  //     } else {
  //       emit(StudentFaled(error: 'Lỗi xử lí!'));
  //     }
  //   } catch (e) {
  //     emit(StudentFaled(error: e.toString()));
  //   }
  // }
}
