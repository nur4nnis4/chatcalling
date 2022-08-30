import 'package:chatcalling/features/messages/domain/usecases/send_message.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/fixtures/dummy_objects.dart';
import '../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockMessageRepository repository;
  late SendMessage usecase;

  setUp(() {
    repository = MockMessageRepository();
    usecase = SendMessage(repository);
  });

  test('Should send message to the repository', () async {
    // Arrange
    when(repository.sendMessage(any))
        .thenAnswer((_) async => Right('Message has been sent'));
    // Act
    final actual = await usecase(message: tMessage);
    // Assert
    verify(repository.sendMessage(tMessage));
    expect(actual, Right('Message has been sent'));
  });
}
