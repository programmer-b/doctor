import 'package:doctor/screens/MLAuthenticationScreen.dart';
import 'package:doctor/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:nb_utils/nb_utils.dart' hide Loader;
import 'package:doctor/screens/MLUpdateProfileScreen.dart';
import 'package:doctor/utils/MLColors.dart';
import 'package:doctor/utils/MLCommon.dart';
import 'package:doctor/utils/MLImage.dart';
import 'package:doctor/utils/MLString.dart';
import 'package:doctor/main.dart';
import 'package:provider/provider.dart';

class MLConfirmPhoneNumberScreen extends StatefulWidget {
  static String tag = '/MLConfirmPhoneNumberScreen';

  @override
  _MLConfirmPhoneNumberScreenState createState() =>
      _MLConfirmPhoneNumberScreenState();
}

class _MLConfirmPhoneNumberScreenState
    extends State<MLConfirmPhoneNumberScreen> {
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
    Loader.hide();
    // changeStatusColor(mlPrimaryColor);
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
    changeStatusColor(appStore.isDarkModeOn ? scaffoldDarkColor : white);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 24.0),
            decoration: boxDecorationWithRoundedCorners(
                backgroundColor: context.cardColor),
            padding: EdgeInsets.all(16.0),
            height: context.height(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  56.height,
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: commonCachedNetworkImage(
                      ml_ic_verifyindicator!,
                      alignment: Alignment.centerLeft,
                      width: 200,
                      height: 200,
                    ),
                  ),
                  32.height,
                  Text(mlContact_msg!, style: boldTextStyle(size: 24)),
                  8.height,
                  Text(mlContact_sub_msg!, style: secondaryTextStyle(size: 16)),
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
                      ).expand()
                    ],
                  ),
                  24.height,
                  AppButton(
                    width: double.infinity,
                    color: mlColorDarkBlue,
                    onTap: () => MLAuthenticationScreen().launch(context),
                    child: Text(mlSend!, style: boldTextStyle(color: white)),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: 30,
              child: mlBackToPrevious(
                  context, appStore.isDarkModeOn ? white : blackColor)),
        ],
      ),
    );
  }
}
