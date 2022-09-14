import 'package:doctor/screens/MLUpdateProfileScreen.dart';
import 'package:doctor/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:doctor/utils/MLCommon.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:doctor/screens/MLForgetPasswordScreen.dart';
import 'package:doctor/screens/MLRegistrationScreen.dart';
import 'package:doctor/utils/MLColors.dart';
import 'package:doctor/utils/MLImage.dart';
import 'package:doctor/utils/MLString.dart';
import 'package:doctor/main.dart';
import 'package:provider/provider.dart';

class MLLoginScreen extends StatefulWidget {
  static String tag = '/MLLoginScreen';

  @override
  _MLLoginScreenState createState() => _MLLoginScreenState();
}

class _MLLoginScreenState extends State<MLLoginScreen> {
  String usernameCache = '';

  final loginFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    // changeStatusColor(mlPrimaryColor);
    usernameCache = await getStringAsync("username");
  }

  String extractError(Networking provider, String name) {
    try {
      final error = provider.failureMap["errors"][name][0];

      return error;
    } catch (e) {
      return "";
    }
  }

  final password = TextEditingController();
  final username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    changeStatusColor(mlPrimaryColor);

    final provider = Provider.of<Networking>(context);

    return Scaffold(
      backgroundColor: mlPrimaryColor,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 250),
            height: context.height(),
            decoration: boxDecorationWithRoundedCorners(
              borderRadius: radiusOnly(topRight: 32),
              backgroundColor: context.cardColor,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    60.height,
                    Text(mlLogin_title!, style: secondaryTextStyle(size: 16)),
                    16.height,
                    Row(
                      children: [
                        // MLCountryPickerComponent(),
                        // 16.width,
                        AppTextField(
                          controller: username,
                          readOnly: provider.isLoading,
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
                                extractError(provider, "username").toString();

                            if (error.isNotEmpty) {
                              return error;
                            }

                            return null;
                          },
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
                        prefixIcon: Icon(Icons.lock_outline,
                            color: appStore.isDarkModeOn ? white : black),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: mlColorLightGrey.withOpacity(0.2)),
                        ),
                      ),
                      validator: (value) {
                        final error =
                            extractError(provider, "password").toString();

                        if (error.isNotEmpty) {
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
                        hideKeyboard(context);
                        await provider.init();
                        await provider.postForm(body: {
                          "username": username.text.trim(),
                          "password": password.text.trim()
                        }, uri: Uri.parse(loginUrl));

                        if (loginFormKey.currentState!.validate()) {
                          if (provider.success) {
                            await setValue('auth', provider.successMap);
                            //if has not update profile
                            MLUpdateProfileScreen().launch(context,
                                isNewTask: true,
                                pageRouteAnimation: PageRouteAnimation.Slide);
                          }
                        }
                      },
                      child: provider.isLoading
                          ? Loader(
                              color: mlPrimaryColor,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            )
                          : Text(mlLogin!, style: boldTextStyle(color: white)),
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
                          () => provider.isLoading
                              ? null
                              : MLRegistrationScreen().launch(context,
                                  pageRouteAnimation: PageRouteAnimation.Slide),
                        ),
                      ],
                    ),
                    32.height,
                  ],
                ).paddingOnly(left: 16, right: 16),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 75),
            width: context.width(),
            child: commonCachedNetworkImage(ml_ic_register_indicator!,
                alignment: Alignment.center, width: 200, height: 200),
          ),
        ],
      ),
    );
  }
}
