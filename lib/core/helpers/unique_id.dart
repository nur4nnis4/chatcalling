import 'package:uuid/uuid.dart';

abstract class UniqueId {
  String random();
  String concat(String uuid1, String uuid2);
}

class UniqueIdImpl implements UniqueId {
  @override
  String random() => Uuid().v4();

  @override
  String concat(String uuid1, String uuid2) =>
      ([uuid1, uuid2]..sort()).join('-');
}
