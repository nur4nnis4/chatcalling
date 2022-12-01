import 'package:bloc/bloc.dart';
import 'package:chatcalling/core/common_features/user/domain/entities/user.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/get_user_data.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'other_user_event.dart';
part 'other_user_state.dart';

class OtherUserBloc extends Bloc<GetOtherUserEvent, OtherUserState> {
  final GetUserData getUserData;
  OtherUserBloc({required this.getUserData}) : super(OtherUserEmpty()) {
    on<GetOtherUserEvent>((event, emit) async {
      emit(OtherUserLoading());
      final result = getUserData(userId: event.userId).asBroadcastStream();
      await emit.forEach(result,
          onData: (Either<Failure, User> data) => data.fold(
              (error) => OtherUserError(errorMessage: error.message),
              (userData) => OtherUserLoaded(userData: userData)));
    });
  }
}
