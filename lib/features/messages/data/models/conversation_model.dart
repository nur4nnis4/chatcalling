import 'package:chatcalling/features/messages/domain/entities/conversation.dart';

class ConversationModel extends Conversation {
  ConversationModel(
      {required String conversationId,
      required String contactId,
      required String lastText,
      required DateTime lastMessageTime,
      required String lastSenderId,
      required int totalUnreadMessages})
      : super(
            conversationId: conversationId,
            contactId: contactId,
            lastText: lastText,
            lastMessageTime: lastMessageTime,
            lastSenderId: lastSenderId,
            totalUnreadMessages: totalUnreadMessages);
  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      ConversationModel(
        conversationId: json['conversationId'],
        contactId: json['contactId'],
        lastText: json['lastText'],
        lastMessageTime: DateTime.parse(json['lastMessageTime']),
        lastSenderId: json['lastSenderId'],
        totalUnreadMessages: json['totalUnreadMessages'],
      );

  Map<String, dynamic> toJson() {
    return {
      'conversationId': conversationId,
      'contactId': contactId,
      'lastText': lastText,
      'lastMessageTime': lastMessageTime.isUtc
          ? lastMessageTime.toIso8601String()
          : lastMessageTime.toUtc().toIso8601String(),
      'lastSenderId': lastSenderId,
      'totalUnreadMessages': totalUnreadMessages
    };
  }
}
