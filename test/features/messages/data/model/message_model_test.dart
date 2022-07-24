import 'dart:convert';

import 'package:chatcalling/features/messages/data/models/message_model.dart';
import 'package:chatcalling/features/messages/domain/entities/message.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/fixtures/dummy_objects.dart' as FakeObject;
import '../../../../helpers/fixtures/fixture_reader/fixture_reader.dart';

void main() {
  test('MessageModel should be a subclass of message entity ', () async {
    // Assert
    expect(FakeObject.tMessageModel, isA<Message>());
  });

  final tMessageJson = jsonDecode(fixture("message.json"));
  group('fromJson', () {
    test('Should return a valid model', () async {
      // Act
      final result = MessageModel.fromJson(tMessageJson);

      //Assert
      expect(result, FakeObject.tMessageModel);
    });
  });

  group('toJson', () {
    test(
        'Should retun JSON map containing proper data when FakeObject.tMessageModel.timeStamp is UTC',
        () async {
      // Act
      final result = FakeObject.tMessageModel.toJson();

      // Assert
      expect(result, tMessageJson);
    });
    test(
        'Should retun JSON map containing proper data when FakeObject.tMessageModel.timeStamp is not UTC',
        () async {
      // Act
      final result = FakeObject.tMessageModelNotUTC.toJson();

      // Assert
      expect(result, tMessageJson);
    });
  });
}
