import 'package:bloc/bloc.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/user_usercases/check_username_availability.dart';
import 'package:equatable/equatable.dart';

part 'username_availability_event.dart';
part 'username_availability_state.dart';

class UsernameAvailabilityBloc
    extends Bloc<CheckUsernameAvailabilityEvent, UsernameAvailabilityState> {
  final CheckUsernameAvailability checkUsernameAvailability;
  UsernameAvailabilityBloc({required this.checkUsernameAvailability})
      : super(UsernameInitial()) {
    on<CheckUsernameAvailabilityEvent>((event, emit) async {
      if (event.currentUsername != event.newUsername &&
          event.newUsername.isNotEmpty) {
        print('Test');
        emit(UsernameLoading());
        final result =
            await checkUsernameAvailability(username: event.newUsername);

        result.fold((error) => emit(UsernameTaken(message: error.message)),
            (avail) => emit(UsernameAvailable()));
      } else {
        emit(UsernameInitial());
      }
    });
  }
}
