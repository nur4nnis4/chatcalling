import 'package:chatcalling/features/messages/presentation/utils/message_input_converter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/fixtures/message_dummy.dart';
import '../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockUniqueId mockUniqueId;
  late MockTime mockTime;

  late MessageInputConverter converter;

  setUp(() {
    mockUniqueId = MockUniqueId();
    mockTime = MockTime();
    converter = MessageInputConverter(uniqueId: mockUniqueId, time: mockTime);
  });

  group('toMessage', () {
    test('should return a message object', () {
      // Arrange
      when(mockUniqueId.random()).thenReturn(tMessage.messageId);
      when(mockUniqueId.concat(any, any)).thenReturn(tMessage.conversationId);
      when(mockTime.now()).thenReturn(tMessage.timeStamp);
      // Act
      final actual = converter.toMessage(
          text: tMessage.text,
          userId: tMessage.senderId,
          receiverId: tMessage.receiverId,
          attachments: tMessage.attachments);
      // Assert
      expect(actual, tMessage);

      verify(mockUniqueId.random()).called(1);
      verify(mockUniqueId.concat(tMessage.senderId, tMessage.receiverId))
          .called(1);
      verify(mockTime.now()).called(1);
    });
  });
}
