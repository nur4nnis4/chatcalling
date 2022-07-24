import 'dart:convert';

import 'package:chatcalling/features/messages/data/datasources/message_remote_datasource.dart';
import 'package:chatcalling/features/messages/data/models/message_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/fixtures/dummy_objects.dart';
import '../../../../helpers/fixtures/fixture_reader/fixture_reader.dart';

void main() {
  late FakeFirebaseFirestore instance;
  late MessageRemoteDatasourceImpl dataSource;

  setUp(() {
    instance = FakeFirebaseFirestore();
    dataSource = MessageRemoteDatasourceImpl(instance);
  });

  group('getMessages', () {
    final List<MessageModel> messageList = [];
    final messageJson = jsonDecode(fixture('message.json'));
    test('Should get data from given collection', () async {
      // Arrange
      instance
          .collection('messages')
          .doc(tMessageModel.conversationId)
          .collection('messages')
          .doc(tMessageModel.messageId)
          .set(tMessageModel.toJson());
      instance
          .collection('messages')
          .doc(tMessageModel.conversationId)
          .collection('messages')
          .doc('2')
          .set(tMessageModel.toJson());
      final snapshot = instance
          .collection('messages')
          .doc(tMessageModel.conversationId)
          .collection('messages')
          .snapshots();

      // snapshot.first.then((snapshot) => snapshot.docs.forEach((element) {
      //       print(element.data());
      //       print(snapshot.docs.length);
      //     }));

      Stream<List<MessageModel>> messageListStream = snapshot.map((snapshot) =>
          snapshot.docs
              .map((doc) => MessageModel.fromJson(doc.data()))
              .toList());

      messageListStream.first.then((messages) => messages.forEach((element) {
            print(element);
          }));

      // Act
      final result = await dataSource.getMessages(tMessageModel.conversationId);
      // Assert
    });
  });
}
