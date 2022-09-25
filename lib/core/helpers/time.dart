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

  String simplify(DateTime date) {
    final now = time.now();
    bool isSameDay = date.day == now.day;
    bool isSameMonth = date.month == now.month;
    bool isSameYear = date.year == now.year;

    if (isSameYear) {
      if (isSameMonth) {
        if (isSameDay) {
          return DateFormat.Hm().format(date);
        } else
          return DateFormat.E().format(date);
      } else
        return DateFormat.MMMd().format(date);
    } else
      return DateFormat.yMd().format(date);
  }

  // ignore: non_constant_identifier_names
  String Hm(DateTime date) {
    return DateFormat.Hm().format(date);
  }

  String yMd(DateTime date) {
    return DateFormat.yMd().format(date);
  }

  String yMMMMd(DateTime date) {
    return DateFormat.yMMMMd().format(date);
  }
}
