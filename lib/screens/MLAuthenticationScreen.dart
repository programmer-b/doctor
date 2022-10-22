import 'dart:async';
import 'dart:developer';

import 'package:doctor/screens/MLUpdateProfileScreen.dart';
import 'package:doctor/services/networking.dart';
import 'package:doctor/state/appstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart' hide OTPTextField hide Loader hide log;
import 'package:doctor/utils/MLColors.dart';
import 'package:doctor/utils/MLCommon.dart';
import 'package:doctor/utils/MLString.dart';
import 'package:doctor/main.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

class MLAuthenticationScreen extends StatefulWidget {
  const MLAuthenticationScreen({Key? key}) : super(key: key);
  static String tag = '/MLAuthenticationScreen';

  @override
  _MLAuthenticationScreenState createState() => _MLAuthenticationScreenState();
}

class _MLAuthenticationScreenState extends State<MLAuthenticationScreen> {
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 117;

  var duration = const Duration(minutes: 1);

  bool timerExpired = false;

  bool showTimer = true;

  @override
  void initState() {
    super.initState();

    init();
  }

  late final _code;
  Future<void> init() async {
    _code = TextEditingController();
    await SmsAutoFill().listenForCode;
  }

  @override
  void dispose() {
    super.dispose();
    _code.dispose();
  }

  void onEnd() => context.read<AppState>().rebuildTimer();

  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Networking>(context);
    provider.isLoading ? Loader.show(context) : Loader.hide();
    final appState = Provider.of<AppState>(context);

    phoneNumber = appState.authCredentials?['data']?['phone number'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verify phone',
          style: boldTextStyle(color: appStore.appBarTextColor),
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                appStore.isDarkModeOn ? Brightness.light : Brightness.dark),
        backgroundColor: appStore.appBarColor,
      ),
      backgroundColor: appStore.scaffoldBackground,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                32.height,
                Text(mlEnter_code!, style: boldTextStyle(size: 24)),
                8.height,
                // ignore: deprecated_member_use
                createRichText(list: [
                  TextSpan(
                      text: mlAuthentication_msg!, style: secondaryTextStyle()),
                  TextSpan(
                      text: phoneNumber,
                      style: boldTextStyle(color: mlColorDarkBlue)),
                ]),
                16.height,
                otpField(appState.authCredentials?['data']?['token'] ?? '',
                    appState),
                24.height,
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(mlHave_no_code!, style: primaryTextStyle()),
                          8.width,
                          TextButton(
                            child: Text('RESEND'),
                            onPressed: appState.otpTimerExpired
                                ? () {
                                    appState.rebuildTimer();
                                    resendOtp(provider, appState);
                                  }
                                : null,
                          ),
                        ],
                      ),
                      Builder(builder: (context) {
                        return appState.otpTimerExpired
                            ? const Center()
                            : TweenAnimationBuilder<Duration>(
                                duration: appState.otpTimerDuration,
                                tween: Tween(
                                    begin: appState.otpTimerDuration,
                                    end: Duration.zero),
                                onEnd: onEnd,
                                builder: (BuildContext context, Duration value,
                                    Widget? child) {
                                  final minutes = value.inMinutes;
                                  final seconds = value.inSeconds % 60;
                                  return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Text('$minutes:$seconds',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30)));
                                });
                      }),
                    ]),
                24.height,
                AppButton(
                  width: double.infinity,
                  color: mlColorDarkBlue,
                  onTap: () {
                    if (_code.text.length != 6) {
                      toastError(error: 'Invalid OTP');
                    } else {
                      submitCode(
                          context,
                          provider,
                          _code.text,
                          appState.authCredentials?['data']?['token'] ?? '',
                          appState);
                    }
                  },
                  child: Text(mlDone!, style: boldTextStyle(color: white)),
                ),
              ],
            ).paddingAll(16.0),
          ),
        ],
      ),
    );
  }

  Widget otpField(token, AppState appState) => Consumer<Networking>(
        builder: (context, provider, child) {
          return PinFieldAutoFill(
            controller: _code,
            onCodeSubmitted: (code) async =>
                submitCode(context, provider, code, token, appState),
            decoration: BoxLooseDecoration(
              strokeColorBuilder:
                  FixedColorBuilder(Colors.black.withOpacity(0.3)),
            ),
          );
        },
      );

  Future<void> resendOtp(provider, AppState state) async {
    int user_id = state.authCredentials?["data"]["user_id"] ?? 0;
    final String mobileNumber = state.authCredentials?["data"]["phone number"];
    await provider.init();
    await provider.postForm(
        uri: Uri.parse(resendOTP),
        body: {"user_id": "$user_id", "mobile_number": mobileNumber});
  }

  Future<void> submitCode(
      context, provider, code, token, AppState appState) async {
    hideKeyboard(context);
    int user_id = appState.authCredentials?["data"]["user_id"] ?? 0;
    log("USER ID $user_id");
    await provider.init();
    await provider.postForm(
        uri: Uri.parse(verifyOTP),
        body: {"OTP": "$code", "user_id": '$user_id'});
    if (provider.success) {
      MLUpdateProfileScreen().launch(context,
          isNewTask: true, pageRouteAnimation: PageRouteAnimation.Slide);
    } else {
      toastError(error: provider.failureMap['errors']);
    }
  }
}
