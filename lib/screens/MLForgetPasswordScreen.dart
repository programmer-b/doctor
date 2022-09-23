import 'package:doctor/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart' hide Loader;
import 'package:doctor/screens/MLAuthenticationScreen.dart';
import 'package:doctor/utils/MLColors.dart';
import 'package:doctor/utils/MLCommon.dart';
import 'package:doctor/utils/MLString.dart';
import 'package:doctor/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class MLForgetPasswordScreen extends StatefulWidget {
  static String tag = '/MLForgetPasswordScreen';

  @override
  _MLForgetPasswordScreenState createState() => _MLForgetPasswordScreenState();
}

class _MLForgetPasswordScreenState extends State<MLForgetPasswordScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    changeStatusColor(appStore.isDarkModeOn ? scaffoldDarkColor : white);
  }

  @override
  void dispose() {
    super.dispose();
    ;
  }

  String? extractError(Networking provider, String name) {
    try {
      final error = provider.failureMap["errors"][name][0];

      return error;
    } catch (e) {
      return "";
    }
  }

  final phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Networking>(context);
    provider.isLoading ? Loader.show(context) : Loader.hide();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 24.0),
            decoration: boxDecorationWithRoundedCorners(
                backgroundColor: context.cardColor),
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  80.height,
                  Text(mlForgetPassword!, style: boldTextStyle(size: 24)),
                  8.height,
                  Text(mlForget_password_msg!, style: secondaryTextStyle()),
                  16.height,
                  Row(
                    children: [
                      AppTextField(
                        validator: (value) {
                          // if (!value.validatePhone()) {
                          //   return "Please enter a valid phone number.";
                          // }
                          final error = extractError(provider, "phone");

                          if (error?.isNotEmpty ?? false) {
                            return error;
                          }

                          return null;
                        },
                        controller: phoneNumber,
                        textFieldType: TextFieldType.PHONE,
                        decoration: InputDecoration(
                          prefix: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('+254', style: boldTextStyle(size: 14)),
                              6.width,
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 16,
                              ),
                            ],
                          ),
                          labelText: mlPhoneNumber!,
                          labelStyle: secondaryTextStyle(size: 16),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: mlColorLightGrey.withOpacity(0.2))),
                        ),
                      ).expand(),
                    ],
                  ),
                  16.height,
                  AppButton(
                    width: double.infinity,
                    color: mlPrimaryColor,
                    onTap: () => MLAuthenticationScreen().launch(context),
                    child: Text('Send', style: boldTextStyle(color: white)),
                  ),
                ],
              ).paddingOnly(right: 16.0, left: 16.0),
            ),
          ),
          Positioned(
            top: 30,
            child: mlBackToPrevious(
                context, appStore.isDarkModeOn ? white : black),
          ),
        ],
      ),
    );
  }
}
