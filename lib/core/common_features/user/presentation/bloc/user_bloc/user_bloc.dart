import 'package:bloc/bloc.dart';
import 'package:chatcalling/core/helpers/temp.dart';
import '../../../../../error/failures.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/get_user_data.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<GetUserEvent, UserState> {
  final GetUserData getUserData;

  UserBloc({required this.getUserData}) : super(UserEmpty()) {
    on<GetUserEvent>((event, emit) async {
      emit(UserLoading());
      final result = getUserData(userId: Temp.userId).asBroadcastStream();
      await emit.forEach(result, onData: (Either<Failure, User> data) {
        return data.fold((error) => UserError(errorMessage: error.message),
            (userData) => UserLoaded(userData: userData));
      });
    });
  }
}
