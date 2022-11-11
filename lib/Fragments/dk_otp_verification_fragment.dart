import 'package:afyadaktari/Commons/dk_colors.dart';
import 'package:afyadaktari/Commons/dk_keys.dart';
import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:afyadaktari/Components/dk_otp_count_down_component.dart';
import 'package:afyadaktari/Fragments/dk_profile_fragment.dart';
import 'package:afyadaktari/Fragments/dk_register_fragment.dart';
import 'package:afyadaktari/Provider/dk_auth_ui_state.dart';
import 'package:afyadaktari/Provider/dk_otp_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:timer_count_down/timer_controller.dart';

class DKOTPVerificationFragment extends StatefulWidget {
  const DKOTPVerificationFragment(
      {super.key, this.onPop = const DKRegisterFragment(), this.resend});
  final Widget onPop;
  final bool? resend;

  @override
  State<DKOTPVerificationFragment> createState() =>
      _DKOTPVerificationFragmentState();
}

class _DKOTPVerificationFragmentState extends State<DKOTPVerificationFragment> {
  late final CountdownController _countdownController = CountdownController();
  late Widget onPop = widget.onPop;
  late String phoneNumber;

  late bool resend = widget.resend ?? false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    phoneNumber = getStringAsync(keyMobile);

    await SmsAutoFill().getAppSignature;
    await SmsAutoFill().listenForCode();
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
    await SmsAutoFill().unregisterListener();
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
                  EasyLoading.showSuccess("Phone number successfully verified");
                  if (mounted) {
                    context
                        .read<DkAuthUiState>()
                        .switchFragment(const DKProfileFragment());
                  }
                }
              }

              return PinFieldAutoFill(
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
            DKOTPCountDownComponent(controller: _countdownController)
          ],
        ),
      ),
    );
  }
}
