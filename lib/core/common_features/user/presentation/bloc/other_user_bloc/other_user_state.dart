part of 'other_user_bloc.dart';

abstract class OtherUserState extends Equatable {
  const OtherUserState();

  @override
  List<Object> get props => [];
}

class OtherUserEmpty extends OtherUserState {}

class OtherUserLoading extends OtherUserState {}

class OtherUserLoaded extends OtherUserState {
  final User userData;

  OtherUserLoaded({
    required this.userData,
  });

  @override
  List<Object> get props => [userData];
}

class OtherUserError extends OtherUserState {
  final String errorMessage;

  OtherUserError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
