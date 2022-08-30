import 'package:chatcalling/core/helpers/unique_id.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late UniqueIdImpl uniqueId;

  setUp(() => uniqueId = UniqueIdImpl());
  test(
      'concat should return a uuid by concatenating two uuids using the - operator',
      () {
    // Arrange
    final uuid1 = 'user2Id';
    final uuid2 = 'user1Id';

    // Act
    final actual = uniqueId.concat(uuid1, uuid2);

    // Assert
    expect(actual, equals('user1Id-user2Id'));
  });
}
