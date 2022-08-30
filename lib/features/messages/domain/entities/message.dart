import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Message extends Equatable {
  final String messageId;
  final String text;
  final String senderId;
  final String receiverId;
  final DateTime timeStamp;
  String conversationId;
  bool isRead;
  String attachmentUrl;

  Message({
    required this.messageId,
    required this.text,
    required this.senderId,
    required this.receiverId,
    required this.timeStamp,
    required this.conversationId,
    required this.isRead,
    required this.attachmentUrl,
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
