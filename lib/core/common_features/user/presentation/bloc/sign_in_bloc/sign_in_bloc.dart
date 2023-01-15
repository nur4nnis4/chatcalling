import 'package:bloc/bloc.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/auth_usecases/sign_in_with_email.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/auth_usecases/sign_in_with_google.dart';
import 'package:equatable/equatable.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInWithEmail signInWithEmail;
  final SignInWithGoogle signInWithGoogle;
  SignInBloc({required this.signInWithEmail, required this.signInWithGoogle})
      : super(SignInEmpty()) {
    on<SignInWithEmailEvent>((event, emit) async {
      if (event.email.isNotEmpty && event.password.isNotEmpty) {
        emit(SignInLoading());

        final result =
            await signInWithEmail(email: event.email, password: event.password);
        result.fold((error) => emit(SignInError(errorMessage: error.message)),
            (success) => emit(SignInSuccess()));
      } else
        emit(
            SignInError(errorMessage: 'Email or password should not be empty'));
    });

    on<SignInWithGoogleEvent>((event, emit) async {
      emit(SignInLoading());
      final result = await signInWithGoogle();
      result.fold((error) => emit(SignInError(errorMessage: error.message)),
          (success) => emit(SignInSuccess()));
    });
  }
}
