import 'package:bloc_test/bloc_test.dart';
import 'package:chatcalling/core/common_features/user/presentation/bloc/search_user_bloc/search_user_bloc.dart';
import 'package:chatcalling/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/fixtures/user_dummy.dart';
import '../../../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockSearchUser mockSearchUser;
  late SearchUserBloc searchUserBloc;

  final String tQuery = 'query';

  setUp(() {
    mockSearchUser = MockSearchUser();
    searchUserBloc = SearchUserBloc(searchUser: mockSearchUser);
  });

  test('Initial state should be empty', () {
    // Assert
    expect(searchUserBloc.state, SearchUserEmpty());
  });

  group('SearchUserEvent', () {
    blocTest<SearchUserBloc, SearchUserState>(
        'should emit [SearchUserLoading,SearchUserLoaded] when data is gotten successfully and is not empty.',
        build: () {
          when(mockSearchUser(query: tQuery)).thenAnswer((_) async* {
            yield Right([tUser]);
          });
          return searchUserBloc;
        },
        act: (bloc) => bloc.add(SearchUserEvent(query: tQuery)),
        expect: () => [
              SearchUserLoading(),
              SearchUserLoaded(matchedUserList: [tUser]),
            ],
        verify: (_) => verify(mockSearchUser(query: tQuery)));
    blocTest<SearchUserBloc, SearchUserState>(
      'emits [SearchUserLoading, SearchUserEmpty] when data is gotten successfully and is empty',
      build: () {
        when(mockSearchUser(query: tQuery)).thenAnswer((_) async* {
          yield Right([]);
        });
        return searchUserBloc;
      },
      act: (bloc) => bloc.add(SearchUserEvent(query: tQuery)),
      expect: () => [
        SearchUserLoading(),
        SearchUserEmpty(),
      ],
      verify: (_) => mockSearchUser(query: tQuery),
    );

    blocTest<SearchUserBloc, SearchUserState>(
        'emits [SearchUserLoading, SearchUserError] when getting data fails',
        build: () {
          when(mockSearchUser(query: tQuery)).thenAnswer((_) async* {
            yield Left(PlatformFailure('Platform Failure'));
          });
          return searchUserBloc;
        },
        act: (bloc) => bloc.add(SearchUserEvent(query: tQuery)),
        expect: () => [
              SearchUserLoading(),
              SearchUserError(errorMessage: 'Platform Failure'),
            ],
        verify: (_) => verify(mockSearchUser(query: tQuery)));
  });
}
