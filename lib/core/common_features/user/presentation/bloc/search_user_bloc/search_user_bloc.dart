import 'package:bloc/bloc.dart';
import 'package:chatcalling/core/common_features/user/domain/entities/user.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/search_user.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
part 'search_user_event.dart';
part 'search_user_state.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  final SearchUser searchUser;
  SearchUserBloc({required this.searchUser}) : super(SearchUserEmpty()) {
    on<SearchUserEvent>((event, emit) async {
      if (event.query.isNotEmpty) {
        emit(SearchUserLoading());
        final result = searchUser(query: event.query).asBroadcastStream();

        await emit.forEach(result,
            onData: (Either<Failure, List<User>> data) => data.fold(
                (error) => SearchUserError(errorMessage: error.message),
                (userList) => userList.isEmpty
                    ? SearchUserEmpty()
                    : SearchUserLoaded(matchedUserList: userList)));
      } else {
        emit(SearchUserEmpty());
      }
    });
  }
}
