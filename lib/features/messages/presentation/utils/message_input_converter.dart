import '../../../../core/helpers/time.dart';
import '../../../../core/helpers/unique_id.dart';
import '../../../../core/common_features/attachment/domain/entities/attachment.dart';
import '../../domain/entities/message.dart';

class MessageInputConverter {
  final UniqueId uniqueId;
  final Time time;

  MessageInputConverter({required this.uniqueId, required this.time});

  Message toMessage(
      {required String text,
      required String userId,
      required String receiverId,
      required List<Attachment> attachments}) {
    return Message(
        messageId: uniqueId.random(),
        senderId: userId,
        receiverId: receiverId,
        text: text,
        timeStamp: time.now(),
        attachments: attachments,
        isRead: false,
        conversationId: uniqueId.concat(userId, receiverId));
  }
}
