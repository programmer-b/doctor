import 'dart:convert';
import 'dart:developer';

import 'package:afyadaktari/Commons/dk_extensions.dart';
import 'package:afyadaktari/Commons/dk_keys.dart';
import 'package:afyadaktari/Commons/dk_urls.dart';
import 'package:afyadaktari/Functions/auth_functions.dart';
import 'package:afyadaktari/Models/auth/dk_otp_errors_model.dart';
import 'package:afyadaktari/Utils/dk_easy_loading.dart';
import 'package:afyadaktari/Utils/dk_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nb_utils/nb_utils.dart' hide log;
import 'package:http/http.dart' as http;

class DKOTPDataProvider extends ChangeNotifier {
  String _otp = "";
  String get otp => _otp;

  void setOTP(text) {
    _otp = text;
    notifyListeners();
  }

  Future<void> submit(code) async {
    DKEasyLoading.show();

    final int userId = getIntAsync(keyUserId);
    final token = getStringAsync(keyToken);

    final Map<String, String> body = {"user_id": "$userId", "OTP": code};
    final Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final uri = Uri.parse(dkVerifyUrl);

    try {
      final response = await http.post(uri, body: body, headers: headers);
      log(response.body);

      if (response.ok) {
        await refreshToken();
        _success = true;
        EasyLoading.showSuccess(
            jsonDecode(response.body)["message"] ?? "Success");
      } else {
        _otpErrors = DKOTPErrorsModel.fromJson(jsonDecode(response.body));
      }
    } on Exception catch (e) {
      DKToast.showErrorToast("$e");
      rethrow;
    } finally {
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

  Future<void> resend() async {
    init();
    DKEasyLoading.show();

    final userId = getIntAsync(keyUserId);
    final token = getStringAsync(keyToken);

    final Map<String, String> body = {"user_id": "$userId"};
    final Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final uri = Uri.parse(dkResendUrl);

    try {
      final response = await http.post(uri, body: body, headers: headers);
      log(response.body);
      if (response.ok) {
        EasyLoading.showSuccess(jsonDecode(response.body)["message"] ??
            "OTP sent to your phone successfully.");
      } else {}
      EasyLoading.dismiss();
    } on Exception catch (e) {
      EasyLoading.dismiss();
      DKToast.showErrorToast("$e");
      rethrow;
    }
  }

  bool _success = false;
  bool get success => _success;

  DKOTPErrorsModel? _otpErrors;
  DKOTPErrorsModel? get otpErrors => _otpErrors;

  void init() {
    _otpErrors = null;
    notifyListeners();
  }

  void initialize() {
    _otpErrors = null;
    _otp = "";
    notifyListeners();
  }
}
