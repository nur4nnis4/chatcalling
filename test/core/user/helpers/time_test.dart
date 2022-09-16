import 'package:chatcalling/core/helpers/time.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mocks/test.mocks.dart';

void main() {
  late MockTime mockTime;
  late SimpleTime simpleTime;

  setUp(() {
    mockTime = MockTime();
    simpleTime = SimpleTime(time: mockTime);
  });

  group('format', () {
    test(
        'Should return time in [yyyy/MM/dd] format when the input date and current date do not have the same year  ',
        () async {
      // Arrange
      final inputDate = DateTime.parse('2021-09-15 20:23:09.798');
      when(mockTime.now())
          .thenReturn(DateTime.parse('2022-09-15 20:23:09.798'));
      // Act
      final actual = simpleTime.format(inputDate);
      // Assert
      expect(actual, "2021/09/15");
    });
    test(
        'Should return time in [MMM dd] format when the input date and current date have the same year but not the same month',
        () async {
      // Arrange
      final inputDate = DateTime.parse('2022-08-15 20:23:09.798');
      when(mockTime.now())
          .thenReturn(DateTime.parse('2022-09-15 20:23:09.798'));
      // Act
      final actual = simpleTime.format(inputDate);
      // Assert
      expect(actual, "Aug 15");
    });

    test(
        'Should return time in [ddd] format when the input date and current date have the same year and month but not the same day',
        () async {
      // Arrange
      final inputDate = DateTime.parse('2022-09-14 20:23:09.798');
      when(mockTime.now())
          .thenReturn(DateTime.parse('2022-09-15 20:23:09.798'));
      // Act
      final actual = simpleTime.format(inputDate);
      // Assert
      expect(actual, "Wed");
    });
    test(
        'Should return time in [hh:mm] format when the input date and current date have the same year, month and day',
        () async {
      // Arrange
      final inputDate = DateTime.parse('2022-09-15 19:23:09.798');
      when(mockTime.now())
          .thenReturn(DateTime.parse('2022-09-15 20:23:09.798'));
      // Act
      final actual = simpleTime.format(inputDate);
      // Assert
      expect(actual, "19:23");
    });
  });
}
