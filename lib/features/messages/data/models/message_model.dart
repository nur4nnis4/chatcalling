import 'package:chatcalling/features/messages/domain/entities/message.dart';

class MessageModel extends Message {
  MessageModel({
    required String messageId,
    required String conversationId,
    required String text,
    required String senderId,
    required String receiverId,
    required DateTime timeStamp,
    required bool isRead,
    String attachmentUrl = '',
  }) : super(
            messageId: messageId,
            conversationId: conversationId,
            text: text,
            senderId: senderId,
            receiverId: receiverId,
            timeStamp: timeStamp,
            isRead: isRead,
            attachmentUrl: attachmentUrl);
  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        messageId: json['messageId'],
        conversationId: json['conversationId'],
        text: json['text'],
        senderId: json['senderId'],
        receiverId: json['receiverId'],
        timeStamp: DateTime.parse(json['timeStamp']),
        isRead: json['isRead'],
        attachmentUrl: json['attachmentUrl'],
      );

  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'conversationId': conversationId,
      'text': text,
      'senderId': senderId,
      'receiverId': receiverId,
      'timeStamp': timeStamp.isUtc
          ? timeStamp.toIso8601String()
          : timeStamp.toUtc().toIso8601String(),
      'isRead': isRead,
      'attachmentUrl': attachmentUrl
    };
  }
}
