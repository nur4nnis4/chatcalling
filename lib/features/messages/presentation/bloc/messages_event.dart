part of 'messages_bloc.dart';

abstract class MessagesEvent extends Equatable {
  const MessagesEvent();

  @override
  List<Object> get props => [];
}

class GetConversationsEvent extends MessagesEvent {
  final String userId;

  GetConversationsEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class GetMessagesEvent extends MessagesEvent {
  final String conversationId;

  GetMessagesEvent(this.conversationId);

  @override
  List<Object> get props => [conversationId];
}

class SendMessagesEvent extends MessagesEvent {
  final String text;
  final String receiverId;
  final String attachmentPath;

  SendMessagesEvent(
      {required this.text,
      required this.receiverId,
      required this.attachmentPath});

  @override
  List<Object> get props => [text, receiverId, attachmentPath];
}

class UpdateReadStatusEvent extends MessagesEvent {
  final String conversationId;

  UpdateReadStatusEvent(this.conversationId);

  @override
  List<Object> get props => [conversationId];
}
