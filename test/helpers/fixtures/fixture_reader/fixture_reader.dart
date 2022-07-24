import 'dart:io';

String fixture(String name) {
  return File('test/helpers/fixtures/$name').readAsStringSync();
}
