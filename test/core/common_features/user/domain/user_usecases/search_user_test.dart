import 'package:chatcalling/core/common_features/user/domain/usecases/user_usercases/search_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/fixtures/user_dummy.dart';
import '../../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late SearchUser usecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = SearchUser(mockUserRepository);
  });

  final tQuery = 'Nur';
  final tUserList = [tUser];
  test('Should get matching user list from the repository', () async {
    // Arrange
    when(mockUserRepository.searchUser(tQuery)).thenAnswer((_) async* {
      yield Right(tUserList);
    });
    //Act
    final actual = await usecase(query: tQuery).first;
    // Assert
    verify(mockUserRepository.searchUser(tQuery));
    verifyNoMoreInteractions(mockUserRepository);
    expect(actual, equals(Right(tUserList)));
  });
}
