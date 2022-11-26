import 'dart:convert';

import 'package:afyadaktari/Commons/dk_extensions.dart';
import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:afyadaktari/Commons/dk_urls.dart';
import 'package:afyadaktari/Models/auth/dk_mobile_error_model.dart';
import 'package:afyadaktari/Models/auth/dk_mobile_success_model.dart';
import 'package:afyadaktari/Utils/dk_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import '../Utils/dk_easy_loading.dart';

class DKMobileProvider extends ChangeNotifier {
  String _mobile = "";
  String get mobile => _mobile;

  void setMobile(mobile) {
    _mobile = mobile;
    notifyListeners();
  }

  Future<void> submitData() async {
    DKEasyLoading.show();

    _mobile = _mobile.trim();

    final body = {"mobile": _mobile};

    final uri = dkRequestPasswordReset.toUri;

    try {
      final response = await http.post(uri, body: body);
       if (response.statusCode >= 500) {
        DKToast.showErrorToast("Server Error");
      }
      if (response.ok) {
        _success = DKMobileSuccessModel.fromJson(jsonDecode(response.body));
        DKToast.toastTop(_success?.message ?? dkSuccess);
      } else {
        try {
          _errors = DKMobileErrorModel.fromJson(jsonDecode(response.body));
        } on Exception catch (e) {
          DKToast.showErrorToast(
            "$e : ${response.body}",
          );
        }
      }
    } on Exception catch (e) {
      DKToast.showErrorToast(e.toString());
    } finally {
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

  DKMobileErrorModel? _errors;
  DKMobileErrorModel? get errors => _errors;

  DKMobileSuccessModel? _success;
  DKMobileSuccessModel? get success => _success;

  void init() {
    _errors = null;
    _success = null;

    notifyListeners();
  }

  void initialize() {
    init();
    _mobile = "";
    notifyListeners();
  }
}
