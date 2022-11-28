import 'package:chatcalling/features/messages/domain/entities/conversation.dart';
import '../../../../helpers/fixtures/conversations_dummy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ConversationModel should be a subclass of conversation entity ',
      () async {
    // Assert
    expect(tConversationModel, isA<Conversation>());
  });
}
