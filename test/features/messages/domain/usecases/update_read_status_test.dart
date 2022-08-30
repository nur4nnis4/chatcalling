import 'package:chatcalling/features/messages/domain/usecases/update_read_status.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockMessageRepository repository;
  late UpdateReadStatus usecase;

  setUp(() {
    repository = MockMessageRepository();
    usecase = UpdateReadStatus(repository);
  });

  test('Should update message read status in repository', () async {
    final tUserId = 'user1Id';
    final tConversationId = 'user1Id-user2Id';
    // Arrange
    when(repository.updateReadStatus(any, any))
        .thenAnswer((_) async => Right(''));
    // Act
    await usecase(userId: tUserId, conversationId: tConversationId);
    // Assert
    verify(repository.updateReadStatus(tUserId, tConversationId));
  });
}
