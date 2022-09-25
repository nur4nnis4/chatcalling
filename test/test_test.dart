import 'package:chatcalling/features/messages/data/models/message_model.dart';

void main() {}
//  TODO : FIX THIS !!!
final Map<DateTime, List<MessageModel>> ExpectedGroupedMessageList = {
  DateTime.parse("2022-07-27T16:37:47.475845"): [
    MessageModel.fromJson({
      "messageId": "message4Id",
      "conversationId": "user1Id-user2Id",
      "text": "Hello",
      "senderId": "user2Id",
      "receiverId": "user1Id",
      "timeStamp": "2022-07-27T16:37:47.475845Z",
      "isRead": false,
      "attachmentUrl": "http://image1.jpg"
    })
  ],
};
