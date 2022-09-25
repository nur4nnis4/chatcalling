import 'package:chatcalling/core/error/exceptions.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../models/conversation_model.dart';
import '../models/message_model.dart';

abstract class MessageRemoteDatasource {
  Future<Either<Failure, String>> sendMessage(MessageModel message);
  Stream<Either<Failure, List<ConversationModel>>> getConversations(
      String userId);
  Stream<Either<Failure, List<MessageModel>>> getMessages(
      String conversationId);
  Future<Either<Failure, String>> updateReadStatus(
      String userId, String conversationId);
}

class MessageRemoteDatasourceImpl implements MessageRemoteDatasource {
  final FirebaseFirestore firestore;

  MessageRemoteDatasourceImpl(this.firestore);

  @override
  Stream<Either<Failure, List<MessageModel>>> getMessages(
      String conversationId) async* {
    try {
      yield* firestore
          .collection('conversations')
          .doc(conversationId)
          .collection('messages')
          .orderBy('timeStamp', descending: true)
          .snapshots()
          .map((snapshot) => Right(snapshot.docs
              .map((doc) => MessageModel.fromJson(doc.data()))
              .toList()));
    } on PlatformException catch (e) {
      yield Left(PlatformFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<ConversationModel>>> getConversations(
      String userId) async* {
    try {
      yield* firestore
          .collection('conversations')
          .where('members', arrayContains: userId)
          .orderBy('lastMessageTime', descending: true)
          .snapshots()
          .map((snapshot) => Right(snapshot.docs
              .map((doc) =>
                  ConversationModel.fromJson(json: doc.data(), userId: userId))
              .toList()));
    } on PlatformException catch (e) {
      yield Left(PlatformFailure("Platform Failure" + e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> updateReadStatus(
      String userId, String conversationId) async {
    final conversationDocRef =
        firestore.collection('conversations').doc(conversationId);

    try {
      final unreadMessagesSnapshots = await conversationDocRef
          .collection('messages')
          .where('receiverId', isEqualTo: userId)
          .where('isRead', isEqualTo: false)
          .get();
      unreadMessagesSnapshots.docs.forEach((element) {
        conversationDocRef
            .collection('messages')
            .doc(element.id)
            .update({'isRead': true});
      });
      conversationDocRef.update({'member_details.$userId.totalUnread': 0});
    } on PlatformException catch (e) {
      return Left(PlatformFailure(e.toString()));
    }
    return Right('Message read status has been updated');
  }

  @override
  Future<Either<Failure, String>> sendMessage(MessageModel message) async {
    try {
      await updateOrAddConversation(
              ConversationModel.fromMessage(message: message))
          .then((_) async => await addMessage(message));
    } on PlatformException catch (e) {
      return Left(PlatformFailure(e.toString()));
    }

    return Right('Message has been sent');
  }

  Future<void> updateOrAddConversation(ConversationModel conversation) async {
    final conversationDocRef =
        firestore.collection('conversations').doc(conversation.conversationId);
    return firestore.runTransaction((transaction) async {
      final conversationSnapshot = await transaction.get(conversationDocRef);
      if (conversationSnapshot.exists) {
        final int friendTotalUnread = conversationSnapshot
                .get('member_details.${conversation.friendId}.totalUnread') +
            1;
        transaction.update(
            conversationDocRef,
            conversation.toJson(
                userId: conversation.lastSenderId,
                friendTotalUnread: friendTotalUnread));
      } else {
        transaction.set(conversationDocRef,
            conversation.toJson(userId: conversation.lastSenderId));
      }
    });
  }

  Future<void> addMessage(MessageModel message) async {
    return firestore
        .collection('conversations')
        .doc(message.conversationId)
        .collection('messages')
        .doc(message.messageId)
        .set(message.toJson());
  }
}
