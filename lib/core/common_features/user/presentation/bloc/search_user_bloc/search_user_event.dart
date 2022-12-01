part of 'search_user_bloc.dart';

class SearchUserEvent extends Equatable {
  final String query;
  const SearchUserEvent({required this.query});

  @override
  List<Object> get props => [];
}
