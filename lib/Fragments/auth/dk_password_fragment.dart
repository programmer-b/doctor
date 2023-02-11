import 'package:afyadaktari/Commons/dk_keys.dart';
import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:afyadaktari/Components/dk_password_toggle.dart';
import 'package:afyadaktari/Components/dk_text_field.dart';
import 'package:afyadaktari/Fragments/auth/dk_login_fragment.dart';
import 'package:afyadaktari/Provider/dk_auth_ui_state.dart';
import 'package:afyadaktari/Provider/dk_password_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../Commons/dk_colors.dart';
import '../../Components/dk_button_component.dart';

class DKPasswordFragment extends StatefulWidget {
  const DKPasswordFragment({super.key, required this.type})
      : assert(type == keyTypeChangePassword || type == keyTypeForgotPassword);
  final String type;

  @override
  State<DKPasswordFragment> createState() => _DKPasswordFragmentState();
}

class _DKPasswordFragmentState extends State<DKPasswordFragment> {
  String? _validate(
      BuildContext context, String type, Map<String, dynamic> response) {
    if (response.isNotEmpty) {
      switch (type) {
        case keyCurrentPassword:
          List error = response[keyErrors][keyCurrentPassword] ?? [];
          if (error.isNotEmpty) {
            return error.join(" , ");
          }
          break;
        case keyNewPassword:
          List error = response[keyErrors][keyNewPassword] ?? [];
          if (error.isNotEmpty) {
            return error.join(" , ");
          }
          break;
        case keyConfirmPassword:
          List error = response[keyErrors][keyConfirmPassword] ?? [];
          if (error.isNotEmpty) {
            return error.join(" , ");
          }
          break;
      }
    }

    return null;
  }

  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();
  String get type => widget.type;

  bool oldPasswordVisible = false;
  bool newPasswordVisible = false;
  bool confirmNewPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<DKPasswordProvider>();
    bool isChangePassword = type == keyTypeChangePassword;

    void back() => isChangePassword
        ? finish(context)
        : context.read<DkAuthUiState>().switchFragment(const DKLoginFragment());

    return WillPopScope(
      onWillPop: () async {
        back();
        return false;
      },
      child: SizedBox(
        width: double.infinity,
        child: Form(
          key: _passwordFormKey,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  isChangePassword ? dkUpdatePassword : dkAddNewPassword,
                  style: boldTextStyle(size: 22),
                ),
              ),
              12.height,
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  isChangePassword
                      ? dkUpdatePasswordMsg
                      : dkEnterNewPasswordMsg,
                  style: primaryTextStyle(),
                ),
              ),
              12.height,
              if (isChangePassword)
                DKTextField(
                  validator: (value) => _validate(
                      context, keyCurrentPassword, provider.responseMap),
                  obsecureText: !oldPasswordVisible,
                  hint: dkCurrentPassword,
                  suffixIcon: DKPasswordToggle(
                    visible: !oldPasswordVisible,
                    onPressed: () => setState(
                        () => oldPasswordVisible = !oldPasswordVisible),
                  ),
                  onChanged: (text) => provider.setCurrentPassword(text),
                ),
              16.height,
              DKTextField(
                hint: dkNewPassword,
                validator: (value) => _validate(
                    context,
                    isChangePassword ? keyNewPassword : keyPassword,
                    provider.responseMap),
                obsecureText: !newPasswordVisible,
                suffixIcon: DKPasswordToggle(
                  visible: !newPasswordVisible,
                  onPressed: () =>
                      setState(() => newPasswordVisible = !newPasswordVisible),
                ),
                onChanged: (text) => provider.setNewPassword(text),
              ),
              16.height,
              DKTextField(
                hint: dkReEnterNewPassword,
                validator: (value) => _validate(
                    context, keyConfirmPassword, provider.responseMap),
                obsecureText: !confirmNewPasswordVisible,
                suffixIcon: DKPasswordToggle(
                  visible: !confirmNewPasswordVisible,
                  onPressed: () => setState(() =>
                      confirmNewPasswordVisible = !confirmNewPasswordVisible),
                ),
                onChanged: (text) => provider.setConfirmNewPassword(text),
              ),
              28.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DKButtonComponent(
                    isMin: true,
                    onTap: back,
                    text: dkCancel,
                    gradient: dkNavigateButtonGradient,
                  ),
                  10.width,
                  DKButtonComponent(
                    isMin: true,
                    text: dkConfirm,
                    onTap: () async {
                      provider.init();
                      await provider.submitData(
                          isChangePassword: isChangePassword);

                      if (provider.success) {
                        back();
                      } else if (provider.failure) {
                        _passwordFormKey.currentState!.validate();
                      }
                    },
                    gradient: dkSubmitButtonGradient,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
