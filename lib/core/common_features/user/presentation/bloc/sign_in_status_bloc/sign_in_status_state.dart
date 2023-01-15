part of 'sign_in_status_bloc.dart';

abstract class SignInStatusState extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInStatusInitial extends SignInStatusState {}

class SignInStatusTrue extends SignInStatusState {}

class SignInStatusFalse extends SignInStatusState {}
