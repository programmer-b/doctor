import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

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
      final data = await http.post(uri, headers: headers, body: body).timeout(
            const Duration(seconds: 15),
          );
      log('${data.body}');

      notifyListeners();

      return data;
      // return await http.get(Uri.parse('https://www.google.com'));
    } on SocketException {
      _isLoading = false;
      notifyListeners();
      toast('Check your internet connection and try again',
          gravity: ToastGravity.TOP, bgColor: Colors.red);
      rethrow;
    } on TimeoutException {
      _isLoading = false;
      notifyListeners();
      toast('Oops! Connection time out reached',
          gravity: ToastGravity.TOP, bgColor: Colors.red);
      rethrow;
    } catch (e) {
      _failure = true;
      _isLoading = false;
      notifyListeners();
      toast("Oops! Something went wrong \n $e",
          bgColor: Colors.red,
          textColor: Colors.white,
          gravity: ToastGravity.TOP);
      log('ERROR: $e');
      throw (e);
    }
  }

  Future<void> postForm(
      {required final uri, required Object? body, final String? token}) async {
    load();
    await init();

    final data = await post(
        uri: uri,
        body: body,
        headers: token != null
            ? {
                // 'Content-Type':'application/json-patch+json',
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
              }
            : null);
    if (data.OK) {
      _successMap = jsonDecode(data.body);
      _success = true;
      log('Operation successful: ${data.body}');
    } else if (jsonDecode(data.body)['errors'] == null) {
      toast(
        "Something went wrong. Try again later\n\n${data.body}",
        bgColor: Colors.red,
        textColor: Colors.white,
        gravity: ToastGravity.TOP,
      );
    } else if (data.statusCode >= 400 && data.statusCode < 500) {
      _failureMap = jsonDecode(data.body);
      log("Login failed: ${data.body}");
    } else {
      toast("Server error. Try again later",
          bgColor: Colors.red,
          textColor: Colors.white,
          gravity: ToastGravity.TOP);
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> get(
      {required final Uri uri,
      final String? token,
      BuildContext? context}) async {
    log('url: $uri \n\n token: $token\n\n');
    init();
    load();
    log('running http get ...');
    try {
      final data = await http.get(uri,
          headers: token != null
              ? {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'Bearer $token',
                }
              : null);
      log('GET DATA; ${data.body}\n StatusCode: ${data.statusCode}');
      if (data.OK) {
        _success = true;
        _successMap = jsonDecode(data.body);
        log('Operation Success: ${data.body}');
      } else {
        _failureMap = jsonDecode(data.body);
      }
    } catch (e) {
      toast('Something went wrong, try again later\n$e',
          bgColor: Colors.red, gravity: ToastGravity.TOP);
    }
    _isLoading = false;
    notifyListeners();
  }
}
