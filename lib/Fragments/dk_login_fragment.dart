import 'package:afyadaktari/Commons/dk_colors.dart';
import 'package:afyadaktari/Commons/dk_keys.dart';
import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:afyadaktari/Components/dk_button_component.dart';
import 'package:afyadaktari/Components/dk_check_box_component.dart';
import 'package:afyadaktari/Components/dk_terms_desc_component.dart';
import 'package:afyadaktari/Components/dk_text_field.dart';
import 'package:afyadaktari/Fragments/dk_register_fragment.dart';
import 'package:afyadaktari/Functions/auth_functions.dart';
import 'package:afyadaktari/Models/dk_login_error_model.dart';
import 'package:afyadaktari/Provider/dk_auth_ui_state.dart';
import 'package:afyadaktari/Provider/dk_login_data_provider.dart';
import 'package:afyadaktari/Utils/dk_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class DKLoginFragment extends StatefulWidget {
  const DKLoginFragment({super.key});

  @override
  State<DKLoginFragment> createState() => _DKLoginFragmentState();
}

class _DKLoginFragmentState extends State<DKLoginFragment> {
  final _loginFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await 0.seconds.delay;
    if (mounted) {
      context.read<DKLoginDataProvider>().initialize();
    }
  }

  String? _validate(BuildContext context, String type) {
    final DKLoginErrorModel? errors =
        context.read<DKLoginDataProvider>().loginErrors;

    if (errors != null) {
      switch (type) {
        case keyUserName:
          List error = errors.errors?.username ?? [];
          if (error.isNotEmpty) {
            return error.join(" , ");
          }
          break;
        case keyPassword:
          List error = errors.errors?.password ?? [];
          if (error.isNotEmpty) {
            return error.join(" , ");
          }
          break;
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<DKLoginDataProvider>();
    return SizedBox(
      width: double.infinity,
      child: Form(
        key: _loginFormKey,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                dkSignInTitle,
                style: boldTextStyle(size: 22),
              ),
            ),
            12.height,
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                child: Text(
                  dkForgotpasswordText,
                  style: primaryTextStyle(color: dkPrimaryColor),
                ),
                onPressed: () => DKToast.toastTop("Forgot password pressed"),
              ),
            ),
            DKTextField(
                validator: (value) => _validate(context, keyUserName),
                hint: dkUsernameOrMobileText,
                onChanged: (text) => context
                    .read<DKLoginDataProvider>()
                    .setUsernameOrPassword(text)),
            16.height,
            DKTextField(
              hint: dkYourPasswordText,
              validator: (value) => _validate(context, keyPassword),
              obsecureText:
                  context.watch<DKLoginDataProvider>().canShowPassword,
              onChanged: (text) => provider.setPassword(text),
            ),
            8.height,
            const DKShowHidePasswordCheckBox(),
            28.height,
            DKButtonComponent(
              text: dkLoginText,
              onTap: () async {
                provider.init();
                await provider.submitData();

                if (provider.credentialsModel != null) {
                  final bool saveToken = await saveCredentials(
                      credentialsData: provider.credentialsModel);
                  if (saveToken) {
                    EasyLoading.showSuccess(
                        provider.credentialsModel?.message ??
                            "Login successful");
                    analyzeCredentials(
                        context: context,
                        token: provider.credentialsModel?.data?.token ?? "");
                  }
                } else if (provider.loginErrors != null) {
                  _loginFormKey.currentState!.validate();
                }
              },
              gradient: dkSubmitButtonGradient,
            ),
            16.height,
            const DKTermsDescComponent(),
            16.height,
            _forNewUsersTitle(),
            16.height,
            DKButtonComponent(
              text: dkCreateNewAccount,
              onTap: () => context
                  .read<DkAuthUiState>()
                  .switchFragment(const DKRegisterFragment()),
              gradient: dkNavigateButtonGradient,
            ),
          ],
        ),
      ),
    );
  }

  Widget _forNewUsersTitle() => Stack(
        children: [
          const Divider(
            thickness: 2,
          ),
          Container(
            alignment: Alignment.center,
            color: dkScaffoldColor,
            width: 200,
            padding: const EdgeInsets.all(4),
            child: Text(
              dkNewToAfyaDaktari,
              style: primaryTextStyle(),
            ).center(),
          ).center()
        ],
      );
}
