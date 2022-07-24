import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/conversation_model.dart';
import '../models/message_model.dart';

abstract class MessageRemoteDatasource {
  Future<List<MessageModel>> getMessages(String conversationId);
  Future<void> sendMessage(MessageModel message);
  Future<List<ConversationModel>> getConversations(String userId);
}

class MessageRemoteDatasourceImpl implements MessageRemoteDatasource {
  final FirebaseFirestore firebaseFirestore;

  MessageRemoteDatasourceImpl(this.firebaseFirestore);

  @override
  Future<List<ConversationModel>> getConversations(String userId) async {
    // TODO: implement getConversation

    throw UnimplementedError();
  }

  CollectionReference<Map<String, dynamic>> _messageCollectionReference(
          String conversationId) =>
      firebaseFirestore
          .collection('messages')
          .doc(conversationId)
          .collection('messages');

  @override
  Future<List<MessageModel>> getMessages(String conversationId) async {
    List<MessageModel> messageList = [];
    await _messageCollectionReference(conversationId)
        .get()
        .then((snapshot) => snapshot.docs.forEach((element) {
              messageList.insert(0, MessageModel.fromJson(element.data()));
            }));
    return [];
  }

  @override
  Future<void> sendMessage(MessageModel message) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }
}
