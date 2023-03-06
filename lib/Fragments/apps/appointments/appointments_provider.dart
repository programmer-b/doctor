import 'package:flutter/material.dart';

class AppointmentsProvider extends ChangeNotifier {
  String _date = "";
  String get date => _date;

  String _time = "";
  String get time => _time;

  setDate(date) => {_date = date, notifyListeners()};
  setTime(time) => {_time = time, notifyListeners()};
}
