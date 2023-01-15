part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInEmpty extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {}

class SignInError extends SignInState {
  final String errorMessage;

  SignInError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
