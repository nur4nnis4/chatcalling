import 'package:timeago/timeago.dart' as timeago;

abstract class Time {
  DateTime getCurrent();
  String humanize(DateTime time);
}

class TimeImpl implements Time {
  @override
  DateTime getCurrent() => DateTime.now();

  @override
  String humanize(DateTime time) => timeago.format(time);
}
