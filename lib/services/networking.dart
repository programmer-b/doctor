import 'dart:convert';
import 'dart:developer';

import 'package:doctor/utils/MLColors.dart';
import 'package:doctor/utils/MLCommon.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart' hide log;

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
    log('url: $uri \n\n');
    try {
      final data = await http.post(uri, headers: headers, body: body);
      log('${data.body}');
      
      notifyListeners();

      return data;
    } catch (e) {
      _failure = true;
      _isLoading = false;
      notifyListeners();
      toast("Check your connection and try again", bgColor: mlPrimaryColor, textColor: Colors.white);
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
      _success = true;
      log('Operation successful: ${data.body}');
    } else if (data.statusCode >= 400 && data.statusCode < 500) {
      _failureMap = jsonDecode(data.body);
      log("Login failed: ${data.body}");
    } else {
      toast("Server error. Try again later", bgColor: mlPrimaryColor, textColor: Colors.white);
    }
    _isLoading = false;
    notifyListeners();
  }
}
