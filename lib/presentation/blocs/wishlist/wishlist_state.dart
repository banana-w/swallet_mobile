part of 'wishlist_bloc.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishListLoading extends WishlistState {}

class WishListLoaded extends WishlistState {
  final List<WishListModel> wishList;

  const WishListLoaded({required this.wishList});

  @override
  List<Object> get props => [wishList];
}

class CreateWishListSuccess extends WishlistState {
  final WishListModel wishlist;

  const CreateWishListSuccess({required this.wishlist});

  @override
  List<Object> get props => [wishlist];
}

class WishListFailed extends WishlistState {
  final String error;

  const WishListFailed({required this.error});

  @override
  List<Object> get props => [error];
}

class WishListStatusChecked extends WishlistState {
  final bool isFollowed;

  const WishListStatusChecked({required this.isFollowed});

  @override
  List<Object> get props => [isFollowed];
}
