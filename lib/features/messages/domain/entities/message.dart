import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String messageId;
  final String conversationId;
  final String text;
  final String senderId;
  final String receiverId;
  final DateTime timeStamp;
  final bool isRead;
  final String attachmentUrl;

  Message({
    required this.messageId,
    required this.conversationId,
    required this.text,
    required this.senderId,
    required this.receiverId,
    required this.timeStamp,
    required this.isRead,
    this.attachmentUrl = '',
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
        attachmentUrl,
      ];
}
