import 'package:chatcalling/features/messages/domain/entities/message.dart';
import 'package:chatcalling/features/messages/domain/usecases/get_messages.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/fixtures/dummy_objects.dart' as FakeObject;
import '../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockMessageRepository mockMessageRepository;
  late GetMessages usecase;

  setUp(() {
    mockMessageRepository = MockMessageRepository();
    usecase = GetMessages(mockMessageRepository);
  });

  const String tConversationId = 'conversation1';
  final List<Message> tMessageList = [FakeObject.tMessage];

  test('Should get messages from the repository', () async {
    // Arrange
    when(mockMessageRepository.getMessages(any)).thenAnswer((_) async* {
      yield Right(tMessageList);
    });
    // Act
    final actual = await usecase(conversationId: tConversationId).first;
    //Assert
    expect(actual, Right(tMessageList));
    verify(mockMessageRepository.getMessages(tConversationId));
    verifyNoMoreInteractions(mockMessageRepository);
  });
}
