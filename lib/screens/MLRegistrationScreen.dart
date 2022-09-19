import 'package:doctor/screens/MLConfirmPhoneNumberScreen.dart';
import 'package:doctor/screens/MLLoginScreen.dart';
import 'package:doctor/screens/MLUpdateProfileScreen.dart';
import 'package:doctor/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:nb_utils/nb_utils.dart' hide Loader;
import 'package:doctor/utils/MLColors.dart';
import 'package:doctor/utils/MLCommon.dart';
import 'package:doctor/utils/MLImage.dart';
import 'package:doctor/utils/MLString.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class MLRegistrationScreen extends StatefulWidget {
  static String tag = '/MLRegistrationScreen';

  @override
  _MLRegistrationScreenState createState() => _MLRegistrationScreenState();
}

class _MLRegistrationScreenState extends State<MLRegistrationScreen> {
  String usernameCache = '';
  String emailCache = '';

  final registerFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    usernameCache = await getStringAsync("username");
    emailCache = await getStringAsync("email");
  }

  @override
  void dispose() {
    super.dispose();
    Loader.hide();
  }

  String? extractError(Networking provider, String name) {
    try {
      final error = provider.failureMap["errors"][name][0];

      return error;
    } catch (e) {
      return "";
    }
  }

  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final username = TextEditingController();
 
  

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Networking>(context);
    provider.isLoading ? Loader.show(context) : Loader.hide();

    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 250),
              padding: EdgeInsets.only(right: 16.0, left: 16.0),
              decoration: boxDecorationWithRoundedCorners(
                borderRadius: radiusOnly(topRight: 32),
                backgroundColor: context.cardColor,
              ),
              height: context.height(),
              child: SingleChildScrollView(
                child: Form(
                  key: registerFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      48.height,
                      Text(mlRegister!, style: boldTextStyle(size: 28)),
                      8.height,
                      Text('Register to continue',
                          style: secondaryTextStyle(size: 16)),
                      16.height,
                      Row(
                        children: [
                          AppTextField(
                            controller: username,
                            textFieldType: TextFieldType.NAME,
                            decoration: InputDecoration(
                              labelText: mlUsername!,
                              labelStyle: secondaryTextStyle(size: 16),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: mlColorLightGrey.withOpacity(0.2),
                                    width: 1),
                              ),
                            ),
                            validator: (value) {
                              final error = extractError(provider, "username");

                              if (error?.isNotEmpty ?? false) {
                                return error;
                              }

                              return null;
                            },
                          ).expand(),
                        ],
                      ),
                      16.height,
                      // Row(
                      //   children: [
                      //     AppTextField(
                      //       validator: (value) {
                      //         // if (!value.validatePhone()) {
                      //         //   return "Please enter a valid phone number.";
                      //         // }
                      //         final error = extractError(provider, "phone");

                      //         if (error?.isNotEmpty ?? false) {
                      //           return error;
                      //         }

                      //         return null;
                      //       },
                      //       controller: phoneNumber,
                      //       textFieldType: TextFieldType.PHONE,
                      //       decoration: InputDecoration(
                      //         prefix: Row(
                      //           mainAxisSize: MainAxisSize.min,
                      //           children: [
                      //             Text('+254', style: boldTextStyle(size: 14)),
                      //             6.width,
                      //             Icon(
                      //               Icons.keyboard_arrow_down,
                      //               size: 16,
                      //             ),
                      //           ],
                      //         ),
                      //         labelText: mlPhoneNumber!,
                      //         labelStyle: secondaryTextStyle(size: 16),
                      //         enabledBorder: UnderlineInputBorder(
                      //             borderSide: BorderSide(
                      //                 color:
                      //                     mlColorLightGrey.withOpacity(0.2))),
                      //       ),
                      //     ).expand()
                      //   ],
                      // ),
                      // 16.height,
                      AppTextField(
                        controller: password,
                        textFieldType: TextFieldType.PASSWORD,
                        decoration: InputDecoration(
                          labelText: mlPassword!,
                          labelStyle: secondaryTextStyle(size: 16),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: mlColorLightGrey.withOpacity(0.2)),
                          ),
                        ),
                        validator: (value) {
                          final error = extractError(provider, "password");
                          if (error?.isNotEmpty ?? false) {
                            return error;
                          }

                          return null;
                        },
                      ),
                      16.height,
                      AppTextField(
                        controller: confirmPassword,
                        textFieldType: TextFieldType.PASSWORD,
                        decoration: InputDecoration(
                          labelText: mlReenter_password!,
                          labelStyle: secondaryTextStyle(size: 16),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: mlColorLightGrey.withOpacity(0.2)),
                          ),
                        ),
                        validator: (value) {
                          if (value!.trim() != password.text.trim()) {
                            return "password does not match";
                          }
                          final error = extractError(provider, "password");
                          if (error?.isNotEmpty ?? false) {
                            return error;
                          }

                          return null;
                        },
                      ),
                      32.height,
                      AppButton(
                        width: double.infinity,
                        color: mlPrimaryColor,
                        onTap: () async {
                          return MLConfirmPhoneNumberScreen().launch(context);
                          // hideKeyboard(context);
                          // await provider.init();
                          // if (registerFormKey.currentState!.validate()) {
                          //   await provider.postForm(body: {
                          //     "username": username.text.trim(),
                          //     "email": email.text.trim(),
                          //     "password": password.text.trim()
                          //   }, uri: Uri.parse(registerUrl));
                          // }

                          // if (registerFormKey.currentState!.validate()) {
                          //   if (provider.success) {
                          //     return MLUpdateProfileScreen().launch(context,
                          //         pageRouteAnimation: PageRouteAnimation.Slide);
                          //   }
                          // }
                        },
                        child: Text(mlRegister!,
                            style: boldTextStyle(color: white)),
                      ),
                      22.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(ml_have_account!, style: primaryTextStyle()),
                          8.width,
                          Text(
                            mlLogin!,
                            style: boldTextStyle(
                                color: mlColorBlue,
                                decoration: TextDecoration.underline),
                          ).onTap(
                            () => MLLoginScreen().launch(context,
                                pageRouteAnimation: PageRouteAnimation.Scale),
                          ),
                        ],
                      ),
                      32.height,
                      // Align(
                      //   alignment: Alignment.center,
                      //   child: Text(mlLogin_with!,
                      //       style: secondaryTextStyle(size: 16)),
                      // ),
                      // 20.height,
                      // MLSocialAccountsComponent(),
                      // 32.height,
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 75),
              width: double.infinity,
              child: commonCachedNetworkImage(ml_ic_register_indicator!,
                  alignment: Alignment.center, width: 200, height: 200),
            ),
            Positioned(top: 30, child: mlBackToPrevious(context, whiteColor)),
          ],
        ).center(),
      ),
    );
  }
}
