import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final DateTime now = DateTime.now();
final DateFormat formatter = DateFormat('yyyy-MM-dd');
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

  Map<String,dynamic>? _authCredentials = {};
  Map<String,dynamic>? get authCredentials => _authCredentials;

  Map<String,dynamic>? _profileInfo = {};
  Map<String,dynamic>? get profileInfo => _profileInfo;

  void initializeAuthInfo(Map<String,dynamic>? credentials) {
    _authCredentials = credentials;
    notifyListeners();
  }

  void initializeProfileInfo(Map<String,dynamic>? data) {
    _profileInfo = data;
    notifyListeners();
  }

  bool _countDownTimerExpired = false;
  bool get countDownTimerExpired => _countDownTimerExpired;

  int _timerEndTime =  DateTime.now().millisecondsSinceEpoch + 1000 * 10;
  int get timerEndTime => _timerEndTime;

  void updateCountDownTimer({required bool expired}){
    if(!expired){
      _timerEndTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
    }
    _countDownTimerExpired = expired;
    notifyListeners();
  }

  void resetCountDownTimer(){
    _countDownTimerExpired = false;
    _timerEndTime =  DateTime.now().millisecondsSinceEpoch + 1000 * 10;
    notifyListeners();
  }

}
