import 'package:chatcalling/features/messages/data/models/conversation_model.dart';
import 'package:chatcalling/features/messages/domain/entities/conversation.dart';

import 'message_dummy.dart';
import 'user_dummy.dart';

final tConversation = Conversation(
    conversationId: 'conversation1',
    lastMessage: tMessage,
    friendUser: tUser,
    totalUnreadMessages: 1);

final tConversationModel = ConversationModel(
  conversationId: 'user1Id-user2Id',
  friendUser: tUserModel,
  lastMessage: tMessageModel,
  totalUnreadMessages: 0,
);

// For message model to conversation json test

final Map<String, dynamic> tConversationJson = {
  "conversationId": "user1Id-user2Id",
  "lastMessageId": "message1Id",
  "lastMessageTime": "2022-07-18T16:37:47.475845Z",
  "members": ["user1Id", "user2Id"],
  "member_details": {
    "user1Id": {"totalUnread": 0, "friendId": "user2Id"},
    "user2Id": {"totalUnread": 1, "friendId": "user1Id"}
  }
};

// For remote_data_source_test.dart

final List<Map<String, dynamic>> tConversationListJson = [
  {
    "conversationId": "user1Id-user2Id",
    "lastMessageId": "message1Id",
    "lastMessageTime": "2022-07-18T16:37:47.475845Z",
    "members": ["user1Id", "user2Id"],
    "member_details": {
      "user1Id": {"totalUnread": 0, "friendId": "user2Id"},
      "user2Id": {"totalUnread": 1, "friendId": "user1Id"}
    }
  },
  {
    "conversationId": "user3Id-user4Id",
    "lastMessageId": "message2Id",
    "lastMessageTime": "2022-08-18T16:37:47.475845Z",
    "members": ["user3Id", "user4Id"],
    "member_details": {
      "user3Id": {"totalUnread": 2, "friendId": "user4Id"},
      "user4Id": {"totalUnread": 4, "friendId": "user3Id"}
    }
  },
];
final List<ConversationModel> tExpectedConversationList = [
  ConversationModel(
      conversationId: "user1Id-user2Id",
      friendUser: tUserModel2,
      lastMessage: tMessageModel,
      totalUnreadMessages: 0),
];
