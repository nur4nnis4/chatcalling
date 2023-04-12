part of 'update_user_bloc.dart';

abstract class UpdateUserState extends Equatable {
  const UpdateUserState();

  @override
  List<Object?> get props => [];
}

class UpdateUserInitial extends UpdateUserState {}

class UpdateUserLoading extends UpdateUserState {}

class UpdateUserSuccess extends UpdateUserState {}

// ignore: must_be_immutable
class UpdateUserError extends UpdateUserState {
  String? emailError;
  String? usernameError;
  String? displayNameError;
  String? phoneNumberError;
  String? otherError;

  UpdateUserError({
    this.emailError,
    this.usernameError,
    this.displayNameError,
    this.phoneNumberError,
    this.otherError,
  });

  static UpdateUserError copyWith({required String errorMessage}) {
    final lCErrorMessage = errorMessage.toLowerCase();
    return UpdateUserError(
        emailError: lCErrorMessage.contains('email') ? errorMessage : null,
        usernameError:
            lCErrorMessage.contains('username') ? errorMessage : null,
        displayNameError:
            lCErrorMessage.contains('display name') ? errorMessage : null,
        phoneNumberError:
            lCErrorMessage.contains('phone number') ? errorMessage : null,
        otherError: !lCErrorMessage.contains('email') &&
                !lCErrorMessage.contains('username') &&
                !lCErrorMessage.contains('display name') &&
                !lCErrorMessage.contains('phone number')
            ? errorMessage
            : null);
  }

  @override
  List<Object?> get props => [
        emailError,
        usernameError,
        displayNameError,
        phoneNumberError,
        otherError,
      ];
}
