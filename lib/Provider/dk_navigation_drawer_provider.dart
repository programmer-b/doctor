import 'package:flutter/material.dart';

class DKNavigationDrawerProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setIndex(newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }
}
