import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../Provider/dk_otp_data_provider.dart';

class DKOTPCountDownComponent extends StatefulWidget {
  const DKOTPCountDownComponent({super.key, required this.controller});
  final CountdownController controller;

  @override
  State<DKOTPCountDownComponent> createState() =>
      _DKOTPCountDownComponentState();
}

class _DKOTPCountDownComponentState extends State<DKOTPCountDownComponent> {
  @override
  Widget build(BuildContext context) {
    return Countdown(
      controller: widget.controller,
      seconds: 120,
      interval: const Duration(milliseconds: 1000),
      build: (context, currentRemainingTime) {
        if (currentRemainingTime == 0.0 || currentRemainingTime == 120) {
          return GestureDetector(
            onTap: () async {
              await context.read<DKOTPDataProvider>().resend();

              await widget.controller.restart();

              ///Resend OTP here
              setState(() {});
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 1),
                gradient: LinearGradient(
                    colors: [Colors.blue.shade400, Colors.blue.shade700],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
              width: context.width(),
              height: 50,
              child: const Text(
                "Resend OTP",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ).center(),
            ),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 1),
            ),
            width: context.width(),
            height: 50,
            child: Text(
              "${currentRemainingTime.ceil()}",
              style: boldTextStyle(),
            ).center(),
          );
        }
      },
    );
  }
}
