import 'dart:convert';

import 'package:chatcalling/features/messages/data/models/conversation_model.dart';
import 'package:chatcalling/features/messages/domain/entities/conversation.dart';
import '../../../../helpers/fixtures/dummy_objects.dart' as FakeObject;
import '../../../../helpers/fixtures/fixture_reader/fixture_reader.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ConversationModel should be a subclass of conversation entity ',
      () async {
    // Assert
    expect(FakeObject.tConversationModel, isA<Conversation>());
  });

  final tConversationJson = jsonDecode(fixture("conversation.json"));

  group('fromJson', () {
    test('should return a valid model', () async {
      // Act
      final result = ConversationModel.fromJson(tConversationJson);

      //Assert
      expect(result, FakeObject.tConversationModel);
    });
  });
  group('toJson', () {
    test(
        "should retun JSON map containing proper data when FakeObject.tConversationModel.lastMessageTime is UTC",
        () async {
      // Act
      final result = FakeObject.tConversationModel.toJson();

      // Assert
      expect(result, tConversationJson);
    });

    test(
        "should retun JSON map containing proper data when FakeObject.tConversationModel.lastMessageTime is not UTC",
        () async {
      // Act
      final result = FakeObject.tConversationModelNotUTC.toJson();

      // Assert
      expect(result, tConversationJson);
    });
  });
}
