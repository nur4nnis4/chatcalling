import 'package:chatcalling/core/common_features/user/domain/usecases/user_usercases/get_user_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/fixtures/user_dummy.dart';
import '../../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late GetUserData usecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = GetUserData(mockUserRepository);
  });

  final tUserId = 'user1Id';

  test('Should get user data from the repository', () async {
    // Arrange
    when(mockUserRepository.getUserData(tUserId)).thenAnswer((_) async* {
      yield Right(tUser);
    });
    //Act
    final actual = await usecase(userId: tUserId).first;
    // Assert
    verify(mockUserRepository.getUserData(tUserId));
    verifyNoMoreInteractions(mockUserRepository);
    expect(actual, equals(Right(tUser)));
  });
}
