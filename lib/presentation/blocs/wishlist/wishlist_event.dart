part of 'wishlist_bloc.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class LoadWishListByStudentId extends WishlistEvent {}

class CreateWishList extends WishlistEvent {
  final String studentId;
  final String brandId;
  final String description;
  final bool state;

  const CreateWishList({
    required this.studentId,
    required this.brandId,
    required this.description,
    required this.state,
  });

  @override
  List<Object> get props => [studentId, brandId, description, state];
}

class CheckWishListStatus extends WishlistEvent {
  final String studentId;
  final String brandId;

  const CheckWishListStatus({required this.studentId, required this.brandId});

  @override
  List<Object> get props => [studentId, brandId];
}
