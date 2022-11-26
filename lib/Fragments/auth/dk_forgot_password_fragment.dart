import 'package:afyadaktari/Commons/dk_colors.dart';
import 'package:afyadaktari/Commons/dk_keys.dart';
import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:afyadaktari/Fragments/auth/dk_login_fragment.dart';
import 'package:afyadaktari/Fragments/auth/dk_otp_verification_fragment.dart';
import 'package:afyadaktari/Fragments/auth/dk_password_fragment.dart';
import 'package:afyadaktari/Models/auth/dk_mobile_error_model.dart';
import 'package:afyadaktari/Models/auth/dk_mobile_success_model.dart';
import 'package:afyadaktari/Provider/dk_auth_ui_state.dart';
import 'package:afyadaktari/Provider/dk_mobile_provider.dart';
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
  String? _validate(BuildContext context, String type) {
    final DKMobileErrorModel? errors = context.read<DKMobileProvider>().errors;

    if (errors != null) {
      switch (type) {
        case keyMobile:
          List error = errors.errors?.mobile ?? [];
          if (error.isNotEmpty) {
            return error.join(" , ");
          }
          break;
      }
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => context.read<DKMobileProvider>().initialize());
  }

  Future<void> switchToOTPScreen(DKMobileSuccessModel? data) async {
    await setValue(keyTempUserId, data!.data!.userId);
    await setValue(keyTempToken, data.data!.token);
    await setValue(keyTempMobile, data.data!.phoneNumber);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => context
        .read<DkAuthUiState>()
        .switchFragment(const DKOTPVerificationFragment(
          hidePhone: true,
          onPop: DKForgotPasswordFragment(),
          onSuccessWidget: DKPasswordFragment(type: keyTypeForgotPassword),
          temp: true,
        )));
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<DKMobileProvider>();

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
                  validator: (p0) => _validate(context, keyMobile),
                  keyboardType: TextInputType.phone,
                  onChanged: (text) =>
                      context.read<DKMobileProvider>().setMobile(text),
                ),
                28.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DKButtonComponent(
                      isMin: true,
                      onTap: backToLogin,
                      text: dkCancel,
                      gradient: dkNavigateButtonGradient,
                    ),
                    10.width,
                    DKButtonComponent(
                      isMin: true,
                      text: dkSubmit,
                      onTap: () async {
                        provider.init();
                        await provider.submitData();

                        if (provider.success != null) {
                          if (mounted) {
                            hideKeyboard(context);
                            switchToOTPScreen(
                                context.read<DKMobileProvider>().success);
                          }
                        } else if (provider.errors != null) {
                          _forgotPasswordFormKey.currentState!.validate();
                        }
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
