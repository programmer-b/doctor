import 'dart:async';

import 'package:doctor/screens/MLUpdateProfileScreen.dart';
import 'package:doctor/services/networking.dart';
import 'package:doctor/state/appstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:nb_utils/nb_utils.dart' hide OTPTextField hide Loader;
import 'package:doctor/utils/MLColors.dart';
import 'package:doctor/utils/MLCommon.dart';
import 'package:doctor/utils/MLString.dart';
import 'package:doctor/main.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

class MLAuthenticationScreen extends StatefulWidget {
  static String tag = '/MLAuthenticationScreen';

  @override
  _MLAuthenticationScreenState createState() => _MLAuthenticationScreenState();
}

class _MLAuthenticationScreenState extends State<MLAuthenticationScreen> {
  late CountdownTimerController controller;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 117;

  bool timerExpired = false;

  @override
  void initState() {
    super.initState();

    init();
  }

  late final _code;
  Future<void> init() async {
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
    _code = TextEditingController();
    await SmsAutoFill().listenForCode;
  }

  @override
  void dispose() {
    super.dispose();
    _code.dispose();
    controller.dispose();
  }

  void onEnd() {
    print('onEnd');
    setState(() {
      timerExpired = true;
    });
  }

  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Networking>(context);
    provider.isLoading ? Loader.show(context) : Loader.hide();
    final appState = Provider.of<AppState>(context);

    phoneNumber = appState.authCredentials?['data']?['mobile'] ?? '';

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
                otpField(appState.authCredentials?['data']?['token'] ?? ''),
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
                            onPressed: timerExpired ? () {
                              //Implement resend OTP
                            } : null,
                          ),
                        ],
                      ),
                      CountdownTimer(
                        controller: controller,
                        onEnd: onEnd,
                        endTime: endTime,
                        widgetBuilder: (_, CurrentRemainingTime? time) {
                          if (time == null) {
                            return Text('00:00');
                          }
                          return Text(
                              '0${time.min}:${time.sec}');
                        },
                      ),
                    ]),
                24.height,
                AppButton(
                  width: double.infinity,
                  color: mlColorDarkBlue,
                  onTap: () {
                    if (_code.text.length != 6) {
                      toastError(error: 'Invalid OTP');
                    } else {
                      submitCode(context, provider, _code.text,
                          appState.authCredentials?['data']?['token'] ?? '');
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

  Widget otpField(token) => Consumer<Networking>(
        builder: (context, provider, child) {
          return PinFieldAutoFill(
            controller: _code,
            onCodeSubmitted: (code) async =>
                submitCode(context, provider, code, token),
            decoration: BoxLooseDecoration(
              strokeColorBuilder:
                  FixedColorBuilder(Colors.black.withOpacity(0.3)),
            ),
          );
        },
      );

  Future<void> submitCode(context, provider, code, token) async {
    hideKeyboard(context);
    await provider.init();
    await provider.postForm(
        uri: Uri.parse(verifyOtp), body: {"otp": "$code"}, token: token);
    if (provider.success) {
      MLUpdateProfileScreen().launch(context,
          isNewTask: true, pageRouteAnimation: PageRouteAnimation.Slide);
    } else {
      toastError(error: provider.failureMap['errors']);
    }
  }
}
