import 'package:chatcalling/core/common_features/attachment/data/models/attachment_model.dart';
import 'package:chatcalling/features/messages/data/models/message_model.dart';
import 'package:chatcalling/core/common_features/attachment/domain/entities/attachment.dart';
import 'package:chatcalling/features/messages/domain/entities/message.dart';

import 'attachment_dummy.dart';

final tMessage = Message(
    messageId: "messageId",
    conversationId: "user1Id-user2Id",
    text: "Hello",
    senderId: "user1Id",
    receiverId: "user2Id",
    timeStamp: DateTime.parse("2022-07-18 16:37:47.475845Z"),
    isRead: false,
    attachments: [Attachment(url: "http://image1.jpg", contentType: 'Image')]);

final tMessageModel = MessageModel(
    messageId: "message1Id",
    conversationId: "user1Id-user2Id",
    text: "Hello",
    senderId: "user1Id",
    receiverId: "user2Id",
    timeStamp: DateTime.parse("2022-07-18 16:37:47.475845Z").toLocal(),
    isRead: false,
    attachments: [
      AttachmentModel(url: "http://image1.jpg", contentType: 'Image')
    ]);

final Map<String, dynamic> tMessageJson = {
  "messageId": "message1Id",
  "conversationId": "user1Id-user2Id",
  "text": "Hello",
  "senderId": "user1Id",
  "receiverId": "user2Id",
  "timeStamp": "2022-07-18T16:37:47.475845Z",
  "isRead": false,
  "attachments": [
    {"url": "http://image1.jpg", "contentType": "Image"}
  ]
};

final tNewMessageModel = MessageModel(
    messageId: 'newMessageId',
    conversationId: 'user1Id-user2Id',
    text: 'How are you?',
    senderId: 'user1Id',
    receiverId: 'user2Id',
    timeStamp: DateTime.parse("2022-10-31T16:59:32.905450Z").toLocal(),
    isRead: false,
    attachments: []);

final tNewMessageModel2 = MessageModel(
    messageId: 'newMessageId2',
    conversationId: 'user1Id-user5Id',
    text: 'How are you?',
    senderId: 'user1Id',
    receiverId: 'user5Id',
    timeStamp: DateTime.parse("2022-10-31T16:59:32.905450Z"),
    isRead: false,
    attachments: []);

final tNewMessageWithAttachment = MessageModel(
    messageId: 'newMessageId',
    conversationId: 'user1Id-user2Id',
    text: 'How are you?',
    senderId: 'user1Id',
    receiverId: 'user2Id',
    timeStamp: DateTime.parse("2022-10-31T16:59:32.905450Z").toLocal(),
    isRead: false,
    attachments: tAttachmentModelList);

final tExpectedMessageWithAttachment = MessageModel(
    messageId: 'newMessageId',
    conversationId: 'user1Id-user2Id',
    text: 'How are you?',
    senderId: 'user1Id',
    receiverId: 'user2Id',
    timeStamp: DateTime.parse("2022-10-31T16:59:32.905450Z").toLocal(),
    isRead: false,
    attachments: tExpectedAttachmentModelList);

// For message_remote_datasource_test

final List<Map<String, dynamic>> tMessageListJson = [
  {
    "messageId": "message1Id",
    "conversationId": "user1Id-user2Id",
    "text": "Hello",
    "senderId": "user1Id",
    "receiverId": "user2Id",
    "timeStamp": "2022-07-18T16:37:47.475845Z",
    "isRead": false,
    "attachments": [
      {"url": "http://image1.jpg", "contentType": "Image"}
    ]
  },
  {
    "messageId": "message2Id",
    "conversationId": "user1Id-user2Id",
    "text": "Hello",
    "senderId": "user2Id",
    "receiverId": "user1Id",
    "timeStamp": "2022-07-08T16:37:47.475845Z",
    "isRead": true,
    "attachments": [
      {"url": "http://image1.jpg", "contentType": "Image"}
    ]
  },
  {
    "messageId": "message3Id",
    "conversationId": "user1Id-user2Id",
    "text": "Hello",
    "senderId": "user1Id",
    "receiverId": "user2Id",
    "timeStamp": "2022-07-05T16:37:47.475845Z",
    "isRead": false,
    "attachments": [
      {"url": "http://image1.jpg", "contentType": "Image"}
    ]
  },
  {
    "messageId": "message4Id",
    "conversationId": "user1Id-user2Id",
    "text": "Hello",
    "senderId": "user2Id",
    "receiverId": "user1Id",
    "timeStamp": "2022-07-27T16:37:47.475845Z",
    "isRead": false,
    "attachments": [
      {"url": "http://image1.jpg", "contentType": "Image"}
    ]
  },
  {
    "messageId": "message5Id",
    "conversationId": "user1Id-user2Id",
    "text": "Hello",
    "senderId": "user2Id",
    "receiverId": "user1Id",
    "timeStamp": "2022-07-02T16:37:47.475845Z",
    "isRead": false,
    "attachments": [
      {"url": "http://image1.jpg", "contentType": "Image"}
    ]
  }
];

