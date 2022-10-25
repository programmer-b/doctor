import 'dart:async';
import 'dart:developer';

import 'package:doctor/model/MLJWTDecoder.dart';
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

  Map<String, dynamic>? _authCredentials = {};
  Map<String, dynamic>? get authCredentials => _authCredentials;

  MLJWTDecoder? _decodedToken;
  MLJWTDecoder? get decodedToken => _decodedToken;

  Profile? _profile;
  Profile? get profile => _profile;

  void initializeAuthInfo(Map<String, dynamic>? credentials) {
    _authCredentials = credentials;
    notifyListeners();
  }

  void initializeProfileInfo(
      {MLJWTDecoder? data = null, Map<String, dynamic>? profile = null}) {
    assert(data != null || profile != null);
    if (data != null) {
      _decodedToken = data;
      _profile = data.usr?.profile ?? null;
    } else {
      log("TO SET THIS PROFILE => $profile");
      _profile = Profile.fromJson(profile ?? {});
      log("CARRIED OUT A PROFILE SET: TESTING FIRST NAME FROM PROFILE MODEL: ${_profile?.firstName ?? null}");
    }
    notifyListeners();
  }

  bool _countDownTimerExpired = false;
  bool get countDownTimerExpired => _countDownTimerExpired;

  int _timerEndTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
  int get timerEndTime => _timerEndTime;

  void updateCountDownTimer({required bool expired}) {
    if (!expired) {
      _timerEndTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
    }
    _countDownTimerExpired = expired;
    notifyListeners();
  }

  void resetCountDownTimer() {
    _countDownTimerExpired = false;
    _timerEndTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
    notifyListeners();
  }

  ///Delaring a countdown timer
  Timer? _countdownTimer;
  Timer? get countdownTimer => _countdownTimer;

  bool _timerExpired = false;
  bool get timerExpired => _timerExpired;

  Duration _otpExpiryTime = Duration(seconds: 120);
  Duration get otpExpiryTime => _otpExpiryTime;

  void startTimer() {
    _countdownTimer =
        Timer.periodic(Duration(seconds: 1), (timer) => setCountDown());
  }

  void setCountDown() {
    final reduceSecondsBy = 1;

    final seconds = otpExpiryTime.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      _timerExpired = true;
      countdownTimer!.cancel();
    } else {
      _otpExpiryTime = Duration(seconds: seconds);
    }
    notifyListeners();
  }

  void resetTimer() {
    stopTimer();
    _otpExpiryTime = Duration(seconds: 117);
    notifyListeners();
  }

  void stopTimer() {
    _countdownTimer!.cancel();
    notifyListeners();
  }

  void updateTimerExpired(bool expired) {
    _timerExpired = expired;
    notifyListeners();
  }

  bool _otpTimerExpired = false;
  bool get otpTimerExpired => _otpTimerExpired;

  Duration _otpTimerDuration = const Duration(seconds: 120);
  Duration get otpTimerDuration => _otpTimerDuration;

  void rebuildTimer() {
    _otpTimerDuration = _otpTimerDuration;
    _otpTimerExpired = !_otpTimerExpired;
    notifyListeners();
  }
}
