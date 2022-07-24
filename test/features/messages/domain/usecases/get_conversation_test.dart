import 'package:chatcalling/features/messages/domain/entities/conversation.dart';
import 'package:chatcalling/features/messages/domain/usecases/get_conversation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/fixtures/dummy_objects.dart' as FakeObject;
import '../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockMessageRepository mockMessageRepository;
  late GetConversation usecase;

  setUp(() {
    mockMessageRepository = MockMessageRepository();
    usecase = GetConversation(mockMessageRepository);
  });

  const String tUserId = 'user1';
  List<Conversation> tConversationList = [FakeObject.tConversation];

  test('Should get conversations from the repository', () async {
    // Arrange
    when(mockMessageRepository.getConversations(any))
        .thenAnswer((_) async => Right(tConversationList));
    // Act
    final result = await usecase(userId: tUserId);
    //Assert
    expect(result, equals(Right(tConversationList)));
    verify(mockMessageRepository.getConversations(tUserId));
    verifyNoMoreInteractions(mockMessageRepository);
  });
}
