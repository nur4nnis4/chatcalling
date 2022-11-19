import '../../../../core/common_features/attachment/domain/entities/attachment.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Message extends Equatable {
  final String messageId;
  final String text;
  final String senderId;
  final String receiverId;
  final DateTime timeStamp;
  final String conversationId;
  final bool isRead;
  List<Attachment> attachments;

  Message({
    required this.messageId,
    required this.text,
    required this.senderId,
    required this.receiverId,
    required this.timeStamp,
    required this.conversationId,
    required this.isRead,
    required this.attachments,
  });

  @override
  List<Object?> get props => [
        messageId,
        conversationId,
        text,
        senderId,
        receiverId,
        timeStamp,
        isRead,
        attachments,
      ];
}

enum MessageSentStatus {
  sent,
  failed,
  sending,
}
