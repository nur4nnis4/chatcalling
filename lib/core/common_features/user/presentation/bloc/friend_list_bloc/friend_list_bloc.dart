import 'package:bloc/bloc.dart';
import 'package:chatcalling/core/common_features/user/domain/entities/user.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/auth_usecases/get_current_user_id.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/user_usercases/get_friend_list.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'friend_list_event.dart';
part 'friend_list_state.dart';

class FriendListBloc extends Bloc<FriendListEvent, FriendListState> {
  final GetFriendList getFriendList;
  final GetCurrentUserId getCurrentUserId;
  FriendListBloc({required this.getFriendList, required this.getCurrentUserId})
      : super(FriendListEmpty()) {
    on<GetFriendListEvent>((event, emit) async {
      emit(FriendListLoading());

      final friendListStream =
          getFriendList(userId: await getCurrentUserId()).asBroadcastStream();

      await emit.forEach(friendListStream,
          onData: (Either<Failure, List<User>> data) => data.fold(
              (error) => FriendListError(errorMessage: error.message),
              (friendList) => friendList.isEmpty
                  ? FriendListEmpty()
                  : FriendListLoaded(friendList: friendList)));
    });
  }
}
