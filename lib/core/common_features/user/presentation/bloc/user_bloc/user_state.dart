part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserEmpty extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final User userData;

  UserLoaded({
    required this.userData,
  });

  @override
  List<Object> get props => [userData];
}

class UserError extends UserState {
  final String errorMessage;

  UserError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
