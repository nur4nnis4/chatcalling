import 'package:intl/intl.dart';

abstract class Time {
  DateTime now();
}

class TimeImpl implements Time {
  @override
  DateTime now() => DateTime.now();
}

class SimpleTime {
  final Time time;

  SimpleTime({required this.time});

  @override
  String format(DateTime date) {
    final now = time.now();
    bool isSameDay = date.day == now.day;
    bool isSameMonth = date.month == now.month;
    bool isSameYear = date.year == now.year;

    List<String> month = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sept",
      "Oct",
      "Nov",
      "Dec"
    ];

    List<String> day = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    if (isSameYear) {
      if (isSameMonth) {
        if (isSameDay) {
          return "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}"; // [hh:mm]
        } else
          return "${day[date.weekday - 1]}";
      } else
        return "${month[date.month - 1]} ${date.day.toString().padLeft(2, '0')}";
    } else
      return "${date.year.toString()}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}";
    ;
  }
}
