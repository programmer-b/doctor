import 'package:afyadaktari/Commons/dk_colors.dart';
import 'package:afyadaktari/Commons/dk_keys.dart';
import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:afyadaktari/Fragments/auth/dk_login_fragment.dart';
import 'package:afyadaktari/Fragments/auth/dk_otp_verification_fragment.dart';
import 'package:afyadaktari/Fragments/auth/dk_password_fragment.dart';
import 'package:afyadaktari/Provider/dk_auth_ui_state.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../Components/dk_button_component.dart';
import '../../Components/dk_text_field.dart';

class DKForgotPasswordFragment extends StatefulWidget {
  const DKForgotPasswordFragment({super.key});

  @override
  State<DKForgotPasswordFragment> createState() =>
      _DKForgotPasswordFragmentState();
}

final GlobalKey<FormState> _forgotPasswordFormKey = GlobalKey<FormState>();

class _DKForgotPasswordFragmentState extends State<DKForgotPasswordFragment> {
  String? _validate() => null;

  @override
  Widget build(BuildContext context) {
    void backToLogin() =>
        context.read<DkAuthUiState>().switchFragment(const DKLoginFragment());
    return WillPopScope(
      onWillPop: () async {
        backToLogin();
        return false;
      },
      child: SizedBox(
        width: context.width(),
        child: Form(
            key: _forgotPasswordFormKey,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    dkForgotpasswordText,
                    style: boldTextStyle(size: 22),
                  ),
                ),
                12.height,
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    dkForgotPasswordMsg,
                    style: primaryTextStyle(),
                  ),
                ),
                16.height,
                DKTextField(
                  hint: dkEnterYourPhoneNumber,
                  validator: (p0) {},
                  keyboardType: TextInputType.phone,
                  // onChanged: (text) => context
                  //     .read<DKRegisterDataProvider>()
                  //     .setConfirmPhoneNumber(text),
                ),
                28.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DKButtonComponent(
                      height: 35,
                      width: context.width() * 0.25,
                      onTap: backToLogin,
                      text: dkCancel,
                      gradient: dkNavigateButtonGradient,
                    ),
                    10.width,
                    DKButtonComponent(
                      height: 35,
                      width: context.width() * 0.25,
                      text: dkSubmit,
                      onTap: () async {
                        context
                            .read<DkAuthUiState>()
                            .switchFragment(const DKOTPVerificationFragment(
                              onPop: DKForgotPasswordFragment(),
                              onSuccessWidget: DKPasswordFragment(
                                  type: keyTypeForgotPassword),
                            ));
                        // provider.init();
                        // await provider.submitData(isChangePassword: isChangePassword);

                        // if (provider.credentialsModel != null) {
                        //   final bool saveToken = await saveCredentials(
                        //       credentialsData: provider.credentialsModel);
                        //   if (saveToken) {
                        //     EasyLoading.showSuccess(
                        //         provider.credentialsModel?.message ??
                        //             "Login successful");
                        //     analyzeCredentials(
                        //         context: context,
                        //         token: provider.credentialsModel?.data?.token ?? "");
                        //   }
                        // } else if (provider.loginErrors != null) {
                        //   _loginFormKey.currentState!.validate();
                        // }
                      },
                      gradient: dkSubmitButtonGradient,
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
