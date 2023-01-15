import 'dart:io';

import 'package:chatcalling/core/common_features/user/data/models/user_model.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/common_features/attachment/data/models/attachment_model.dart';
import '../../../../core/helpers/check_platform.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../models/conversation_model.dart';
import '../models/message_model.dart';

abstract class MessageRemoteDatasource {
  Future<void> sendMessage(MessageModel message);
  Stream<List<ConversationModel>> getConversations(String userId);
  Stream<List<MessageModel>> getMessages(String conversationId);
  Future<void> updateReadStatus(String userId, String conversationId);
}

class MessageRemoteDatasourceImpl implements MessageRemoteDatasource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  final CheckPlatform checkPlatform;

  MessageRemoteDatasourceImpl({
    required this.firebaseFirestore,
    required this.firebaseStorage,
    required this.checkPlatform,
  });

  @override
  Stream<List<MessageModel>> getMessages(String conversationId) async* {
    yield* firebaseFirestore
        .collection('conversations')
        .doc(conversationId)
        .collection('messages')
        .orderBy('timeStamp', descending: true)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs
            .map((doc) => MessageModel.fromJson(doc.data()))
            .toList();
      } else
        return [];
    });
  }

  @override
  Stream<List<ConversationModel>> getConversations(String userId) async* {
    final conversationRef = firebaseFirestore.collection('conversations');

    yield* conversationRef
        .where('members', arrayContains: userId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .flatMap((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return Rx.combineLatestList(snapshot.docs.map((doc) {
          final String friendId =
              doc.data()['member_details'][userId]['friendId'] as String;
          final String conversationId = doc.data()['conversationId'] as String;
          final String lastMessageId = doc.data()['lastMessageId'] as String;
          final int totalUnreadMessages =
              doc.data()['member_details'][userId]['totalUnread'];

          final friendUserStream = firebaseFirestore
              .collection('users')
              .doc(friendId)
              .snapshots()
              .map((event) => event.data());

          final lastMessageStream = conversationRef
              .doc(conversationId)
              .collection('messages')
              .doc(lastMessageId)
              .snapshots()
              .map((event) => event.data());

          return Rx.combineLatest2(friendUserStream, lastMessageStream,
              (Map<String, dynamic>? friendUser,
                  Map<String, dynamic>? message) {
            return ConversationModel(
                conversationId: conversationId,
                lastMessage: MessageModel.fromJson(message),
                friendUser: UserModel.fromJson(friendUser),
                totalUnreadMessages: totalUnreadMessages);
          });
        }).toList());
      } else {
        return Stream.value([]);
      }
    });
  }

  @override
  Future<void> updateReadStatus(String userId, String conversationId) async {
    final conversationDocRef =
        firebaseFirestore.collection('conversations').doc(conversationId);

    final unreadMessagesSnapshots = await conversationDocRef
        .collection('messages')
        .where('receiverId', isEqualTo: userId)
        .where('isRead', isEqualTo: false)
        .get();

    if (unreadMessagesSnapshots.docs.isNotEmpty) {
      unreadMessagesSnapshots.docs.forEach((element) {
        conversationDocRef
            .collection('messages')
            .doc(element.id)
            .update({'isRead': true});
      });
      conversationDocRef.update({'member_details.$userId.totalUnread': 0});
    }
  }

  @override
  Future<void> sendMessage(MessageModel message) async {
    await addMessage(message);
    await updateOrAddConversation(message);
  }

  Future<void> updateOrAddConversation(MessageModel message) async {
    final conversationDocRef = firebaseFirestore
        .collection('conversations')
        .doc(message.conversationId);
    return firebaseFirestore.runTransaction((transaction) async {
      final conversationSnapshot = await transaction.get(conversationDocRef);
      if (conversationSnapshot.exists) {
        final int receiverTotalUnread = conversationSnapshot
                .get('member_details.${message.receiverId}.totalUnread') +
            1;
        transaction.update(
            conversationDocRef,
            message.toConversationJson(
                receiverTotalUnread: receiverTotalUnread));
      } else {
        transaction.set(
          conversationDocRef,
          message.toConversationJson(receiverTotalUnread: 1),
        );
      }
    });
  }

  Future<void> addMessage(MessageModel message) async {
    if (message.attachments.length > 0) {
      final attachments = await uploadAttachments(message);
      message.attachments = attachments;
    }
    return firebaseFirestore
        .collection('conversations')
        .doc(message.conversationId)
        .collection('messages')
        .doc(message.messageId)
        .set(message.toJson());
  }

  Future<List<AttachmentModel>> uploadAttachments(MessageModel message) async {
    List<AttachmentModel> attachments = [];
    for (int i = 0; i < message.attachments.length; i++) {
      final storageRef = firebaseStorage.ref().child("messages").child(
          "/${message.messageId}-$i.${message.attachments[i].contentType.split('/').last}");
      final UploadTask uploadTask;
      if (checkPlatform.isWeb()) {
        uploadTask = storageRef
            .putData(await XFile(message.attachments[i].url).readAsBytes());
      } else {
        uploadTask = storageRef.putFile(File(message.attachments[i].url));
      }
      final downloadUrl =
          await uploadTask.then((_) => storageRef.getDownloadURL());
      attachments.add(AttachmentModel(
          url: downloadUrl, contentType: message.attachments[i].contentType));
    }
    return attachments;
  }
}
