part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInWithEmailEvent extends SignInEvent {
  final String email;
  final String password;
  SignInWithEmailEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignInWithGoogleEvent extends SignInEvent {}
