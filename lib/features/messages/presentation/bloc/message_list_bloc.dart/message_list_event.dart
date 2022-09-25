part of 'message_list_bloc.dart';

abstract class MessageListEvent extends Equatable {
  const MessageListEvent();

  @override
  List<Object> get props => [];
}

class GetMessagesEvent extends MessageListEvent {
  final String conversationId;

  GetMessagesEvent(this.conversationId);

  @override
  List<Object> get props => [conversationId];
}

class SendMessagesEvent extends MessageListEvent {
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

class UpdateReadStatusEvent extends MessageListEvent {
  final String conversationId;

  UpdateReadStatusEvent(this.conversationId);

  @override
  List<Object> get props => [conversationId];
}
