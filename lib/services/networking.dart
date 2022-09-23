import 'dart:convert';
import 'dart:developer';

import 'package:doctor/screens/MLLoginScreen.dart';
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
      final data = await http.post(uri, headers: headers, body: jsonEncode(body));
      log('${data.body}');

      notifyListeners();

      return data;
      // return await http.get(Uri.parse('https://www.google.com'));
    } catch (e) {
      _failure = true;
      _isLoading = false;
      notifyListeners();
      toast("Something went wrong \n $e",
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
                'Content-Type': 'application/json',
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
        "Something went wrong. Try again later",
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
    try {
      final data = await http.get(uri,
          headers: token != null
              ? {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'Bearer $token',
                }
              : null);
      if (data.OK) {
        _success = true;
        _successMap = jsonDecode(data.body);
        log('Operation Success: ${data.body}');
      } else if (jsonDecode(data.body)["statusCode"] == 401) {
        log('Refreshing token');
        //TODO implement or  call a method to refresh your token
        toast('Your credentials are expired, Login to continue',
            gravity: ToastGravity.TOP, bgColor: mlPrimaryColor);
        final authCredentials = await getJSONAsync('auth');
        if (context != null) {
          MLLoginScreen(
            phoneNumber: authCredentials['data']['phone number'],
          ).launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
        } else {
          toast('Something went wrong, try again later',
              bgColor: Colors.red, gravity: ToastGravity.TOP);
        }
      }
    } catch (e) {
      toast('Check your connection and try again',
          bgColor: Colors.red, gravity: ToastGravity.TOP);
    }
    _isLoading = false;
    notifyListeners();
  }
}
