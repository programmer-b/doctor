import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final DateTime now = DateTime.now();
final DateFormat formatter = DateFormat('dd-MM-yyyy');
final String formatted = formatter.format(now);

class AppState with ChangeNotifier {
  DateTime _selectedDate = now;
  DateTime get selectedDate => _selectedDate;

  void init() {
    _selectedDate = now;
    notifyListeners();
  }

  void setDate(newDate) {
    _selectedDate = newDate;
    notifyListeners();
  }

  String _selectedResidence = '';
  String get selectedResidence => _selectedResidence;

  void setResidence(residence) {
    _selectedResidence = residence;
    notifyListeners();
  }

  Object? _authCredentials = {};
  Object? get authCredentials => _authCredentials;

  Object? _profileInfo = {};
  Object? get profileInfo => _profileInfo;

  void initializeAuthInfo(Object? credentials) {
    _authCredentials = credentials;
    notifyListeners();
  }

  void initializeProfileInfo(Object? data) {
    _profileInfo = data;
    notifyListeners();
  }
}
