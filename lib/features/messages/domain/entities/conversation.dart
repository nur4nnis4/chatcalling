import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Conversation extends Equatable {
  final String conversationId;
  String friendId;
  String lastText;
  DateTime lastMessageTime;
  String lastSenderId;
  int totalUnreadMessages;

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
