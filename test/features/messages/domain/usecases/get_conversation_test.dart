import 'package:chatcalling/features/messages/domain/entities/conversation.dart';
import 'package:chatcalling/features/messages/domain/usecases/get_conversations.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/fixtures/conversations_dummy.dart';
import '../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockMessageRepository mockMessageRepository;
  late GetConversations usecase;

  setUp(() {
    mockMessageRepository = MockMessageRepository();
    usecase = GetConversations(mockMessageRepository);
  });

  const String tUserId = 'user1';
  List<Conversation> tConversationList = [tConversation];

  test('Should get conversations from the repository', () async {
    // Arrange
    when(mockMessageRepository.getConversations(any)).thenAnswer((_) async* {
      yield Right(tConversationList);
    });
    // Act
    final result = await usecase(userId: tUserId).first;
    //Assert
    expect(result, equals(Right(tConversationList)));
    verify(mockMessageRepository.getConversations(tUserId));
    verifyNoMoreInteractions(mockMessageRepository);
  });
}
