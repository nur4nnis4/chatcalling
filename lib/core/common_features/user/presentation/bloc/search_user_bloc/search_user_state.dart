part of 'search_user_bloc.dart';

abstract class SearchUserState extends Equatable {
  const SearchUserState();

  @override
  List<Object> get props => [];
}

class SearchUserEmpty extends SearchUserState {}

class SearchUserLoading extends SearchUserState {}

class SearchUserLoaded extends SearchUserState {
  final List<User> matchedUserList;

  SearchUserLoaded({required this.matchedUserList});

  @override
  List<Object> get props => [matchedUserList];
}

class SearchUserError extends SearchUserState {
  final String errorMessage;

  SearchUserError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
