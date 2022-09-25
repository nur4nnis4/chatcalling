import 'package:chatcalling/features/messages/data/models/conversation_model.dart';
import 'package:chatcalling/features/messages/domain/entities/conversation.dart';

final tConversation = Conversation(
    conversationId: 'conversation1',
    lastText: 'Hello',
    lastMessageTime: DateTime.now(),
    lastSenderId: 'user1',
    friendId: 'user2',
    totalUnreadMessages: 1);

final tConversationModel = ConversationModel(
  conversationId: 'user1Id-user2Id',
  friendId: 'user2Id',
  lastText: 'Hello',
  lastMessageTime: DateTime.parse("2022-07-18T16:37:47.475845Z").toLocal(),
  lastSenderId: 'user1Id',
  totalUnreadMessages: 0,
);

final Map<String, dynamic> tConversationJson = {
  "conversationId": "user1Id-user2Id",
  "lastText": "Hello",
  "lastMessageTime": "2022-07-18T16:37:47.475845Z",
  "lastSenderId": "user1Id",
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
    "lastText": "Hello",
    "lastMessageTime": "2022-07-18T16:37:47.475845Z",
    "lastSenderId": "user1Id",
    "members": ["user1Id", "user2Id"],
    "member_details": {
      "user1Id": {"totalUnread": 2, "friendId": "user2Id"},
      "user2Id": {"totalUnread": 4, "friendId": "user1Id"}
    }
  },
  {
    "conversationId": "user3Id-user4Id",
    "lastText": "Hello",
    "lastMessageTime": "2022-08-18T16:37:47.475845Z",
    "lastSenderId": "user3Id",
    "members": ["user3Id", "user4Id"],
    "member_details": {
      "user3Id": {"totalUnread": 2, "friendId": "user4Id"},
      "user4Id": {"totalUnread": 4, "friendId": "user3Id"}
    }
  },
  {
    "conversationId": "user1Id-user4Id",
    "lastText": "Hello",
    "lastMessageTime": "2022-09-18T16:37:47.475845Z",
    "lastSenderId": "user1Id",
    "members": ["user1Id", "user4Id"],
    "member_details": {
      "user1Id": {"totalUnread": 2, "friendId": "user4Id"},
      "user4Id": {"totalUnread": 4, "friendId": "user1Id"}
    }
  }
];
final List<ConversationModel> tExpectedConversationList = [
  ConversationModel.fromJson(json: {
    "conversationId": "user1Id-user4Id",
    "lastText": "Hello",
    "lastMessageTime": "2022-09-18T16:37:47.475845Z",
    "lastSenderId": "user1Id",
    "members": ["user1Id", "user4Id"],
    "member_details": {
      "user1Id": {"totalUnread": 2, "friendId": "user4Id"},
      "user4Id": {"totalUnread": 4, "friendId": "user1Id"}
    }
  }, userId: "user1Id"),
  ConversationModel.fromJson(json: {
    "conversationId": "user1Id-user2Id",
    "lastText": "Hello",
    "lastMessageTime": "2022-07-18T16:37:47.475845Z",
    "lastSenderId": "user1Id",
    "members": ["user1Id", "user2Id"],
    "member_details": {
      "user1Id": {"totalUnread": 2, "friendId": "user2Id"},
      "user2Id": {"totalUnread": 4, "friendId": "user1Id"}
    }
  }, userId: "user1Id"),
];