final List<MessageModel> tExpectedAscendingMessageList = [
  MessageModel.fromJson({
    "messageId": "message5Id",
    "conversationId": "user1Id-user2Id",
    "text": "Hello",
    "senderId": "user2Id",
    "receiverId": "user1Id",
    "timeStamp": "2022-07-02T16:37:47.475845Z",
    "isRead": false,
    "attachments": [
      {"url": "http://image1.jpg", "contentType": "Image"}
    ]
  }),
  MessageModel.fromJson({
    "messageId": "message3Id",
    "conversationId": "user1Id-user2Id",
    "text": "Hello",
    "senderId": "user1Id",
    "receiverId": "user2Id",
    "timeStamp": "2022-07-05T16:37:47.475845Z",
    "isRead": false,
    "attachments": [
      {"url": "http://image1.jpg", "contentType": "Image"}
    ]
  }),
  MessageModel.fromJson({
    "messageId": "message2Id",
    "conversationId": "user1Id-user2Id",
    "text": "Hello",
    "senderId": "user2Id",
    "receiverId": "user1Id",
    "timeStamp": "2022-07-08T16:37:47.475845Z",
    "isRead": true,
    "attachments": [
      {"url": "http://image1.jpg", "contentType": "Image"}
    ]
  }),
  MessageModel.fromJson({
    "messageId": "message1Id",
    "conversationId": "user1Id-user2Id",
    "text": "Hello",
    "senderId": "user1Id",
    "receiverId": "user2Id",
    "timeStamp": "2022-07-18T16:37:47.475845Z",
    "isRead": false,
    "attachments": [
      {"url": "http://image1.jpg", "contentType": "Image"}
    ]
  }),
  MessageModel.fromJson({
    "messageId": "message4Id",
    "conversationId": "user1Id-user2Id",
    "text": "Hello",
    "senderId": "user2Id",
    "receiverId": "user1Id",
    "timeStamp": "2022-07-27T16:37:47.475845Z",
    "isRead": false,
    "attachments": [
      {"url": "http://image1.jpg", "contentType": "Image"}
    ]
  }),
];
final List<MessageModel> tExpectedDescendingMessageList = [
  MessageModel.fromJson({
    "messageId": "message4Id",
    "conversationId": "user1Id-user2Id",
    "text": "Hello",
    "senderId": "user2Id",
    "receiverId": "user1Id",
    "timeStamp": "2022-07-27T16:37:47.475845Z",
    "isRead": false,
    "attachments": [
      {"url": "http://image1.jpg", "contentType": "Image"}
    ]
  }),
  MessageModel.fromJson({
    "messageId": "message1Id",
    "conversationId": "user1Id-user2Id",
    "text": "Hello",
    "senderId": "user1Id",
    "receiverId": "user2Id",
    "timeStamp": "2022-07-18T16:37:47.475845Z",
    "isRead": false,
    "attachments": [
      {"url": "http://image1.jpg", "contentType": "Image"}
    ]
  }),
  MessageModel.fromJson({
    "messageId": "message2Id",
    "conversationId": "user1Id-user2Id",
    "text": "Hello",
    "senderId": "user2Id",
    "receiverId": "user1Id",
    "timeStamp": "2022-07-08T16:37:47.475845Z",
    "isRead": true,
    "attachments": [
      {"url": "http://image1.jpg", "contentType": "Image"}
    ]
  }),
  MessageModel.fromJson({
    "messageId": "message3Id",
    "conversationId": "user1Id-user2Id",
    "text": "Hello",
    "senderId": "user1Id",
    "receiverId": "user2Id",
    "timeStamp": "2022-07-05T16:37:47.475845Z",
    "isRead": false,
    "attachments": [
      {"url": "http://image1.jpg", "contentType": "Image"}
    ]
  }),
  MessageModel.fromJson({
    "messageId": "message5Id",
    "conversationId": "user1Id-user2Id",
    "text": "Hello",
    "senderId": "user2Id",
    "receiverId": "user1Id",
    "timeStamp": "2022-07-02T16:37:47.475845Z",
    "isRead": false,
    "attachments": [
      {"url": "http://image1.jpg", "contentType": "Image"}
    ]
  }),
];
