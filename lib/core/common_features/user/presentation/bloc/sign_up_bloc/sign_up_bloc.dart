import 'package:bloc/bloc.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/auth_usecases/sign_up_with_email.dart';
import 'package:chatcalling/core/common_features/user/domain/usecases/user_usercases/check_username_availability.dart';
import 'package:chatcalling/core/common_features/user/presentation/utils/form_validator.dart';
import 'package:chatcalling/core/common_features/user/presentation/utils/user_input_converter.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpWithEmail signUpWithEmail;
  final UserInputConverter userInputConverter;
  final FormValidator formValidator;
  final CheckUsernameAvailability checkUsernameAvailability;

  SignUpBloc({
    required this.signUpWithEmail,
    required this.userInputConverter,
    required this.formValidator,
    required this.checkUsernameAvailability,
  }) : super(SignUpWithEmailEmpty()) {
    on<SignUpWithEmailEvent>((event, emit) async {
      final isValid = formValidator.validate(
          username: event.username,
          email: event.email,
          displayName: event.displayName,
          password: event.password);

      await isValid.fold(
          (error) async =>
              emit(SignUpWithEmailError.copyWith(errorMessage: error.message)),
          (valid) async {
        emit(SignUpWithEmailLoading());

        final isUsernameAvailable =
            await checkUsernameAvailability(username: event.username);

        await isUsernameAvailable.fold((error) async {
          emit(SignUpWithEmailError.copyWith(errorMessage: error.message));
        }, (available) async {
          final result = await signUpWithEmail(
              user: userInputConverter.toUser(
                  username: event.username, displayName: event.displayName),
              personalInformation:
                  userInputConverter.toPersonalInformation(email: event.email),
              password: event.password);
          await result.fold(
              (error) async => emit(
                  SignUpWithEmailError.copyWith(errorMessage: error.message)),
              (success) async => emit(SignUpWithEmailSuccess()));
        });
      });
    });
  }
}
