import 'package:bloc/bloc.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/auth_usecases/get_current_user_id.dart';
import '../../../../../error/failures.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/user_usercases/get_user_data.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<GetUserEvent, UserState> {
  final GetUserData getUserData;
  final GetCurrentUserId getCurrentUserId;

  UserBloc({required this.getUserData, required this.getCurrentUserId})
      : super(UserEmpty()) {
    on<GetUserEvent>((event, emit) async {
      emit(UserLoading());
      final result =
          getUserData(userId: await getCurrentUserId()).asBroadcastStream();
      await emit.forEach(result, onData: (Either<Failure, User> data) {
        return data.fold((error) => UserError(errorMessage: error.message),
            (userData) => UserLoaded(userData: userData));
      });
    });
  }
}
