import 'dart:convert';
import 'dart:developer';

import 'package:afyadaktari/Commons/dk_extensions.dart';
import 'package:afyadaktari/Commons/dk_urls.dart';
import 'package:afyadaktari/Models/auth/dk_login_error_model.dart';
import 'package:afyadaktari/Models/auth/dk_user_credentials_model.dart';
import 'package:afyadaktari/Utils/dk_easy_loading.dart';
import 'package:afyadaktari/Utils/dk_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class DKLoginDataProvider extends ChangeNotifier {
  String _usernameOrMobile = "";
  String get usernameOrPassword => _usernameOrMobile;

  void setUsernameOrPassword(String text) {
    _usernameOrMobile = text;
    notifyListeners();
  }

  String _password = "";
  String get password => _password;

  void setPassword(String text) {
    _password = text;
    notifyListeners();
  }

  bool _canShowPassword = true;
  bool get canShowPassword => _canShowPassword;

  void showPassword() {
    _canShowPassword = !_canShowPassword;
    notifyListeners();
  }

  Future<void> submitData() async {
    DKEasyLoading.show();

    _password = _password.trim();
    _usernameOrMobile = _usernameOrMobile.trim();

    final Map<String, String> body = {
      "username": _usernameOrMobile,
      "password": _password
    };

    final uri = Uri.parse(dkLoginUrl);

    try {
      final response = await http.post(uri, body: body);
      log(response.body);
      if (response.ok) {
        _credentialsModel =
            DKUserCredentialsModel.fromJson(jsonDecode(response.body));
      } else {
        _loginErrors = DKLoginErrorModel.fromJson(jsonDecode(response.body));
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

  DKLoginErrorModel? _loginErrors;
  DKLoginErrorModel? get loginErrors => _loginErrors;

  void init() {
    _credentialsModel = null;
    _loginErrors = null;
    notifyListeners();
  }

  void initialize() {
    _credentialsModel = null;
    _loginErrors = null;
    _usernameOrMobile = "";
    _password = "";
    notifyListeners();
  }
}
