part of 'sign_up_bloc.dart';

class SignUpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpWithEmailEvent extends SignUpEvent {
  final String username;
  final String displayName;
  final String email;
  final String password;

  SignUpWithEmailEvent(
      {required this.username,
      required this.displayName,
      required this.email,
      required this.password});

  @override
  List<Object> get props => [username, displayName, email, password];
}
