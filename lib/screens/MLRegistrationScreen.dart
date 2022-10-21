import 'package:doctor/screens/MLConfirmPhoneNumberScreen.dart';
import 'package:doctor/screens/MLLoginScreen.dart';
import 'package:doctor/screens/MLUpdateProfileScreen.dart';
import 'package:doctor/services/networking.dart';
import 'package:doctor/state/appstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:nb_utils/nb_utils.dart' hide Loader;
import 'package:doctor/utils/MLColors.dart';
import 'package:doctor/utils/MLString.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'MLAuthenticationScreen.dart';

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
  final mobile = TextEditingController();
  final confirmMobile = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Networking>(context);
    provider.isLoading ? Loader.show(context) : Loader.hide();

    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
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
          key: registerFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              24.height,
              Text('Fill the information below to continue',
                  style: boldTextStyle(size: 16)),
              16.height,
              TextFormField(
                enableInteractiveSelection: false,
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
                controller: mobile,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.phone,
                  ),
                  labelText: mlPhoneNumber!,
                  labelStyle: secondaryTextStyle(size: 16),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: mlColorLightGrey)),
                ),
              ),
              16.height,
              TextFormField(
                enableInteractiveSelection: false,
                validator: (value) {
                  // if (value != null) {
                  //   if (value.length < 9) {
                  //     return "Please enter a valid phone number.";
                  //   }
                  // }
                  final error = extractError(provider, "confirm_mobile");

                  if (error?.isNotEmpty ?? false) {
                    return error;
                  }

                  return null;
                },
                controller: confirmMobile,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.phone,
                  ),
                  labelText: mlReenterPhone!,
                  labelStyle: secondaryTextStyle(size: 16),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: mlColorLightGrey)),
                ),
              ),
              16.height,
              TextFormField(
                enableInteractiveSelection: false,
                controller: username,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.person),
                  labelText: mlUsername!,
                  labelStyle: secondaryTextStyle(size: 16),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: mlColorLightGrey, width: 1),
                  ),
                ),
                validator: (value) {
                  final error = extractError(provider, "username");

                  if (error?.isNotEmpty ?? false) {
                    return error;
                  }

                  return null;
                },
              ),
              16.height,
              AppTextField(
                controller: password,
                textFieldType: TextFieldType.PASSWORD,
                decoration: InputDecoration(
                  labelText: mlPassword!,
                  labelStyle: secondaryTextStyle(size: 16),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: mlColorLightGrey),
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
                    borderSide: BorderSide(color: mlColorLightGrey),
                  ),
                ),
                validator: (value) {
                  final error = extractError(provider, "confirm_password");
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
                  hideKeyboard(context);
                  await provider.init();
                  await provider.postForm(body: {
                    "mobile": mobile.text.trim(),
                    "confirm_mobile": confirmMobile.text.trim(),
                    "username": username.text.trim(),
                    "password": password.text.trim(),
                    "confirm_password": confirmPassword.text.trim()
                  }, uri: Uri.parse(registerUrl));

                  if (registerFormKey.currentState!.validate()) {
                    if (provider.success) {
                      finish(context);
                      if (provider.successMap['data']['token'] == '') {
                        return MLLoginScreen(phoneNumber: mobile.text.trim())
                            .launch(context,
                                pageRouteAnimation: PageRouteAnimation.Scale);
                      }
                      await setValue("auth", provider.successMap);
                      appState.initializeAuthInfo(provider.successMap);
                      return MLAuthenticationScreen().launch(context,
                          pageRouteAnimation: PageRouteAnimation.Slide,
                          isNewTask: true);
                    }
                  }
                },
                child: Text('Confirm', style: boldTextStyle(color: white)),
              ),
              22.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(ml_have_account!, style: primaryTextStyle()),
                  8.width,
                  Text(
                    'Login',
                    style: boldTextStyle(
                        color: mlColorBlue,
                        decoration: TextDecoration.underline),
                  ).onTap(
                    () {
                      finish(context);
                      return MLLoginScreen().launch(
                        context,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ).paddingOnly(left: 16, right: 16),
    );
  }
}
