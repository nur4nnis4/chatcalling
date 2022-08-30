import 'package:chatcalling/core/user/data/models/user_model.dart';
import 'package:chatcalling/core/user/domain/entities/user.dart';
import 'package:chatcalling/features/messages/data/models/conversation_model.dart';
import 'package:chatcalling/features/messages/data/models/message_model.dart';
import 'package:chatcalling/features/messages/domain/entities/conversation.dart';
import 'package:chatcalling/features/messages/domain/entities/message.dart';

final tMessage = Message(
    messageId: "messageId",
    conversationId: "user1Id-user2Id",
    text: "Hello",
    senderId: "user1Id",
    receiverId: "user2Id",
    timeStamp: DateTime.parse("2022-07-18 16:37:47.475845Z"),
    isRead: false,
    attachmentUrl: "http://image1.jpg");

final tMessageModel = MessageModel(
    messageId: "messageId",
    conversationId: "user1Id-user2Id",
    text: "Hello",
    senderId: "user1Id",
    receiverId: "user2Id",
    timeStamp: DateTime.parse("2022-07-18 16:37:47.475845Z"),
    isRead: false,
    attachmentUrl: "http://image1.jpg");

final tMessageModelNotUTC = MessageModel(
    messageId: tMessageModel.messageId,
    conversationId: tMessageModel.conversationId,
    text: tMessageModel.text,
    senderId: tMessageModel.senderId,
    receiverId: tMessageModel.receiverId,
    timeStamp: DateTime.parse("2022-07-18 23:37:47.475845"),
    isRead: tMessageModel.isRead,
    attachmentUrl: tMessageModel.attachmentUrl);

final tNewMessageModel = MessageModel(
    messageId: 'newMessageId',
    conversationId: 'user1Id-user2Id',
    text: 'How are you?',
    senderId: 'user1Id',
    receiverId: 'user2Id',
    timeStamp: DateTime.parse("2022-10-31T16:59:32.905450Z"),
    isRead: false,
    attachmentUrl: '');

final tNewMessageModel2 = MessageModel(
    messageId: 'newMessageId2',
    conversationId: 'user1Id-user5Id',
    text: 'How are you?',
    senderId: 'user1Id',
    receiverId: 'user5Id',
    timeStamp: DateTime.parse("2022-10-31T16:59:32.905450Z"),
    isRead: false,
    attachmentUrl: '');

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
  lastMessageTime: DateTime.parse("2022-07-18T16:37:47.475845Z"),
  lastSenderId: 'user1Id',
  totalUnreadMessages: 0,
);

final tConversationModelNotUTC = ConversationModel(
    conversationId: 'user1Id-user2Id',
    friendId: 'user2Id',
    lastText: 'Hello',
    lastMessageTime: DateTime.parse("2022-07-18 23:37:47.475845"),
    lastSenderId: 'user1Id',
    totalUnreadMessages: 0);

final tUser = User(
    userId: 'user1Id',
    username: 'username',
    displayName: 'displayName',
    signUpTime: DateTime.parse("2022-07-18T16:37:47.475845Z"),
    isOnline: false,
    lastOnline: DateTime.parse("2022-08-18T16:37:47.475845Z"),
    about: 'Busy',
    photoUrl: 'http//:user.jpg');

final tUserModel = UserModel(
    userId: 'user1Id',
    username: 'username',
    displayName: 'displayName',
    signUpTime: DateTime.parse("2022-07-18T16:37:47.475845Z"),
    isOnline: false,
    lastOnline: DateTime.parse("2022-08-18T16:37:47.475845Z"),
    about: 'Busy',
    photoUrl: 'http//:user.jpg');
final tUserModelNotUTC = UserModel(
    userId: 'user1Id',
    username: 'username',
    displayName: 'displayName',
    signUpTime: DateTime.parse("2022-07-18 23:37:47.475845"),
    isOnline: false,
    lastOnline: DateTime.parse("2022-08-18 23:37:47.475845"),
    about: 'Busy',
    photoUrl: 'http//:user.jpg');
