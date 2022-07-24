import '../models/conversation_model.dart';
import '../models/message_model.dart';

abstract class MessageLocalDatasource {
  Future<List<MessageModel>> getMessages();
  Future<void> cacheMessages(List<MessageModel> messagesToCache);
  Future<List<ConversationModel>> getConversations();
  Future<void> cacheConversations(List<ConversationModel> conversationsToCache);
}
