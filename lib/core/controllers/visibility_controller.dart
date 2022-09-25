import 'package:flutter/foundation.dart';

class VisibilityController with ChangeNotifier {
  bool visible;
  VisibilityController({this.visible = true});

  void toggle() {
    this.visible = !visible;
    notifyListeners();
  }
}
