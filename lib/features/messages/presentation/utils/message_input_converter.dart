import 'package:chatcalling/core/helpers/time.dart';
import 'package:chatcalling/core/helpers/unique_id.dart';
import 'package:chatcalling/features/messages/domain/entities/message.dart';

class MessageInputConverter {
  final UniqueId uniqueId;
  final Time time;

  MessageInputConverter({required this.uniqueId, required this.time});

  Message toMessage(
      String text, String userId, String receiverId, String attachmentPath) {
    return Message(
        messageId: uniqueId.random(),
        senderId: userId,
        receiverId: receiverId,
        text: text,
        timeStamp: time.now(),
        attachmentUrl: attachmentPath,
        isRead: false,
        conversationId: uniqueId.concat(userId, receiverId));
  }
}
