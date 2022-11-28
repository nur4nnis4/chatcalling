import '../../../../core/common_features/attachment/data/models/attachment_model.dart';
import '../../../../core/common_features/attachment/domain/entities/attachment.dart';
import '../../domain/entities/message.dart';

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
    required List<Attachment> attachments,
  }) : super(
            messageId: messageId,
            conversationId: conversationId,
            text: text,
            senderId: senderId,
            receiverId: receiverId,
            timeStamp: timeStamp,
            isRead: isRead,
            attachments: attachments);
  factory MessageModel.fromJson(Map<String, dynamic>? json) {
    final List<dynamic> attachmentListJson = json?['attachments'];
    return MessageModel(
      messageId: json?['messageId'],
      conversationId: json?['conversationId'],
      text: json?['text'],
      senderId: json?['senderId'],
      receiverId: json?['receiverId'],
      timeStamp: DateTime.parse(json?['timeStamp']).toLocal(),
      isRead: json?['isRead'],
      attachments: attachmentListJson.length > 0
          ? attachmentListJson
              .map((attachment) => AttachmentModel.fromJson(json: attachment))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'conversationId': conversationId,
      'text': text,
      'senderId': senderId,
      'receiverId': receiverId,
      'timeStamp': timeStamp.toUtc().toIso8601String(),
      'isRead': isRead,
      'attachments': attachments.length > 0
          ? attachments
              .map((e) => AttachmentModel.fromEntity(attachment: e).toJson())
              .toList()
          : []
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
        attachments: message.attachments
            .map((e) => AttachmentModel.fromEntity(attachment: e))
            .toList());
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
        attachments: message.attachments);
  }

  Map<String, dynamic> toConversationJson({int? receiverTotalUnread}) {
    return {
      "conversationId": conversationId,
      "lastMessageId": messageId,
      "lastMessageTime": timeStamp.toUtc().toIso8601String(),
      "members": [senderId, receiverId],
      "member_details": {
        senderId: {"totalUnread": 0, "friendId": receiverId},
        receiverId: {
          "totalUnread": receiverTotalUnread ?? 0,
          "friendId": senderId
        }
      }
    };
  }
}
