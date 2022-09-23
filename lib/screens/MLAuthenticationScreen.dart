import 'dart:async';

import 'package:doctor/screens/MLDashboardScreen.dart';
import 'package:doctor/screens/MLUpdateProfileScreen.dart';
import 'package:doctor/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart' hide OTPTextField hide Loader;
import 'package:doctor/utils/MLColors.dart';
import 'package:doctor/utils/MLCommon.dart';
import 'package:doctor/utils/MLString.dart';
import 'package:doctor/main.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';

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

  Duration get duration => controller.duration! * controller.value;

  bool get expired => duration.inSeconds == 0;
  int endTime = DateTime.now().millisecond + 1000 * 30;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    );
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void dispose() {
    super.dispose();
    Loader.hide();
    changeStatusColor(appStore.isDarkModeOn ? scaffoldDarkColor : white);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Networking>(context);
    provider.isLoading ? Loader.show(context) : Loader.hide();
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
                      text: phoneNumber!,
                      style: boldTextStyle(color: mlColorDarkBlue)),
                ]),
                16.height,
                otpField(),
                24.height,
                Row(
                  children: [
                    Text(mlHave_no_code!, style: primaryTextStyle()),
                    8.width,
                    Text(
                      'Re-send',
                      style: boldTextStyle(
                          color: mlColorDarkBlue,
                          decoration: TextDecoration.underline),
                    ),
                    Text('01:58', textAlign: TextAlign.right).expand()
                  ],
                ),
                24.height,
                AppButton(
                  width: double.infinity,
                  color: mlColorDarkBlue,
                  onTap: () {
                    return MLUpdateProfileScreen().launch(context);
                    // setState(() {
                    //   buttonOpacity = 0.0;
                    //   buttonHeight = 0.0;
                    //   containerOpacity = 1.0;
                    // });
                  },
                  child: Text(mlDone!, style: boldTextStyle(color: white)),
                ),

                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: <Widget>[
                //     Divider(height: 0.5),
                //     32.height,
                //     Text(mlAdd_password!, style: boldTextStyle(size: 20)),
                //     8.height,
                //     AppTextField(
                //       textFieldType: TextFieldType.PASSWORD,
                //       decoration: InputDecoration(
                //         labelText: mlPassword!,
                //         labelStyle: secondaryTextStyle(size: 16),
                //         prefixIcon: Icon(Icons.lock_outline,
                //             size: 20,
                //             color: appStore.isDarkModeOn ? white : black),
                //         enabledBorder: UnderlineInputBorder(
                //           borderSide: BorderSide(
                //               color: mlColorLightGrey.withOpacity(0.2)),
                //         ),
                //       ),
                //     ),
                //     16.height,
                //     AppTextField(
                //       textFieldType: TextFieldType.PASSWORD,
                //       decoration: InputDecoration(
                //         labelText: mlReenter_password!,
                //         labelStyle: secondaryTextStyle(size: 16),
                //         prefixIcon: Icon(Icons.lock_outline,
                //             size: 20,
                //             color: appStore.isDarkModeOn ? white : black),
                //         enabledBorder: UnderlineInputBorder(
                //           borderSide: BorderSide(
                //               color: mlColorLightGrey.withOpacity(0.2)),
                //         ),
                //       ),
                //     ),
                //     32.height,
                //     AppButton(
                //       width: double.infinity,
                //       color: mlColorDarkBlue,
                //       onTap: () {
                //         // finish(context);
                //         // finish(context);
                //         return MLUpdateProfileScreen().launch(context);
                //       },
                //       child:
                //           Text(mlDone!, style: boldTextStyle(color: white)),
                //     ),
                //   ],
                // )
                // .opacity(opacity: containerOpacity)
                // ,
              ],
            ).paddingAll(16.0),
          ),
        ],
      ),
    );
  }

  Widget otpField() {
    return Wrap(
      children: <Widget>[
        OTPTextField(
          length: 6,
          width: double.infinity,
          fieldWidth: 35,
          style: boldTextStyle(size: 24),
          textFieldAlignment: MainAxisAlignment.spaceBetween,
          fieldStyle: FieldStyle.underline,
          onCompleted: (pin) {
            print("Completed: " + pin);
          },
        ),
      ],
    );
  }
}
