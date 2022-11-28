import 'dart:convert';
import 'dart:developer';

import 'package:afyadaktari/Commons/dk_extensions.dart';
import 'package:afyadaktari/Commons/dk_keys.dart';
import 'package:afyadaktari/Commons/dk_urls.dart';
import 'package:afyadaktari/Utils/dk_easy_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart' hide log;

import '../Utils/dk_toast.dart';

class DKPasswordProvider extends ChangeNotifier {
  String _currentPassword = "";
  String get currentPassword => _currentPassword;

  void setCurrentPassword(currentPassword) {
    _currentPassword = currentPassword;
    notifyListeners();
  }

  String _newPassword = "";
  String get newPassword => _newPassword;

  void setNewPassword(newPassword) {
    _newPassword = newPassword;
    notifyListeners();
  }

  String _confirmNewPassword = "";
  String get confirmNewPassword => _confirmNewPassword;

  void setConfirmNewPassword(confirmPassword) {
    _confirmNewPassword = confirmPassword;
    notifyListeners();
  }

  void initialize() {
    _currentPassword = "";
    _newPassword = "";
    // _oldPassword = "";
    _confirmNewPassword = "";

    notifyListeners();
  }

  Future<void> submitData({required bool isChangePassword}) async {
    DKEasyLoading.show();
    _responseMap = {};

    _currentPassword = _currentPassword.trim();
    _newPassword = _newPassword.trim();
    // _oldPassword = _oldPassword.trim();
    _confirmNewPassword = _confirmNewPassword.trim();

    Map<String, String> body = {};

    if (!isChangePassword) {
      body = {
        keyNewPassword: _newPassword,
        keyConfirmPassword: _confirmNewPassword
      };
    } else {
      body = {
        keyNewPassword: _newPassword,
        keyConfirmPassword: _confirmNewPassword,
        keyCurrentPassword: _currentPassword
      };
    }

    Map<String, String> headers = {};

    if (isChangePassword) {
      final String token = getStringAsync(keyToken);
      headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
    } else {
      final String token = getStringAsync(keyTempToken);
      headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
    }

    final uri =
        Uri.parse(isChangePassword ? dkChangePasswordUrl : dkResetPasswordUrl);

    try {
      final response = await http.post(uri, body: body, headers: headers);
      log("RESPNSE : ${response.body}");
      _responseMap = jsonDecode(response.body);

      if (response.statusCode >= 500) {
        DKToast.showErrorToast("Server Error");
      } else if (response.ok) {
        DKToast.toastTop(jsonDecode(response.body)[keyMessage]);
        _success = true;
      } else {
        _failure = true;
      }
    } catch (e) {
      DKToast.showErrorToast("$e");
      rethrow;
    } finally {
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

  void init() {}

  bool _success = false;
  bool get success => _success;

  bool _failure = false;
  bool get failure => _failure;

  Map<String, dynamic> _responseMap = {};
  Map<String, dynamic> get responseMap => _responseMap;
}
