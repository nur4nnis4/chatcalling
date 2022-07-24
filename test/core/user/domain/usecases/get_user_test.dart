import 'package:chatcalling/core/user/domain/entities/user.dart';
import 'package:chatcalling/core/user/domain/usecases/get_user_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late GetUserData usecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = GetUserData(mockUserRepository);
  });

  final tUserId = 'userId';

  final tUser = User(
      userId: 'userId',
      username: 'username',
      displayName: 'displayName',
      signUpTime: DateTime.now(),
      isOnline: false,
      lastOnline: DateTime.now());

  test('Should get user data from the repository', () async {
    // Arrange
    when(mockUserRepository.getUserData(tUserId))
        .thenAnswer((_) async => Right(tUser));
    //Act
    final result = await usecase(userId: tUserId);
    // Assert
    verify(mockUserRepository.getUserData(tUserId));
    verifyNoMoreInteractions(mockUserRepository);
    expect(result, equals(Right(tUser)));
  });
}
