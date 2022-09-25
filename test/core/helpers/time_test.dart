import 'package:chatcalling/core/helpers/time.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/mocks/test.mocks.dart';

void main() {
  late MockTime mockTime;
  late TimeFormat simpleTime;

  setUp(() {
    mockTime = MockTime();
    simpleTime = TimeFormat(time: mockTime);
  });

  group('format', () {
    test(
        'Should return time in [YEAR_NUM_MONTH_DAY] format when the input date and current date do not have the same year  ',
        () async {
      // Arrange
      final inputDate = DateTime.parse('2021-09-15 20:23:09.798');
      when(mockTime.now())
          .thenReturn(DateTime.parse('2022-09-15 20:23:09.798'));
      // Act
      final actual = simpleTime.simplify(inputDate);
      // Assert
      expect(actual, "9/15/2021");
    });
    test(
        'Should return time in [ABBR_MONTH_DAY] format when the input date and current date have the same year but not the same month',
        () async {
      // Arrange
      final inputDate = DateTime.parse('2022-08-15 20:23:09.798');
      when(mockTime.now())
          .thenReturn(DateTime.parse('2022-09-15 20:23:09.798'));
      // Act
      final actual = simpleTime.simplify(inputDate);
      // Assert
      expect(actual, "Aug 15");
    });

    test(
        'Should return time in [ABBR_WEEKDAY] format when the input date and current date have the same year and month but not the same day',
        () async {
      // Arrange
      final inputDate = DateTime.parse('2022-09-14 20:23:09.798');
      when(mockTime.now())
          .thenReturn(DateTime.parse('2022-09-15 20:23:09.798'));
      // Act
      final actual = simpleTime.simplify(inputDate);
      // Assert
      expect(actual, "Wed");
    });
    test(
        'Should return time in [HOUR24_MINUTE] format when the input date and current date have the same year, month and day',
        () async {
      // Arrange
      final inputDate = DateTime.parse('2022-09-15 09:23:09.798');
      when(mockTime.now())
          .thenReturn(DateTime.parse('2022-09-15 20:23:09.798'));
      // Act
      final actual = simpleTime.simplify(inputDate);
      // Assert
      expect(actual, "09:23");
    });
  });

  test('Hm: Should return time in [HOUR24_MINUTE] format', () async {
    // Arrange
    final inputData = DateTime.parse('2022-09-15 19:23:09.798');
    // Act
    final actual = simpleTime.Hm(inputData);
    // Assert
    expect(actual, "19:23");
  });
  test('yMd: Should return time in [YEAR_NUM_MONTH_DAY] format', () async {
    // Arrange
    final inputData = DateTime.parse('2022-09-15 19:23:09.798');
    // Act
    final actual = simpleTime.yMd(inputData);
    // Assert
    expect(actual, "9/15/2022");
  });
  test('yMMMMd: Should return time in [YEAR_MONTH_DAY] format', () async {
    // Arrange
    final inputData = DateTime.parse('2022-09-15 19:23:09.798');
    // Act
    final actual = simpleTime.yMMMMd(inputData);
    // Assert

    expect(actual, "September 15, 2022");
  });
}
