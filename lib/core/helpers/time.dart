import 'package:intl/intl.dart';

abstract class Time {
  DateTime now();
}

class TimeImpl implements Time {
  @override
  DateTime now() => DateTime.now();
}

class TimeFormat {
  final Time time;

  TimeFormat({required this.time});

  String simplify(DateTime date, String languageCode) {
    final now = time.now();
    bool isSameDay = date.day == now.day;
    bool isSameMonth = date.month == now.month;
    bool isSameYear = date.year == now.year;
    if (isSameYear) {
      if (isSameMonth) {
        if (isSameDay) {
          return DateFormat.Hm(languageCode).format(date);
        } else
          return DateFormat.E(languageCode).format(date);
      } else
        return DateFormat.MMMd(languageCode).format(date);
    } else
      return DateFormat.yMd(languageCode).format(date);
  }

  // ignore: non_constant_identifier_names
  String Hm(DateTime date) {
    return DateFormat.Hm().format(date);
  }

  String yMd(DateTime date, String languageCode) {
    return DateFormat.yMd(languageCode).format(date);
  }

  String yMMMMd(DateTime date, String languageCode) {
    return DateFormat.yMMMMd(languageCode).format(date);
  }

  DateTime toYMD(DateTime date) {
    return DateTime.parse(
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}');
  }
}
