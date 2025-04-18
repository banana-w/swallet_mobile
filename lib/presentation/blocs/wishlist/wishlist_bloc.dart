import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/student_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/wishlist_repository.dart';
import 'package:swallet_mobile/data/models/student_features/wishlist_model.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final StudentRepository studentRepository;
  final WishListRepository wishListRepository;

  WishlistBloc({
    required this.studentRepository,
    required this.wishListRepository,
  }) : super(WishlistInitial()) {
    on<LoadWishListByStudentId>(_onLoadWishListByStudentId);
    on<CreateWishList>(_onCreateWishList);
    on<CheckWishListStatus>(_onCheckWishListStatus);
  }

  Future<void> _onLoadWishListByStudentId(
    LoadWishListByStudentId event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishListLoading());
    try {
      var apiResponse = await wishListRepository.fetchWishLists();
      emit(WishListLoaded(wishList: apiResponse!.result));
    } catch (e) {
      emit(WishListFailed(error: e.toString()));
    }
  }

  Future<void> _onCreateWishList(
    CreateWishList event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishListLoading());
    try {
      var apiResponse = await wishListRepository.postWishList(
        studentId: event.studentId,
        brandId: event.brandId,
        description: event.description,
        state: event.state,
      );
      emit(CreateWishListSuccess(wishlist: apiResponse!));
    } catch (e) {
      emit(WishListFailed(error: e.toString()));
    }
  }

  Future<void> _onCheckWishListStatus(
    CheckWishListStatus event,
    Emitter<WishlistState> emit,
  ) async {
    try {
      var apiResponse = await wishListRepository.fetchWishLists();
      final isFollowed = apiResponse!.result.any(
        (w) => w.brandId == event.brandId && w.status == true,
      );
      emit(WishListStatusChecked(isFollowed: isFollowed));
    } catch (e) {
      emit(WishListStatusChecked(isFollowed: false));
    }
  }
}
