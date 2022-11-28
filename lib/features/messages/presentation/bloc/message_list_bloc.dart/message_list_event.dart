part of 'message_list_bloc.dart';

abstract class MessageListEvent extends Equatable {
  const MessageListEvent();

  @override
  List<Object> get props => [];
}

class GetMessagesEvent extends MessageListEvent {
  final String friendId;

  GetMessagesEvent(this.friendId);

  @override
  List<Object> get props => [friendId];
}

class UpdateReadStatusEvent extends MessageListEvent {
  final String friendId;

  UpdateReadStatusEvent(this.friendId);

  @override
  List<Object> get props => [friendId];
}
