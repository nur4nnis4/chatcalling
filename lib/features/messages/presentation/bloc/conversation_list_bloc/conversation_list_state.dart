part of 'conversation_list_bloc.dart';

abstract class ConversationListState extends Equatable {
  const ConversationListState();

  @override
  List<Object> get props => [];
}

class ConversationListEmpty extends ConversationListState {}

class ConversationListLoading extends ConversationListState {}

class ConversationListLoaded extends ConversationListState {
  final List<Conversation> conversationList;
  final String userId;

  ConversationListLoaded(
      {required this.conversationList, required this.userId});

  @override
  List<Object> get props => [conversationList];
}

class ConversationListError extends ConversationListState {
  final String errorMessage;

  ConversationListError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
