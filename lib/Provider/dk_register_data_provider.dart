import 'dart:convert';
import 'dart:developer';

import 'package:afyadaktari/Commons/dk_extensions.dart';
import 'package:afyadaktari/Commons/dk_urls.dart';
import 'package:afyadaktari/Models/auth/dk_register_error.dart';
import 'package:afyadaktari/Models/auth/dk_user_credentials_model.dart';
import 'package:afyadaktari/Utils/dk_easy_loading.dart';
import 'package:afyadaktari/Utils/dk_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class DKRegisterDataProvider extends ChangeNotifier {
  String _phoneNumber = "";
  String get phoneNumber => _phoneNumber;

  void setPhoneNumber(text) {
    _phoneNumber = text;
    notifyListeners();
  }

  String _confirmPhoneNumber = "";
  String get confirmPhoneNumber => _confirmPhoneNumber;

  void setConfirmPhoneNumber(text) {
    _confirmPhoneNumber = text;
    notifyListeners();
  }

  String _username = "";
  String get username => _username;

  void setusername(text) {
    _username = text;
    notifyListeners();
  }

  String _password = "";
  String get password => _password;

  void setPassword(text) {
    _password = text;
    notifyListeners();
  }

  bool _canShowPassword = true;
  bool get canShowPassword => _canShowPassword;

  void showPassword() {
    _canShowPassword = !_canShowPassword;
    notifyListeners();
  }

  String _confirmPassword = "";
  String get confirmPassword => _confirmPassword;

  void setConfirmPassword(text) {
    _confirmPassword = text;
    notifyListeners();
  }

  bool _canShowConfirmPassword = true;
  bool get canShowConfirmPassword => _canShowConfirmPassword;

  void showConfirmPassword() {
    _canShowConfirmPassword = !_canShowConfirmPassword;
    notifyListeners();
  }

  Future<void> submitData() async {
     DKEasyLoading.show();

    _password = _password.trim();
    _confirmPassword = _confirmPassword.trim();
    _username = _username.trim();
    _phoneNumber = _phoneNumber.trim();
    _confirmPhoneNumber = _confirmPhoneNumber.trim();

    final Map<String, String> body = {
      "mobile": _phoneNumber,
      "confirm_mobile": _confirmPhoneNumber,
      "username": _username,
      "password": _password,
      "confirm_password": _confirmPassword
    };

    final uri = Uri.parse(dkRegisterUrl);

    try {
      final response = await http.post(uri, body: body);
      log(response.body);
      if (response.ok) {
        _credentialsModel =
            DKUserCredentialsModel.fromJson(jsonDecode(response.body));
      } else {
        _registerErrors =
            DKRegisterErrorModel.fromJson(jsonDecode(response.body));
      }
      EasyLoading.dismiss();
      notifyListeners();
    } catch (e) {
      EasyLoading.dismiss();
      DKToast.showErrorToast("$e");
      rethrow;
    }
  }

  DKUserCredentialsModel? _credentialsModel;
  DKUserCredentialsModel? get credentialsModel => _credentialsModel;

  DKRegisterErrorModel? _registerErrors;
  DKRegisterErrorModel? get registerErrors => _registerErrors;

  void init() {
    _credentialsModel = null;
    _registerErrors = null;
    notifyListeners();
  }

  void initialize() {
    _credentialsModel = null;
    _registerErrors = null;
    _username = "";
    _password = "";
    _confirmPassword = "";
    _confirmPhoneNumber = "";
    _phoneNumber = "";
    notifyListeners();
  }
}
