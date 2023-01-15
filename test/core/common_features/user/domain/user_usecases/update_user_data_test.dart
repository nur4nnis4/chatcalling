import 'package:chatcalling/core/common_features/user/domain/usecases/user_usercases/update_user_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/fixtures/user_dummy.dart';
import '../../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late UpdateUserData usecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = UpdateUserData(mockUserRepository);
  });

  test('Should update user data to the repository', () async {
    // Arrange
    when(mockUserRepository.updateUserData(tUser)).thenAnswer((_) async {
      return Right('Success');
    });
    //Act
    final actual = await usecase(user: tUser);
    // Assert
    verify(mockUserRepository.updateUserData(tUser));
    verifyNoMoreInteractions(mockUserRepository);
    expect(actual, equals(Right('Success')));
  });
}
