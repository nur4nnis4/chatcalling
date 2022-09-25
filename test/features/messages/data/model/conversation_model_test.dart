import 'package:chatcalling/features/messages/data/models/conversation_model.dart';
import 'package:chatcalling/features/messages/domain/entities/conversation.dart';
import '../../../../helpers/fixtures/conversations_dummy.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/fixtures/message_dummy.dart';

void main() {
  test('ConversationModel should be a subclass of conversation entity ',
      () async {
    // Assert
    expect(tConversationModel, isA<Conversation>());
  });

  final String tUserId = 'user1Id';

  group('fromJson', () {
    test('should return a valid model', () async {
      // Act
      final actual =
          ConversationModel.fromJson(json: tConversationJson, userId: tUserId);

      //Assert
      expect(actual, tConversationModel);
    });
  });
  group('toJson', () {
    test("should retun JSON map containing proper data", () async {
      // Act
      final actual =
          tConversationModel.toJson(userId: tUserId, friendTotalUnread: 1);

      // Assert
      expect(actual, tConversationJson);
    });
  });

  group('fromMessage', () {
    test('should return a valid model', () async {
      // Act
      final actual = ConversationModel.fromMessage(message: tMessageModel);

      //Assert
      expect(actual, tConversationModel);
    });
  });
}
