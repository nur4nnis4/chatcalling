import 'dart:convert';

import 'package:chatcalling/core/error/failures.dart';
import 'package:chatcalling/features/messages/data/datasources/message_remote_datasource.dart';
import 'package:chatcalling/features/messages/data/models/conversation_model.dart';
import 'package:chatcalling/features/messages/data/models/message_model.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/fixtures/dummy_objects.dart';
import '../../../../helpers/fixtures/fixture_reader/fixture_reader.dart';

void main() {
  late FakeFirebaseFirestore instance;
  late MessageRemoteDatasourceImpl dataSource;

  final String tUserId = 'user1Id';
  final tConversationId = 'user1Id-user2Id';

  setUp(() {
    instance = FakeFirebaseFirestore();
    dataSource = MessageRemoteDatasourceImpl(instance);

    jsonDecode(fixture('conversation_list.json')).forEach((element) {
      instance
          .collection('conversations')
          .doc(element['conversationId'])
          .set(element);
    });

    jsonDecode(fixture('message_list.json')).forEach((element) {
      instance
          .collection('conversations')
          .doc(tConversationId)
          .collection('messages')
          .doc(element['messageId'])
          .set(element);
    });
  });

  group('getMessages', () {
    test(
        'Should returns Stream containing List of MessageModel objects ordered by timeStamp',
        () async {
      // Arrange
      final snapshot = instance
          .collection('conversations')
          .doc(tMessageModel.conversationId)
          .collection('messages')
          .orderBy('timeStamp', descending: true)
          .snapshots();

      Stream<Either<Failure, List<MessageModel>>> expectedMessageListStream =
          snapshot.map((snapshot) => Right(snapshot.docs
              .map((doc) => MessageModel.fromJson(doc.data()))
              .toList()));

      final expectedMessageList = await expectedMessageListStream.first
          .then((value) => value.getOrElse(() => []));

      // Act
      final actualMessageList = await dataSource
          .getMessages(tMessageModel.conversationId)
          .first
          .then((value) => value.getOrElse(() => []));

      // Assert
      expect(actualMessageList, expectedMessageList);
    });
  });

  group('getConversation', () {
    test(
        'Should returns stream containing List of ConversationModel objects ordered by lastMessageTime',
        () async {
      // Arrange
      final snapshot = instance
          .collection('conversations')
          .where('members.$tUserId', isNotEqualTo: Null)
          .orderBy('lastMessageTime', descending: true)
          .snapshots();

      Stream<Either<Failure, List<ConversationModel>>>
          expectedConversationListStream =
          snapshot.map((snapshot) => Right(snapshot.docs
              .map((doc) =>
                  ConversationModel.fromJson(json: doc.data(), userId: tUserId))
              .toList()));

      final expectedConversationList = await expectedConversationListStream
          .first
          .then((value) => value.getOrElse(() => []));

      // Act
      final actualConversationList = await dataSource
          .getConversations(tUserId)
          .first
          .then((value) => value.getOrElse(() => []));

      // Assert
      expect(actualConversationList, expectedConversationList);
    });
  });

  group('SendMessage', () {
    test(
        'Should add new conversation in database if no conversation between the sender and the receiver exists',
        () async {
      // Act
      await dataSource.sendMessage(tNewMessageModel2);

      final actualConversationMap = await instance
          .collection('conversations')
          .doc(tNewMessageModel2.conversationId)
          .get()
          .then((value) => value.data());

      final expectedConversationMap =
          ConversationModel.fromMessage(message: tNewMessageModel2)
              .toJson(userId: tUserId, friendTotalUnread: 1);
      // Assert
      expect(actualConversationMap, expectedConversationMap);
    });

    test('Should update conversation in database if conversation exists',
        () async {
      // Act
      await dataSource.sendMessage(tNewMessageModel);

      final actualConversationMap = await instance
          .collection('conversations')
          .doc(tNewMessageModel.conversationId)
          .get()
          .then((value) => value.data());
      final expectedConversationMap =
          ConversationModel.fromMessage(message: tNewMessageModel)
              .toJson(userId: tUserId, friendTotalUnread: 5);
      // Assert
      expect(actualConversationMap, expectedConversationMap);
    });

    test('Should add new message to database', () async {
      // Act
      await dataSource.sendMessage(tNewMessageModel);

      final actualMessage = await instance
          .collection('conversations')
          .doc(tNewMessageModel.conversationId)
          .collection('messages')
          .doc(tNewMessageModel.messageId)
          .get()
          .then((value) => MessageModel.fromJson(value.data()));

      // Assert
      expect(actualMessage, tNewMessageModel);
    });
  });
  group('updateReadStatus', () {
    test(
        'Should update read status of all unread messages received by current user to true',
        () async {
      // Act
      await dataSource.updateReadStatus(tUserId, tConversationId);

      final allMessageReadStatusAreTrue = await instance
          .collection('conversations')
          .doc(tConversationId)
          .collection('messages')
          .where('receiverId', isEqualTo: tUserId)
          .where('isRead', isEqualTo: false)
          .get()
          .then((value) => value.docs.isEmpty);

      // Assert
      expect(allMessageReadStatusAreTrue, true);
    });

    test('Should update totalUnread of current user to 0', () async {
      // Act
      await dataSource.updateReadStatus(tUserId, tConversationId);
      final int actualUserTotalUnread = await instance
          .collection('conversations')
          .doc(tConversationId)
          .get()
          .then((value) => value.get('members.$tUserId.totalUnread'));
      // Assert
      expect(actualUserTotalUnread, 0);
    });
  });
}
