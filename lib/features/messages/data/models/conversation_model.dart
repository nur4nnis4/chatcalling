import 'package:chatcalling/features/messages/domain/entities/conversation.dart';
import 'package:chatcalling/features/messages/domain/entities/message.dart';

// ignore: must_be_immutable
class ConversationModel extends Conversation {
  ConversationModel({
    required String conversationId,
    required String friendId,
    required String lastText,
    required DateTime lastMessageTime,
    required String lastSenderId,
    required int totalUnreadMessages,
  }) : super(
            conversationId: conversationId,
            friendId: friendId,
            lastText: lastText,
            lastMessageTime: lastMessageTime,
            lastSenderId: lastSenderId,
            totalUnreadMessages: totalUnreadMessages);

  factory ConversationModel.fromJson(
          {required Map<String, dynamic>? json, required String userId}) =>
      ConversationModel(
        conversationId: json?['conversationId'],
        friendId: json?['members'][userId]['friendId'],
        lastText: json?['lastText'],
        lastMessageTime: DateTime.parse(json?['lastMessageTime']),
        lastSenderId: json?['lastSenderId'],
        totalUnreadMessages: json?['members'][userId]['totalUnread'],
      );

  Map<String, dynamic> toJson(
      {required String userId, int? friendTotalUnread}) {
    return {
      'conversationId': conversationId,
      'lastText': lastText,
      'lastMessageTime': lastMessageTime.isUtc
          ? lastMessageTime.toIso8601String()
          : lastMessageTime.toUtc().toIso8601String(),
      'lastSenderId': lastSenderId,
      'members': {
        userId: {"totalUnread": totalUnreadMessages, "friendId": friendId},
        friendId: {"totalUnread": friendTotalUnread ?? 1, "friendId": userId}
      }
    };
  }

  factory ConversationModel.fromMessage({required Message message}) {
    return ConversationModel(
        conversationId: message.conversationId,
        friendId: message.receiverId,
        lastText: message.text,
        lastMessageTime: message.timeStamp,
        lastSenderId: message.senderId,
        totalUnreadMessages: 0);
  }
}
