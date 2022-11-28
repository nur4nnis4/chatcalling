import 'package:chatcalling/core/common_features/user/data/models/user_model.dart';
import 'package:chatcalling/core/common_features/user/domain/entities/user.dart';
import 'package:chatcalling/features/messages/data/models/message_model.dart';

import '../../domain/entities/conversation.dart';
import '../../domain/entities/message.dart';

// ignore: must_be_immutable
class ConversationModel extends Conversation {
  ConversationModel({
    required String conversationId,
    required User friendUser,
    required Message lastMessage,
    required int totalUnreadMessages,
  }) : super(
            conversationId: conversationId,
            friendUser: friendUser,
            lastMessage: lastMessage,
            totalUnreadMessages: totalUnreadMessages);

  factory ConversationModel.fromJson({
    required Map<String, dynamic>? json,
    required Map<String, dynamic> lastMessageJson,
    required Map<String, dynamic> friendUserJson,
    required String userId,
  }) =>
      ConversationModel(
        conversationId: json?['conversationId'],
        friendUser: UserModel.fromJson(friendUserJson),
        lastMessage: MessageModel.fromJson(lastMessageJson),
        totalUnreadMessages: json?['member_details'][userId]['totalUnread'],
      );

  Map<String, dynamic> toJson(
          {required String userId, int? friendTotalUnread}) =>
      {
        'conversationId': conversationId,
        'lastMessageId': lastMessage.messageId,
        'lastMessageTime': lastMessage.timeStamp.toUtc().toIso8601String(),
        'members': [userId, friendUser.userId],
        'member_details': {
          userId: {
            "totalUnread": totalUnreadMessages,
            "friendId": friendUser.userId
          },
          friendUser.userId: {
            "totalUnread": friendTotalUnread ?? 1,
            "friendId": userId
          }
        }
      };
}
