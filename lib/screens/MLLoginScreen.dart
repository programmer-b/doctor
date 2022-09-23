import 'package:doctor/screens/MLDashboardScreen.dart';
import 'package:doctor/screens/MLUpdateProfileScreen.dart';
import 'package:doctor/services/networking.dart';
import 'package:doctor/state/appstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:nb_utils/nb_utils.dart' hide Loader;
import 'package:doctor/screens/MLForgetPasswordScreen.dart';
import 'package:doctor/screens/MLRegistrationScreen.dart';
import 'package:doctor/utils/MLColors.dart';
import 'package:doctor/utils/MLString.dart';
import 'package:doctor/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class MLLoginScreen extends StatefulWidget {
  const MLLoginScreen({Key? key, this.phoneNumber = ''}) : super(key: key);
  static String tag = '/MLLoginScreen';
  final String phoneNumber;

  @override
  _MLLoginScreenState createState() => _MLLoginScreenState();
}

class _MLLoginScreenState extends State<MLLoginScreen> {
  String usernameCache = '';

  final loginFormKey = GlobalKey<FormState>();
  late TextEditingController phoneNumber;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    super.dispose();
    Loader.hide();
  }

  Future<void> init() async {
    // ;
    phoneNumber = TextEditingController(text: widget.phoneNumber);
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

  Future<void> setupProfile(
      Networking provider, Map<String, dynamic>? credentials) async {
    await provider.get(
        uri: Uri.parse(getProfile + credentials?['data']['user_id'] ?? ''),
        token: credentials?['data']['token'] ?? '');
    if (provider.success) {
      if (provider.successMap.isNotEmpty) {
        MLDashboardScreen().launch(context,
            pageRouteAnimation: PageRouteAnimation.Slide, isNewTask: true);
      } else {
        MLUpdateProfileScreen().launch(context,
            pageRouteAnimation: PageRouteAnimation.Scale, isNewTask: true);
      }
    } else {
      toast('Check your connection and try again');
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Networking>(context);
    final appState = Provider.of<AppState>(context);
    provider.isLoading ? Loader.show(context) : Loader.hide();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: boldTextStyle(color: appStore.appBarTextColor),
        ),
        backgroundColor: appStore.appBarColor,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                appStore.isDarkModeOn ? Brightness.light : Brightness.dark),
      ),
      backgroundColor: appStore.scaffoldBackground,
      body: SingleChildScrollView(
        child: Form(
          key: loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              60.height,
              Text('Enter your phone number and password',
                  style: boldTextStyle(size: 16)),
              16.height,
              Row(
                children: [
                  // MLCountryPickerComponent(),
                  // 16.width,
                  AppTextField(
                    validator: (value) {
                      // if (value != null) {
                      //   if (value.length < 9) {
                      //     return "Please enter a valid phone number.";
                      //   }
                      // }
                      final error = extractError(provider, "mobile");

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
              AppTextField(
                controller: password,
                readOnly: provider.isLoading,
                textFieldType: TextFieldType.PASSWORD,
                decoration: InputDecoration(
                  labelText: mlPassword!,
                  labelStyle: secondaryTextStyle(size: 16),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: mlColorLightGrey.withOpacity(0.2)),
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
              8.height,
              Align(
                alignment: Alignment.topRight,
                child: Text(mlForget_password!,
                        style: secondaryTextStyle(size: 16))
                    .onTap(
                  () => MLForgetPasswordScreen().launch(context),
                ),
              ),
              24.height,
              AppButton(
                color: mlPrimaryColor,
                width: double.infinity,
                onTap: () async {
                  // MLDashboardScreen().launch(context,
                  //     pageRouteAnimation: PageRouteAnimation.Scale,
                  //     isNewTask: true);
                  hideKeyboard(context);
                  await provider.init();
                  await provider.postForm(body: {
                    "mobile": '0' + phoneNumber.text.trim(),
                    "password": password.text.trim()
                  }, uri: Uri.parse(loginUrl));

                  if (loginFormKey.currentState!.validate()) {
                    if (provider.success) {
                      await setValue('auth', provider.successMap);
                      appState.initializeAuthInfo(provider.successMap);
                      //if has not update profile
                      //pull profile data here, if it does not exist take to [MLProfileFormComponent]
                      await setupProfile(provider, provider.successMap);
                    }
                  }
                },
                child: Text(mlLogin!, style: boldTextStyle(color: white)),
              ),
              22.height,
              // Text(mlLogin_with!, style: secondaryTextStyle(size: 16)).center(),
              // 22.height,
              // MLSocialAccountsComponent(),
              // 22.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(mlDont_have_account!, style: primaryTextStyle()),
                  8.width,
                  Text(
                    mlRegister!,
                    style: boldTextStyle(
                        color: mlColorBlue,
                        decoration: TextDecoration.underline),
                  ).onTap(
                    () => MLRegistrationScreen().launch(context,
                        pageRouteAnimation: PageRouteAnimation.Slide),
                  ),
                ],
              ),
              32.height,
            ],
          ).paddingOnly(left: 16, right: 16),
        ),
      ),
    );
  }
}
