import 'package:chatcalling/core/common_features/user/domain/usecases/get_personal_information.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/fixtures/personal_information_dummy.dart';
import '../../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late GetPersonalInformation usecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = GetPersonalInformation(mockUserRepository);
  });

  final tUserId = 'user1Id';

  test('Should get personal information from the repository', () async {
    // Arrange
    when(mockUserRepository.getPersonalInformation(tUserId))
        .thenAnswer((_) async* {
      yield Right(tPersonalInformation);
    });
    //Act
    final actual = await usecase(userId: tUserId).first;
    // Assert
    verify(mockUserRepository.getPersonalInformation(tUserId));
    verifyNoMoreInteractions(mockUserRepository);
    expect(actual, equals(Right(tPersonalInformation)));
  });
}
