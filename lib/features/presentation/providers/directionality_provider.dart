


import 'package:flutter/material.dart';

class DirectionalityProvider extends ChangeNotifier {

  TextDirection _direction = TextDirection.ltr;

  TextDirection get direction => _direction;

  set direction(TextDirection direction) {
    if(direction != _direction) {
      _direction = direction;
    }
    notifyListeners();
  }

  void switchDirection() {
    if(_direction == TextDirection.ltr) {
      _direction = TextDirection.rtl;
    } else {
      _direction = TextDirection.ltr;
    }
    notifyListeners();
  }

}