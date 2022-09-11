import 'dart:convert';

import 'package:doctor/utils/MLCommon.dart';
import 'package:doctor/utils/MLString.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';

class Networking with ChangeNotifier {
  bool _success = false;
  bool get success => _success;

  bool _failure = false;
  bool get failure => _failure;

  Map<String, dynamic> _successMap = {};
  Map<String, dynamic> _failureMap = {};

  Map<String, dynamic> get successMap => _successMap;
  Map<String, dynamic> get failureMap => _failureMap;

  String token = '';

  Future<void> init() async {
    _success = false;
    _failure = false;
    _successMap = {};
    _failureMap = {};
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void load() {
    _isLoading = true;
    notifyListeners();
  }

  Future<Response> post(
      {required final Uri uri,
      Map<String, String>? headers,
      Object? body}) async {
    try {
      final data = await http.post(uri, headers: headers, body: body);
      _success = true;
      notifyListeners();
      return data;
    } catch (e) {
      _failure = true;
      notifyListeners();
      toast('Check your internet connection and try again');
      log('$e');
      throw (e.toString());
    }
  }

  Future<void> postForm({required final uri, required Object? body}) async {
    load();
    await init();

    final data = await post(uri: uri, body: body);
    if (data.OK) {
      _successMap = jsonDecode(data.body);
      log('Login successful: ${data.body}');
    } else if (data.statusCode >= 400 && data.statusCode < 500) {
      _failureMap = jsonDecode(data.body);
      log("Login failed: ${data.body}");
    } else {
      toast("Something went wrong. Please try again later");
      return;
    }
    _isLoading = false;
    notifyListeners();
  }
}
