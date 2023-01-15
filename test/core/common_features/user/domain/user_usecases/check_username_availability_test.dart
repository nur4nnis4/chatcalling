import 'package:chatcalling/core/common_features/user/domain/usecases/user_usercases/check_username_availability.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late CheckUsernameAvailability usecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = CheckUsernameAvailability(mockUserRepository);
  });

  final tUsername = 'username';

  test('Should check is username is available from the repository', () async {
    // Arrange
    when(mockUserRepository.checkUsernameAvailability(tUsername))
        .thenAnswer((_) async {
      return Right(true);
    });
    //Act
    final actual = await usecase(username: tUsername);
    // Assert
    verify(mockUserRepository.checkUsernameAvailability(tUsername));
    verifyNoMoreInteractions(mockUserRepository);
    expect(actual, equals(Right(true)));
  });
}
