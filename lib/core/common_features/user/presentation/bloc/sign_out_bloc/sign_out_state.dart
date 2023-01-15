part of 'sign_out_bloc.dart';

abstract class SignOutState extends Equatable {
  const SignOutState();

  @override
  List<Object> get props => [];
}

class SignOutInitial extends SignOutState {}

class SignOutLoading extends SignOutState {}

class SignOutSuccess extends SignOutState {}

class SignOutError extends SignOutState {
  final String errorMessage;

  SignOutError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
