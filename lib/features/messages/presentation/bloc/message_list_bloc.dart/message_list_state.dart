part of 'message_list_bloc.dart';

abstract class MessageListState extends Equatable {
  const MessageListState();

  @override
  List<Object> get props => [];
}

class MessagesEmpty extends MessageListState {}

class MessagesLoading extends MessageListState {}

class MessagesLoaded extends MessageListState {
  final List<Message> messageList;
  final String userId;

  MessagesLoaded({
    required this.messageList,
    required this.userId,
  });

  @override
  List<Object> get props => [messageList, userId];
}

class MessagesSuccess extends MessageListState {
  final String successMessage;

  MessagesSuccess({required this.successMessage});

  @override
  List<Object> get props => [successMessage];
}

class MessagesError extends MessageListState {
  final String errorMessage;

  MessagesError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
