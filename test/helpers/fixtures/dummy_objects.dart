import 'package:chatcalling/features/messages/data/models/conversation_model.dart';
import 'package:chatcalling/features/messages/data/models/message_model.dart';
import 'package:chatcalling/features/messages/domain/entities/conversation.dart';
import 'package:chatcalling/features/messages/domain/entities/message.dart';

final tMessage = Message(
    messageId: "messageQ3BMyS8o1LVSHYyWQFQf",
    conversationId: "conversationId",
    text: "Hello",
    senderId: "userG8HSGydbbds",
    receiverId: "userG8HSGydbbds",
    timeStamp: DateTime.parse("2022-07-18 16:37:47.475845Z"),
    isRead: false,
    attachmentUrl: "http://image1.jpg");

final tMessageModel = MessageModel(
    messageId: "messageQ3BMyS8o1LVSHYyWQFQf",
    conversationId: "conversationId",
    text: "Hello",
    senderId: "userG8HSGydbbds",
    receiverId: "userG8HSGydbbds",
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

final tConversation = Conversation(
    conversationId: 'conversation1',
    lastText: 'Hello',
    lastMessageTime: DateTime.now(),
    lastSenderId: 'user1',
    contactId: 'user2',
    totalUnreadMessages: 1);

final tConversationModel = ConversationModel(
    conversationId: 'conversationId',
    contactId: 'contactId',
    lastText: 'lastText',
    lastMessageTime: DateTime.parse("2022-07-18 16:37:47.475845Z"),
    lastSenderId: 'lastSenderId',
    totalUnreadMessages: 1);

final tConversationModelNotUTC = ConversationModel(
    conversationId: 'conversationId',
    contactId: 'contactId',
    lastText: 'lastText',
    lastMessageTime: DateTime.parse("2022-07-18 23:37:47.475845"),
    lastSenderId: 'lastSenderId',
    totalUnreadMessages: 1);
