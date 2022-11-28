import 'package:chatcalling/core/common_features/user/domain/usecases/get_friend_list.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/fixtures/user_dummy.dart';
import '../../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late GetFriendList usecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = GetFriendList(mockUserRepository);
  });

  final tUserId = 'user1Id';
  final tUserList = [tUser];
  test('Should get friend list from the repository', () async {
    // Arrange
    when(mockUserRepository.getFriendList(tUserId)).thenAnswer((_) async* {
      yield Right(tUserList);
    });
    //Act
    final actual = await usecase(userId: tUserId).first;
    // Assert
    verify(mockUserRepository.getFriendList(tUserId));
    verifyNoMoreInteractions(mockUserRepository);
    expect(actual, equals(Right(tUserList)));
  });
}
