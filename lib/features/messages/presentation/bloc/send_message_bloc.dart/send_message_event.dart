part of 'send_message_bloc.dart';

class SendMessageEvent extends Equatable {
  final String text;
  final String receiverId;
  final List<Attachment> attachments;

  SendMessageEvent(
      {required this.text,
      required this.receiverId,
      required this.attachments});

  @override
  List<Object> get props => [text, receiverId, attachments];
}
