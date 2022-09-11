import 'package:doctor/screens/MLLoginScreen.dart';
import 'package:doctor/screens/MLUpdateProfileScreen.dart';
import 'package:doctor/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
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
  late String usernameCache = '';
  late String emailCache = '';

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
  Widget build(BuildContext context) {
    final provider = Provider.of<Networking>(context);

    final username = TextEditingController(text: usernameCache);
    final email = TextEditingController(text: emailCache);
    final password = TextEditingController();
    final confirmPassword = TextEditingController();

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
                            readOnly: provider.isLoading,
                            controller: username,
                            textFieldType: TextFieldType.NAME,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.account_circle,
                                  color: appStore.isDarkModeOn ? white : black),
                              labelText: mlUsername!,
                              labelStyle: secondaryTextStyle(size: 16),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: mlColorLightGrey.withOpacity(0.2),
                                    width: 1),
                              ),
                            ),
                            validator: (value) {
                              final error =
                                  provider.failureMap["errors"]["username"];
                              if (error != null) {
                                return error;
                              }

                              return null;
                            },
                            onChanged: (value) async {
                              await setValue("username", value);
                            },
                          ).expand(),
                        ],
                      ),
                      16.height,
                      Row(
                        children: [
                          AppTextField(
                            readOnly: provider.isLoading,
                            controller: email,
                            textFieldType: TextFieldType.EMAIL,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.account_circle,
                                  color: appStore.isDarkModeOn ? white : black),
                              labelText: mlEmail!,
                              labelStyle: secondaryTextStyle(size: 16),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: mlColorLightGrey.withOpacity(0.2),
                                    width: 1),
                              ),
                            ),
                            validator: (value) {
                              if (!value.validateEmail()) {
                                return "Please enter a valid email";
                              }
                              final error =
                                  provider.failureMap["errors"]["email"];
                              if (error != null) {
                                return error;
                              }

                              return null;
                            },
                            onChanged: (value) async {
                              await setValue("email", value);
                            },
                          ).expand(),
                        ],
                      ),
                      16.height,
                      AppTextField(
                        readOnly: provider.isLoading,
                        controller: password,
                        textFieldType: TextFieldType.PASSWORD,
                        decoration: InputDecoration(
                          labelText: mlPassword!,
                          labelStyle: secondaryTextStyle(size: 16),
                          prefixIcon: Icon(Icons.lock_outline,
                              color: appStore.isDarkModeOn ? white : black),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: mlColorLightGrey.withOpacity(0.2)),
                          ),
                        ),
                        validator: (value) {
                          final error =
                              provider.failureMap["errors"]["password"];
                          if (error != null) {
                            return error;
                          }

                          return null;
                        },
                      ),
                      16.height,
                      AppTextField(
                        readOnly: provider.isLoading,
                        controller: confirmPassword,
                        textFieldType: TextFieldType.PASSWORD,
                        decoration: InputDecoration(
                          labelText: mlReenter_password!,
                          labelStyle: secondaryTextStyle(size: 16),
                          prefixIcon: Icon(Icons.lock_outline,
                              color: appStore.isDarkModeOn ? white : black),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: mlColorLightGrey.withOpacity(0.2)),
                          ),
                        ),
                        validator: (value) {
                          if (value != password.text) {
                            return "password does not match";
                          }
                          final error =
                              provider.failureMap["errors"]["password"];
                          if (error != null) {
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
                          hideKeyboard(context);

                          if (registerFormKey.currentState!.validate()) {
                            await provider.postForm(body: {
                              "username": username.text.trim(),
                              "email": email.text.trim(),
                              "password": password.text.trim()
                            }, uri: Uri.parse(loginUrl));
                          }

                          if (registerFormKey.currentState!.validate()) {
                            if (provider.success) {
                              return MLUpdateProfileScreen().launch(context,
                                  pageRouteAnimation: PageRouteAnimation.Slide);
                            }
                          }
                        },
                        child: provider.isLoading
                            ? Loader(
                                color: mlPrimaryColor,
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : Text(mlRegister!,
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
                            () => provider.isLoading
                                ? null
                                : MLLoginScreen().launch(context,
                                    pageRouteAnimation:
                                        PageRouteAnimation.Scale),
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
