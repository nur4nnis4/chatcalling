import 'package:bloc/bloc.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/auth_usecases/sign_out.dart';
import 'package:equatable/equatable.dart';

part 'sign_out_event.dart';
part 'sign_out_state.dart';

class SignOutBloc extends Bloc<SignOutEvent, SignOutState> {
  final SignOut signOut;
  SignOutBloc({required this.signOut}) : super(SignOutInitial()) {
    on<SignOutEvent>((event, emit) async {
      emit(SignOutLoading());

      final result = await signOut();

      result.fold((error) {
        print(error.message);
        emit(SignOutError(errorMessage: 'Oops something went wrong!'));
      }, (succes) => emit(SignOutSuccess()));
    });
  }
}
