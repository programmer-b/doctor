import 'dart:convert';
import 'dart:developer';

import 'package:afyadaktari/Commons/dk_extensions.dart';
import 'package:afyadaktari/Commons/dk_keys.dart';
import 'package:afyadaktari/Commons/dk_urls.dart';
import 'package:afyadaktari/Fragments/dk_otp_verification_fragment.dart';
import 'package:afyadaktari/Fragments/dk_profile_fragment.dart';
import 'package:afyadaktari/Models/dk_refresh_token_model.dart';
import 'package:afyadaktari/Models/dk_user_credentials_model.dart';
import 'package:afyadaktari/Models/dk_user_token_decode_model.dart';
import 'package:afyadaktari/Provider/dk_auth_ui_state.dart';
import 'package:afyadaktari/Screens/dk_auth_screen.dart';
import 'package:afyadaktari/Screens/dk_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart' hide log;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Future<bool> saveCredentials(
    {DKUserCredentialsModel? credentialsData,
    DKRefreshTokenModel? refreshedData}) async {
  assert((credentialsData != null && refreshedData == null) ||
      (credentialsData == null && refreshedData != null));

  String? token;
  String? mobile;
  int? userId;

  if (credentialsData != null) {
    token = credentialsData.data?.token;
    mobile = credentialsData.data?.phoneNumber;
    userId = credentialsData.data?.userId;
  } else if (refreshedData != null) {
    token = refreshedData.token;
    mobile = refreshedData.phoneNumber;
    userId = refreshedData.userId;
  }

  if (token != null && mobile != null && userId != null) {
    await setValue(keyToken, token);
    await setValue(keyMobile, mobile);
    await setValue(keyUserId, userId);

    return true;
  }

  return false;
}

Future<DKRefreshTokenModel?> refreshToken() async {
  final userId = getIntAsync(keyUserId);
  log("user_id: $userId");

  final uri = Uri.parse(dkRefreshUrl);
  log("URL: $uri");

  final Map<String, String> body = {keyUserId: "$userId"};

  try {
    final response = await http.post(uri, body: body);
    log("REFRESHED TOKEN: ${response.body}");

    if (response.ok && userId != 0 && response.body != "null") {
      final refreshTokenModel =
          DKRefreshTokenModel.fromJson(jsonDecode(response.body));

      final bool savedCredentials =
          await saveCredentials(refreshedData: refreshTokenModel);

      if (savedCredentials) {
        return DKRefreshTokenModel.fromJson(jsonDecode(response.body));
      } else {
        log("Couldn't save refresh credentials");
      }
    }
    log("Bad Response: ${response.body}");
    return null;
  } on Exception catch (e) {
    log("$e");
    return null;
  }
}

void analyzeCredentials(
    {required String token, required BuildContext context}) {
  final tokenData = decodeJWT(token);

  final bool mobileVerified = !(tokenData.usr?.mobileVerified?.isNull ?? true);
  final bool profileUpdated = !(tokenData.usr?.profileUpdated?.isNull ?? true);

  if (!mobileVerified) {
    log("mobile not verified");

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context
          .read<DkAuthUiState>()
          .switchFragment(const DKOTPVerificationFragment(
            resend: true,
          ));
      const DKAuthScreen().launch(context);
    });
  } else if (!profileUpdated) {
    log("profile not updated");

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DkAuthUiState>().switchFragment(const DKProfileFragment());
      const DKAuthScreen().launch(context);
    });
  } else {
    
    Future.delayed(Duration.zero,
        () => const DKHomeScreen().launch(context, isNewTask: true));
  }
}

DKUserTokenDecodeModel decodeJWT(String token) {
  final decoded = JwtDecoder.decode(token);
  if (decoded != null) {
    return DKUserTokenDecodeModel.fromJson(decoded);
  }
  throw "$token cannot be decoded";
}
