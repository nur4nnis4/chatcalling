part of 'messages_bloc.dart';

abstract class MessagesState extends Equatable {
  const MessagesState();

  @override
  List<Object> get props => [];
}

class MessagesEmpty extends MessagesState {}

class MessagesLoading extends MessagesState {}

class MessagesLoaded extends MessagesState {
  final List<Message> messageList;

  MessagesLoaded({required this.messageList});

  @override
  List<Object> get props => [messageList];
}

class ConversationsLoaded extends MessagesState {
  final List<Conversation> conversationList;

  ConversationsLoaded({required this.conversationList});

  @override
  List<Object> get props => [conversationList];
}

class MessagesSuccess extends MessagesState {
  final String successMessage;

  MessagesSuccess({required this.successMessage});

  @override
  List<Object> get props => [successMessage];
}

class MessagesError extends MessagesState {
  final String errorMessage;

  MessagesError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
