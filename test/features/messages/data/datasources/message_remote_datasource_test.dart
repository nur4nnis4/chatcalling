import 'package:chatcalling/features/messages/data/datasources/message_remote_datasource.dart';
import 'package:chatcalling/features/messages/data/models/message_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/fixtures/conversations_dummy.dart';
import '../../../../helpers/fixtures/message_dummy.dart';
import '../../../../helpers/fixtures/user_dummy.dart';
import '../../../../helpers/mocks/test.mocks.dart';

void main() {
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late MockFirebaseStorage mockFirebaseStorage;
  late MessageRemoteDatasourceImpl dataSource;
  late MockCheckPlatform mockCheckPlatform;

  final String tUserId = 'user1Id';
  final tConversationId = 'user1Id-user2Id';

  setUp(() {
    fakeFirebaseFirestore = FakeFirebaseFirestore();
    mockFirebaseStorage = MockFirebaseStorage();
    mockCheckPlatform = MockCheckPlatform();
    dataSource = MessageRemoteDatasourceImpl(
        firebaseFirestore: fakeFirebaseFirestore,
        firebaseStorage: mockFirebaseStorage,
        checkPlatform: mockCheckPlatform);

    tConversationListJson.forEach((element) {
      fakeFirebaseFirestore
          .collection('conversations')
          .doc(element['conversationId'])
          .set(element);
    });

    tMessageListJson.forEach((element) {
      fakeFirebaseFirestore
          .collection('conversations')
          .doc(tConversationId)
          .collection('messages')
          .doc(element['messageId'])
          .set(element);
    });

    tUserModelList.forEach((userModel) {
      fakeFirebaseFirestore
          .collection('users')
          .doc(userModel.userId)
          .set(userModel.toJson());
    });
  });

  group('getMessages', () {
    test(
        'Should returns Stream containing List of MessageModel objects ordered by timeStamp',
        () async {
      // Act
      final actualMessageList =
          dataSource.getMessages(tMessageModel.conversationId);

      // Assert
      expect(actualMessageList, emits(tExpectedDescendingMessageList));
    });
  });

  group('getConversation', () {
    test(
        'Should returns stream containing List of ConversationModel objects ordered by lastMessageTime',
        () async {
      // Act
      final actualConversationList = dataSource.getConversations(tUserId);

      // Assert
      expect(actualConversationList, emits(tExpectedConversationList));
    });
  });

  group('SendMessage', () {
    test(
        'Should add new conversation in database if no conversation between the sender and the receiver exists',
        () async {
      // Act
      await dataSource.sendMessage(tNewMessageModel2);

      final actualConversationMap = await fakeFirebaseFirestore
          .collection('conversations')
          .doc(tNewMessageModel2.conversationId)
          .get()
          .then((value) => value.data());

      final expectedConversationMap =
          tNewMessageModel2.toConversationJson(receiverTotalUnread: 1);
      // MessageModel
      // ConversationModel.fromMessage(message: tNewMessageModel2)
      //     .toJson(userId: tUserId, friendTotalUnread: 1);
      // Assert
      expect(actualConversationMap, expectedConversationMap);
    });

    test('Should update conversation in database if conversation exists',
        () async {
      // Act
      await dataSource.sendMessage(tNewMessageModel);

      final actualConversationMap = await fakeFirebaseFirestore
          .collection('conversations')
          .doc(tNewMessageModel.conversationId)
          .get()
          .then((value) => value.data());
      final expectedConversationMap =
          tNewMessageModel.toConversationJson(receiverTotalUnread: 2);
      // ConversationModel.fromMessage(message: tNewMessageModel)
      //     .toJson(userId: tUserId, friendTotalUnread: 5);
      // Assert
      expect(actualConversationMap, expectedConversationMap);
    });

    test('Should upload attachments to database if exist', () async {
      // Arrange
      when(mockCheckPlatform.isWeb()).thenReturn(true);
      // Act
      await dataSource.sendMessage(tNewMessageWithAttachment);
      final actualMessage = await fakeFirebaseFirestore
          .collection('conversations')
          .doc(tNewMessageModel.conversationId)
          .collection('messages')
          .doc(tNewMessageModel.messageId)
          .get()
          .then((value) => MessageModel.fromJson(value.data()));
      // Assert
      expect(actualMessage, tExpectedMessageWithAttachment);
    });

    test('Should add new message to database', () async {
      // Act
      await dataSource.sendMessage(tNewMessageModel);

      final actualMessage = await fakeFirebaseFirestore
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

      final allMessageReadStatusAreTrue = await fakeFirebaseFirestore
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
      final int actualUserTotalUnread = await fakeFirebaseFirestore
          .collection('conversations')
          .doc(tConversationId)
          .get()
          .then((value) => value.get('member_details.$tUserId.totalUnread'));
      // Assert
      expect(actualUserTotalUnread, 0);
    });
  });
}
