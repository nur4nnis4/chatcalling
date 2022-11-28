part of 'friend_list_bloc.dart';

abstract class FriendListState extends Equatable {
  const FriendListState();
  @override
  List<Object> get props => [];
}

class FriendListEmpty extends FriendListState {}

class FriendListLoading extends FriendListState {}

class FriendListLoaded extends FriendListState {
  final List<User> friendList;

  FriendListLoaded({required this.friendList});

  static FriendListLoaded copyWith({required List<User> friendList}) =>
      FriendListLoaded(friendList: friendList);

  @override
  List<Object> get props => [friendList];
}

class FriendListError extends FriendListState {
  final String errorMessage;

  FriendListError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
