import 'package:equatable/equatable.dart';

class Conversation extends Equatable {
  final String conversationId;
  final String friendId;
  final String lastText;
  final DateTime lastMessageTime;
  final String lastSenderId;
  final int totalUnreadMessages;

  Conversation(
      {required this.conversationId,
      required this.friendId,
      required this.lastText,
      required this.lastMessageTime,
      required this.lastSenderId,
      required this.totalUnreadMessages});

  @override
  List<Object?> get props => [
        conversationId,
        friendId,
        lastText,
        lastMessageTime,
        lastSenderId,
        totalUnreadMessages
      ];
}
