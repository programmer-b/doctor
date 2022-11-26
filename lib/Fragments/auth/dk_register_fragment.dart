import 'package:afyadaktari/Commons/dk_colors.dart';
import 'package:afyadaktari/Commons/dk_keys.dart';
import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:afyadaktari/Components/dk_button_component.dart';
import 'package:afyadaktari/Fragments/auth/dk_login_fragment.dart';
import 'package:afyadaktari/Fragments/auth/dk_otp_verification_fragment.dart';
import 'package:afyadaktari/Functions/auth_functions.dart';
import 'package:afyadaktari/Provider/dk_auth_ui_state.dart';
import 'package:afyadaktari/Provider/dk_register_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../Components/dk_text_field.dart';
import '../../Models/auth/dk_register_error.dart';
import '../../Utils/dk_toast.dart';

class DKRegisterFragment extends StatefulWidget {
  const DKRegisterFragment({super.key});

  @override
  State<DKRegisterFragment> createState() => _DKRegisterFragmentState();
}

class _DKRegisterFragmentState extends State<DKRegisterFragment> {
  final _registerFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await 0.seconds.delay;
    if (mounted) {
      context.read<DKRegisterDataProvider>().initialize();
    }
  }

  String? _validate(BuildContext context, String type) {
    final DKRegisterErrorModel? errors =
        context.read<DKRegisterDataProvider>().registerErrors;

    if (errors != null) {
      switch (type) {
        case keyMobile:
          List error = errors.errors?.mobile ?? [];
          if (error.isNotEmpty) {
            return error.join(" , ");
          }
          break;
        case keyConfirmMobile:
          List error = errors.errors?.confirmMobile ?? [];
          if (error.isNotEmpty) {
            return error.join(" , ");
          }
          break;
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
        case keyConfirmPassword:
          List error = errors.errors?.confirmPassword ?? [];
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
    final provider = context.read<DKRegisterDataProvider>();
    return WillPopScope(
      onWillPop: () async {
        context.read<DkAuthUiState>().switchFragment(const DKLoginFragment());
        return false;
      },
      child: SizedBox(
        width: double.infinity,
        child: Form(
          key: _registerFormKey,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  dkSignUpTitle,
                  style: boldTextStyle(size: 22),
                ),
              ),
              16.height,
              DKTextField(
                  hint: dkPhoneNumber,
                  validator: (p0) => _validate(context, keyMobile),
                  keyboardType: TextInputType.phone,
                  onChanged: (text) => context
                      .read<DKRegisterDataProvider>()
                      .setPhoneNumber(text)),
              16.height,
              DKTextField(
                hint: dkReEnterPhoneNumber,
                validator: (p0) => _validate(context, keyConfirmMobile),
                keyboardType: TextInputType.phone,
                onChanged: (text) => context
                    .read<DKRegisterDataProvider>()
                    .setConfirmPhoneNumber(text),
              ),
              16.height,
              DKTextField(
                hint: dkUsername,
                validator: (p0) => _validate(context, keyUserName),
                onChanged: (text) => provider.setusername(text),
              ),
              16.height,
              DKTextField(
                hint: dkPassword,
                validator: (p0) => _validate(context, keyPassword),
                suffixIcon: IconButton(
                  icon: context.watch<DKRegisterDataProvider>().canShowPassword
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                  onPressed: () => provider.showPassword(),
                ),
                obsecureText: provider.canShowPassword,
                onChanged: (text) => provider.setPassword(text),
              ),
              16.height,
              DKTextField(
                hint: dkReEnterPassword,
                validator: (p0) => _validate(context, keyConfirmPassword),
                suffixIcon: IconButton(
                  icon: context
                          .watch<DKRegisterDataProvider>()
                          .canShowConfirmPassword
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                  onPressed: () => context
                      .read<DKRegisterDataProvider>()
                      .showConfirmPassword(),
                ),
                obsecureText: context
                    .read<DKRegisterDataProvider>()
                    .canShowConfirmPassword,
                onChanged: (text) => context
                    .read<DKRegisterDataProvider>()
                    .setConfirmPassword(text),
              ),
              28.height,
              DKButtonComponent(
                text: dkRegisterText,
                onTap: () async {
                  provider.init();

                  await provider.submitData();

                  if (provider.credentialsModel != null) {
                    final bool saveToken = await saveCredentials(
                        credentialsData: provider.credentialsModel);
                    if (saveToken) {
                      DKToast.toastTop(
                          provider.credentialsModel?.message ??
                              "Registration successful");
                      if (mounted) {
                        context
                            .read<DkAuthUiState>()
                            .switchFragment(const DKOTPVerificationFragment());
                      }
                    }
                  } else if (provider.registerErrors != null) {
                    _registerFormKey.currentState!.validate();
                  }
                },
                gradient: dkSubmitButtonGradient,
              ),
              16.height,
              TextButton(
                  onPressed: () => context
                      .read<DkAuthUiState>()
                      .switchFragment(const DKLoginFragment()),
                  child: Text(
                    dkAlreadyHaveAnAccount,
                    style: primaryTextStyle(color: dkPrimaryColor),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
