import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppState with ChangeNotifier {
  bool _success = false;
  bool _failure = false;

  bool get success => _success;
  bool get failure => _failure;

  List<dynamic> _successMap = [];
  List<dynamic> get successMap => _successMap;

  String _countyResidence = '';
  String get countyResidence => _countyResidence;

  void countyResidenceUpdate(residence) {
    _countyResidence = residence;
    notifyListeners();
  }

  Future<void> MLget(Uri uri) async {
    try {
      final response = await http.get(uri);
      if (response.OK) {
        _successMap = jsonDecode(response.body);
        _success = true;
        log("success $successMap");
      }
    } catch (e) {
      _failure = true;
      log('error $e');
    }
  }

  notifyListeners();
}

extension IsOk on http.Response {
  bool get OK {
    return (statusCode ~/ 100) == 2;
  }
}
