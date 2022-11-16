import 'dart:developer';

import 'package:afyadaktari/Commons/dk_colors.dart';
import 'package:afyadaktari/Commons/dk_keys.dart';
import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:afyadaktari/Components/dk_otp_count_down_component.dart';
import 'package:afyadaktari/Fragments/auth/dk_profile_fragment.dart';
import 'package:afyadaktari/Fragments/auth/dk_register_fragment.dart';
import 'package:afyadaktari/Functions/global_functions.dart';
import 'package:afyadaktari/Provider/dk_auth_ui_state.dart';
import 'package:afyadaktari/Provider/dk_otp_data_provider.dart';
import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart' hide log;
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:timer_count_down/timer_controller.dart';

class DKOTPVerificationFragment extends StatefulWidget {
  const DKOTPVerificationFragment(
      {super.key,
      this.onPop = const DKRegisterFragment(),
      this.resend,
      this.onSuccessWidget = const DKProfileFragment(),
      this.hidePhone = true});
  final Widget onPop;
  final Widget onSuccessWidget;
  final bool? resend;
  final bool hidePhone;

  @override
  State<DKOTPVerificationFragment> createState() =>
      _DKOTPVerificationFragmentState();
}

class _DKOTPVerificationFragmentState extends State<DKOTPVerificationFragment> {
  late final CountdownController _countdownController = CountdownController();
  late Widget onPop = widget.onPop;
  late String phoneNumber;
  late Widget onSuccessWidget = widget.onSuccessWidget;
  late bool hidePhone = widget.hidePhone;

  late bool resend = widget.resend ?? false;

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    init();
  }

  String _comingSms = 'Unknown';

  Future<void> initSmsListener() async {
    String? comingSms;
    try {
      comingSms = await AltSmsAutofill().listenForSms;
    } on PlatformException {
      comingSms = 'Failed to get Sms.';
    }
    if (!mounted) return;
    setState(() {
      if (comingSms != null) {
        _comingSms = comingSms;
        log("====>Message: $_comingSms");
        // Pattern mPattern = Pattern.compile("(|^)\\d{6}");

        List<String> chars = _comingSms.split('');

        chars.removeWhere((item) => !isNumber(item));

        final otp = chars.join().substring(0, 6);

        log("OTP: is $otp");
        // log(_comingSms[32]);
        _controller.text = otp;
      } //used to set the code in the message to a string and setting it to a textcontroller. message length is 38. so my code is in string index 32-37.
    });
  }

  Future<void> init() async {
    _controller = TextEditingController();
    initSmsListener();
    phoneNumber = getStringAsync(keyMobile);

    if (hidePhone && phoneNumber != "") {
      List<String> phoneDigits = phoneNumber.split('');

      int length = phoneDigits.length;

      int start = length - 6;
      int end = length - 2;

      phoneDigits.replaceRange(start, end, ["*", "*", "*", "*"]);

      phoneNumber = phoneDigits.join();
    }

    // await SmsAutoFill().getAppSignature;
    // await SmsAutoFill().listenForCode();
    if (!resend) {
      await 0.seconds.delay;
      if (mounted) {
        context.read<DKOTPDataProvider>().initialize();
      }

      _countdownController.start();
    } else {
      await resendOTP();
    }
  }

  Future<void> resendOTP() async {
    await 0.seconds.delay;
    if (mounted) {
      await context.read<DKOTPDataProvider>().resend();
      _countdownController.start();
    }
  }

  @override
  void dispose() {
    super.dispose();
    disp();
  }

  Future<void> disp() async {
    await AltSmsAutofill().unregisterListener();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DKOTPDataProvider>();
    final otpErrors = provider.otpErrors;

    return WillPopScope(
      onWillPop: () async {
        context.read<DkAuthUiState>().switchFragment(onPop);
        return false;
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                dkOTPverifyTitle,
                style: boldTextStyle(color: dkPrimaryTextColor, size: 22),
              ),
            ),
            8.height,
            Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: dkOTPHeaderText, style: primaryTextStyle()),
                    TextSpan(
                        text: phoneNumber,
                        style: boldTextStyle(color: dkPrimaryColor))
                  ],
                ),
              ),
            ),
            32.height,
            Builder(builder: (context) {
              Future<void> submitCode(code) async {
                hideKeyboard(context);
                await context.read<DKOTPDataProvider>().submit(code);
                if (provider.success) {
                  if (mounted) {
                    context
                        .read<DkAuthUiState>()
                        .switchFragment(onSuccessWidget);
                  }
                }
              }

              return PinFieldAutoFill(
                controller: _controller,
                textInputAction: TextInputAction.done,
                decoration: UnderlineDecoration(
                    colorBuilder: FixedColorBuilder(
                        otpErrors == null ? Colors.black54 : Colors.red),
                    textStyle: boldTextStyle(color: dkPrimaryTextColor)),
                onCodeSubmitted: (code) {
                  submitCode(code);
                },
                onCodeChanged: (code) async {
                  await 0.seconds.delay;
                  // if (mounted) {
                  //   context.watch<DKOTPDataProvider>().setOTP(code);
                  // }
                  // _countdownController.pause();
                  if (code != null) {
                    if (code.length == 6) {
                      submitCode(code);
                    }
                  }
                },
              );
            }),
            if (otpErrors != null)
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    6.height,
                    Text(
                      otpErrors.errors?.oTP?.join(" , ") ?? "",
                      style: primaryTextStyle(color: Colors.red, size: 14),
                    ),
                  ],
                ),
              ),
            22.height,
            DKOTPCountDownComponent(controller: _countdownController),
          ],
        ),
      ),
    );
  }
}
