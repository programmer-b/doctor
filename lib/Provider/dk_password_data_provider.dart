import 'dart:developer';

import 'package:afyadaktari/Commons/dk_extensions.dart';
import 'package:afyadaktari/Commons/dk_keys.dart';
import 'package:afyadaktari/Commons/dk_urls.dart';
import 'package:afyadaktari/Utils/dk_easy_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import '../Utils/dk_toast.dart';

class DKPasswordProvider extends ChangeNotifier {
  String _currentPassword = "";
  String get currentPassword => _currentPassword;

  void setCurrentPassword(currentPassword) {
    _currentPassword = currentPassword;
    notifyListeners();
  }

  String _oldPassword = "";
  String get oldPassword => _oldPassword;

  void setOldPassword(oldPassword) {
    _oldPassword = oldPassword;
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
    _oldPassword = "";
    _confirmNewPassword = "";

    notifyListeners();
  }

  Future<void> submitData({required bool isChangePassword}) async {
    DKEasyLoading.show();

    _currentPassword = _currentPassword.trim();
    _newPassword = _newPassword.trim();
    _oldPassword = _oldPassword.trim();
    _confirmNewPassword = _confirmNewPassword.trim();

    Map<String, String> body = {};

    if (!isChangePassword) {
      body = {
        keyNewPassword: _newPassword,
        keyConfirmNewPassword: _confirmNewPassword
      };
    } else {
      body = {
        keyNewPassword: _newPassword,
        keyConfirmNewPassword: _confirmNewPassword,
        keyOldPassword: _oldPassword
      };
    }

    final uri =
        Uri.parse(isChangePassword ? dkChangePasswordUrl : dkResetPasswordUrl);

            try {
      final response = await http.post(uri, body: body);
      log(response.body);
      if (response.ok) {
        // _credentialsModel =
        //     DKUserCredentialsModel.fromJson(jsonDecode(response.body));
      } else {
        // _loginErrors = DKLoginErrorModel.fromJson(jsonDecode(response.body));
      }
      EasyLoading.dismiss();
      notifyListeners();
    } catch (e) {
      EasyLoading.dismiss();
      DKToast.showErrorToast("$e");
      rethrow;
    }
  }

  void init() {}
}
