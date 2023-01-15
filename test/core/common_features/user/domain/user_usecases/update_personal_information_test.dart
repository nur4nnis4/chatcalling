import 'package:chatcalling/core/common_features/user/domain/usecases/user_usercases/update_personal_information.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/fixtures/personal_information_dummy.dart';
import '../../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late UpdatePersonalInformation usecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = UpdatePersonalInformation(mockUserRepository);
  });

  test('Should update personal information to the repository', () async {
    // Arrange
    when(mockUserRepository.updatePersonalInformation(tPersonalInformation))
        .thenAnswer((_) async {
      return Right('Success');
    });
    //Act
    final actual = await usecase(personalInformation: tPersonalInformation);
    // Assert
    verify(mockUserRepository.updatePersonalInformation(tPersonalInformation));
    verifyNoMoreInteractions(mockUserRepository);
    expect(actual, equals(Right('Success')));
  });
}
