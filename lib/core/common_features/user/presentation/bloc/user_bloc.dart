import 'package:bloc/bloc.dart';
import '../../../../error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_user_data.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserData getUserData;

  UserBloc({required this.getUserData}) : super(UserEmpty()) {
    on<UserEvent>((event, emit) async {
      if (event is GetUserDataEvent) {
        emit(UserLoading());
        final result = getUserData(userId: event.userId).asBroadcastStream();
        await emit.forEach(result, onData: (Either<Failure, User> data) {
          return data.fold((error) => UserError(errorMessage: error.message),
              (userData) => UserLoaded(userData: userData));
        });
      }
    });
  }
}
