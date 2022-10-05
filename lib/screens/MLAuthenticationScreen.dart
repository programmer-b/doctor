import 'dart:async';

import 'package:doctor/screens/MLDashboardScreen.dart';
import 'package:doctor/screens/MLUpdateProfileScreen.dart';
import 'package:doctor/services/networking.dart';
import 'package:doctor/state/appstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:nb_utils/nb_utils.dart' hide OTPTextField hide Loader;
import 'package:doctor/utils/MLColors.dart';
import 'package:doctor/utils/MLCommon.dart';
import 'package:doctor/utils/MLString.dart';
import 'package:doctor/main.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'MLLoginScreen.dart';

class MLAuthenticationScreen extends StatefulWidget {
  static String tag = '/MLAuthenticationScreen';

  @override
  _MLAuthenticationScreenState createState() => _MLAuthenticationScreenState();
}

class _MLAuthenticationScreenState extends State<MLAuthenticationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;


  double buttonOpacity = 1.0;
  double buttonHeight = 50.0;
  double containerOpacity = 0.0;

  String? phoneNumber = '+2547 2848 7928';

  Timer? countdownTimer;
  Duration otpExpiryTime = Duration(seconds: 120);

  bool timerExpired = false;

  void startTimer() => countdownTimer =
      Timer.periodic(Duration(seconds: 1), (timer) => setCountDown());
  void stopTimer() => setState(() => countdownTimer!.cancel());
  void resetTimer() {
    stopTimer();
    setState(() => otpExpiryTime = Duration(seconds: 120));
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = otpExpiryTime.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        timerExpired = true;
        countdownTimer!.cancel();
      } else {
        otpExpiryTime = Duration(seconds: seconds);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    init();
  }

  Future<void> init() async {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 118),
    );

    Future.delayed(Duration.zero, () => startTimer());
    await SmsAutoFill().listenForCode;
  }

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
                otpField(appState.authCredentials?['data']?['token']??''),
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
                            onPressed: timerExpired
                                ? () {
                                    //TODO: add method to resend OTP
                                    setState(() {
                                      timerExpired = false;
                                    });
                                    resetTimer();
                                    startTimer();
                                  }
                                : null,
                          ),
                        ],
                      ),
                      Text(
                          '${otpExpiryTime.inMinutes.remainder(60)} : ${otpExpiryTime.inSeconds.remainder(60)}'),
                    ]),
                24.height,
                AppButton(
                  width: double.infinity,
                  color: mlColorDarkBlue,
                  onTap: () {
                   if(_code.text.length != 6){
                     toastError(error: 'Invalid OTP');
                   }
                   else{
                     submitCode(context, provider, _code.text, appState.authCredentials?['data']?['token']??'');
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

  final _code = TextEditingController();

  Widget otpField(token) => Consumer<Networking>(
  builder: (context, provider, child) {
  return PinFieldAutoFill(
    controller: _code,
    onCodeSubmitted: (code) async => submitCode(context, provider, code, token),
        decoration: BoxLooseDecoration(
          strokeColorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
        ),
      );
  },
);

  Future<void> submitCode(context,provider,code,token) async {
    hideKeyboard(context);
   await  provider.init();
   await  provider.postForm(uri: Uri.parse(verifyOtp), body: {"otp":"$code"},token: token);
   if(provider.success){
     MLUpdateProfileScreen().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Slide);
   }
   else{
     toastError(error: provider.failureMap['errors']);
   }
  }
}
