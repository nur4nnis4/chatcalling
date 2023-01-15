part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

class SignUpWithEmailEmpty extends SignUpState {}

class SignUpWithEmailLoading extends SignUpState {}

class SignUpWithEmailSuccess extends SignUpState {}

// ignore: must_be_immutable
class SignUpWithEmailError extends SignUpState {
  String? emailError;
  String? usernameError;
  String? displayNameError;
  String? passwordError;

  SignUpWithEmailError({
    this.emailError,
    this.usernameError,
    this.displayNameError,
    this.passwordError,
  });

  static SignUpWithEmailError copyWith({required String errorMessage}) =>
      SignUpWithEmailError(
        emailError:
            errorMessage.toLowerCase().contains('email') ? errorMessage : null,
        usernameError: errorMessage.toLowerCase().contains('username')
            ? errorMessage
            : null,
        displayNameError: errorMessage.toLowerCase().contains('display name')
            ? errorMessage
            : null,
        passwordError: errorMessage.toLowerCase().contains('password')
            ? errorMessage
            : null,
      );

  @override
  List<Object?> get props => [
        emailError,
        usernameError,
        displayNameError,
        passwordError,
      ];
}
