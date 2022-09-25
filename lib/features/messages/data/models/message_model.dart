import 'package:chatcalling/features/messages/domain/entities/message.dart';

// ignore: must_be_immutable
class MessageModel extends Message {
  MessageModel({
    required String messageId,
    required String conversationId,
    required String text,
    required String senderId,
    required String receiverId,
    required DateTime timeStamp,
    required bool isRead,
    required String attachmentUrl,
  }) : super(
            messageId: messageId,
            conversationId: conversationId,
            text: text,
            senderId: senderId,
            receiverId: receiverId,
            timeStamp: timeStamp,
            isRead: isRead,
            attachmentUrl: attachmentUrl);
  factory MessageModel.fromJson(Map<String, dynamic>? json) => MessageModel(
        messageId: json?['messageId'],
        conversationId: json?['conversationId'],
        text: json?['text'],
        senderId: json?['senderId'],
        receiverId: json?['receiverId'],
        timeStamp: DateTime.parse(json?['timeStamp']).toLocal(),
        isRead: json?['isRead'],
        attachmentUrl: json?['attachmentUrl'],
      );

  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'conversationId': conversationId,
      'text': text,
      'senderId': senderId,
      'receiverId': receiverId,
      'timeStamp': timeStamp.toUtc().toIso8601String(),
      'isRead': isRead,
      'attachmentUrl': attachmentUrl
    };
  }

  factory MessageModel.fromEntity(Message message) {
    return MessageModel(
        messageId: message.messageId,
        conversationId: message.conversationId,
        text: message.text,
        senderId: message.senderId,
        receiverId: message.receiverId,
        timeStamp: message.timeStamp,
        isRead: message.isRead,
        attachmentUrl: message.attachmentUrl);
  }

  Message toEntity(MessageModel message) {
    return Message(
        messageId: message.messageId,
        conversationId: message.conversationId,
        text: message.text,
        senderId: message.senderId,
        receiverId: message.receiverId,
        timeStamp: message.timeStamp,
        isRead: message.isRead,
        attachmentUrl: message.attachmentUrl);
  }
}
